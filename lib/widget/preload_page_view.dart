import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A controller for [PreloadPageView].
///
/// A page controller lets you manipulate which page is visible in a [PreloadPageView].
/// In addition to being able to control the pixel offset of the content inside
/// the [PreloadPageView], a [PreloadPageController] also lets you control the offset in terms
/// of pages, which are increments of the viewport size.
///
/// See also:
///
///  * [PreloadPageView], which is the widget this object controls.
class PreloadPageController extends ScrollController {
  /// Creates a page controller.
  ///
  /// The [initialPage], [keepPage], and [viewportFraction] arguments must not be null.
  PreloadPageController({
    this.initialPage = 0,
    this.keepPage = true,
    this.viewportFraction = 1.0,
  })  : assert(initialPage != null),
        assert(keepPage != null),
        assert(viewportFraction != null),
        assert(viewportFraction > 0.0);

  /// The page to show when first creating the [PreloadPageView].
  final int initialPage;

  /// Save the current [page] with [PageStorage] and restore it if
  /// this controller's scrollable is recreated.
  ///
  /// If this property is set to false, the current [page] is never saved
  /// and [initialPage] is always used to initialize the scroll offset.
  /// If true (the default), the initial page is used the first time the
  /// controller's scrollable is created, since there's isn't a page to
  /// restore yet. Subsequently the saved page is restored and
  /// [initialPage] is ignored.
  ///
  /// See also:
  ///
  ///  * [PageStorageKey], which should be used when more than one
  ///    scrollable appears in the same route, to distinguish the [PageStorage]
  ///    locations used to save scroll offsets.
  final bool keepPage;

  /// The fraction of the viewport that each page should occupy.
  ///
  /// Defaults to 1.0, which means each page fills the viewport in the scrolling
  /// direction.
  final double viewportFraction;

  /// The current page displayed in the controlled [PreloadPageView].
  ///
  /// There are circumstances that this [PreloadPageController] can't know the current
  /// page. Reading [page] will throw an [AssertionError] in the following cases:
  ///
  /// 1. No [PreloadPageView] is currently using this [PreloadPageController]. Once a
  /// [PreloadPageView] starts using this [PreloadPageController], the new [page]
  /// position will be derived:
  ///
  ///   * First, based on the attached [PreloadPageView]'s [BuildContext] and the
  ///     position saved at that context's [PageStorage] if [keepPage] is true.
  ///   * Second, from the [PreloadPageController]'s [initialPage].
  ///
  /// 2. More than one [PreloadPageView] using the same [PreloadPageController].
  ///
  /// The [hasClients] property can be used to check if a [PreloadPageView] is attached
  /// prior to accessing [page].
  double get page {
    assert(positions.isNotEmpty,
    'PageController.page cannot be accessed before a PageView is built with it.',);
    assert(
    positions.length == 1,
    'The page property cannot be read when multiple PageViews are attached to '
        'the same PageController.',);
    final _PagePosition position = this.position;
    return position.page;
  }

  /// Animates the controlled [PreloadPageView] from the current page to the given page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  ///
  /// The `duration` and `curve` arguments must not be null.
  Future<void> animateToPage(
      int page, {
        @required Duration duration,
        @required Curve curve,
      }) {
    final _PagePosition position = this.position;
    return position.animateTo(
      position.getPixelsFromPage(page.toDouble()),
      duration: duration,
      curve: curve,
    );
  }

  /// Changes which page is displayed in the controlled [PreloadPageView].
  ///
  /// Jumps the page position from its current value to the given value,
  /// without animation, and without checking if the new value is in range.
  void jumpToPage(int page) {
    final _PagePosition position = this.position;
    position.jumpTo(position.getPixelsFromPage(page.toDouble()));
  }

  /// Animates the controlled [PreloadPageView] to the next page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  ///
  /// The `duration` and `curve` arguments must not be null.
  Future<void> nextPage({@required Duration duration, @required Curve curve}) {
    return animateToPage(page.round() + 1, duration: duration, curve: curve);
  }

  /// Animates the controlled [PreloadPageView] to the previous page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  ///
  /// The `duration` and `curve` arguments must not be null.
  Future<void> previousPage(
      {@required Duration duration, @required Curve curve}) {
    return animateToPage(page.round() - 1, duration: duration, curve: curve);
  }

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics,
      ScrollContext context, ScrollPosition oldPosition) {
    return _PagePosition(
      physics: physics,
      context: context,
      initialPage: initialPage,
      keepPage: keepPage,
      viewportFraction: viewportFraction,
      oldPosition: oldPosition,
    );
  }

  @override
  void attach(ScrollPosition position) {
    super.attach(position);
    final _PagePosition pagePosition = position;
    pagePosition.viewportFraction = viewportFraction;
  }
}

/// Metrics for a [PreloadPageView].
///
/// The metrics are available on [ScrollNotification]s generated from
/// [PreloadPageView]s.
class PageMetrics extends FixedScrollMetrics {
  /// Creates an immutable snapshot of values associated with a [PreloadPageView].
  PageMetrics({
    @required double minScrollExtent,
    @required double maxScrollExtent,
    @required double pixels,
    @required double viewportDimension,
    @required AxisDirection axisDirection,
    @required this.viewportFraction,
  }) : super(
    minScrollExtent: minScrollExtent,
    maxScrollExtent: maxScrollExtent,
    pixels: pixels,
    viewportDimension: viewportDimension,
    axisDirection: axisDirection,
  );

  @override
  PageMetrics copyWith({
    double minScrollExtent,
    double maxScrollExtent,
    double pixels,
    double viewportDimension,
    AxisDirection axisDirection,
    double viewportFraction,
  }) {
    return PageMetrics(
      minScrollExtent: minScrollExtent ?? this.minScrollExtent,
      maxScrollExtent: maxScrollExtent ?? this.maxScrollExtent,
      pixels: pixels ?? this.pixels,
      viewportDimension: viewportDimension ?? this.viewportDimension,
      axisDirection: axisDirection ?? this.axisDirection,
      viewportFraction: viewportFraction ?? this.viewportFraction,
    );
  }

  /// The current page displayed in the [PreloadPageView].
  double get page {
    return math.max(0.0, pixels.clamp(minScrollExtent, maxScrollExtent)) /
        math.max(1.0, viewportDimension * viewportFraction);
  }

  /// The fraction of the viewport that each page occupies.
  ///
  /// Used to compute [page] from the current [pixels].
  final double viewportFraction;
}

class _PagePosition extends ScrollPositionWithSingleContext implements PageMetrics {
  _PagePosition({
    ScrollPhysics physics,
    ScrollContext context,
    this.initialPage = 0,
    bool keepPage = true,
    double viewportFraction = 1.0,
    ScrollPosition oldPosition,
  })  : assert(initialPage != null),
        assert(keepPage != null),
        assert(viewportFraction != null),
        assert(viewportFraction > 0.0),
        _viewportFraction = viewportFraction,
        _pageToUseOnStartup = initialPage.toDouble(),
        super(
        physics: physics,
        context: context,
        initialPixels: null,
        keepScrollOffset: keepPage,
        oldPosition: oldPosition,
      );

  final int initialPage;
  double _pageToUseOnStartup;

  @override
  double get viewportFraction => _viewportFraction;
  double _viewportFraction;

  set viewportFraction(double value) {
    if (_viewportFraction == value) return;
    final double oldPage = page;
    _viewportFraction = value;
    if (oldPage != null) forcePixels(getPixelsFromPage(oldPage));
  }

  double getPageFromPixels(double pixels, double viewportDimension) {
    return math.max(0.0, pixels) / math.max(1.0, viewportDimension * viewportFraction);
  }

  double getPixelsFromPage(double page) {
    return page * ((hasViewportDimension == true) ? viewportDimension : 0) * viewportFraction;
  }

  @override
  double get page => (hasPixels == false)
      ? null
      : getPageFromPixels(
    pixels.clamp((hasContentDimensions == true) ? minScrollExtent : null, (hasContentDimensions == true) ? maxScrollExtent : null),
    (hasViewportDimension == true) ? viewportDimension : null,
  );

  @override
  void saveScrollOffset() {
    PageStorage.of(context.storageContext)
        ?.writeState(context.storageContext, getPageFromPixels((hasPixels) ? pixels : null, (hasViewportDimension) ? viewportDimension : null));
  }

  @override
  void restoreScrollOffset() {
    if (hasPixels == true) {
      final double value = PageStorage.of(context.storageContext)?.readState(context.storageContext);
      if (value != null) _pageToUseOnStartup = value;
    }
  }

  @override
  bool applyViewportDimension(double viewportDimension) {
    final double oldViewportDimensions = (hasViewportDimension) ? this.viewportDimension : null;
    final bool result = super.applyViewportDimension(viewportDimension);
    final double oldPixels = (hasPixels) ? pixels : null;
    final double page = (oldPixels == null || oldViewportDimensions == 0.0) ? _pageToUseOnStartup : getPageFromPixels(oldPixels, oldViewportDimensions);
    final double newPixels = getPixelsFromPage(page);
    if (newPixels != oldPixels) {
      correctPixels(newPixels);
      return false;
    }
    return result;
  }

  @override
  PageMetrics copyWith({
    double minScrollExtent,
    double maxScrollExtent,
    double pixels,
    double viewportDimension,
    AxisDirection axisDirection,
    double viewportFraction,
  }) {
    return PageMetrics(
      minScrollExtent: minScrollExtent ?? ((hasContentDimensions) ? this.minScrollExtent : null),
      maxScrollExtent: maxScrollExtent ?? ((hasContentDimensions) ? this.maxScrollExtent : null),
      pixels: pixels ?? ((hasPixels) ? this.pixels : null),
      viewportDimension: viewportDimension ?? ((hasViewportDimension) ? this.viewportDimension : null),
      axisDirection: axisDirection ?? this.axisDirection,
      viewportFraction: viewportFraction ?? this.viewportFraction,
    );
  }
}

/// Scroll physics used by a [PreloadPageView].
///
/// These physics cause the page view to snap to page boundaries.
///
/// See also:
///
///  * [ScrollPhysics], the base class which defines the API for scrolling
///    physics.
///  * [PreloadPageView.physics], which can override the physics used by a page view.
class PageScrollPhysics extends ScrollPhysics {
  /// Creates physics for a [PreloadPageView].
  const PageScrollPhysics({ScrollPhysics parent}) : super(parent: parent);

  @override
  PageScrollPhysics applyTo(ScrollPhysics ancestor) {
    return PageScrollPhysics(parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position) {
    if (position is _PagePosition) return position.page;
    return position.pixels / position.viewportDimension;
  }

  double _getPixels(ScrollPosition position, double page) {
    if (position is _PagePosition) return position.getPixelsFromPage(page);
    return page * position.viewportDimension;
  }

  double _getTargetPixels(
      ScrollPosition position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity)
      page -= 0.5;
    else if (velocity > tolerance.velocity) page += 0.5;
    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(SpringDescription(
        mass: 2,
        stiffness: 120,
        damping: 15,
      ), position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

// Having this global (mutable) page controller is a bit of a hack. We need it
// to plumb in the factory for _PagePosition, but it will end up accumulating
// a large list of scroll positions. As long as you don't try to actually
// control the scroll positions, everything should be fine.
final PreloadPageController _defaultPageController = PreloadPageController();
const PageScrollPhysics _kPagePhysics = PageScrollPhysics();

/// A scrollable list that works page by page.
///
/// Each child of a page view is forced to be the same size as the viewport.
///
/// You can use a [PreloadPageController] to control which page is visible in the view.
/// In addition to being able to control the pixel offset of the content inside
/// the [PreloadPageView], a [PreloadPageController] also lets you control the offset in terms
/// of pages, which are increments of the viewport size.
///
/// The [PreloadPageController] can also be used to control the
/// [PreloadPageController.initialPage], which determines which page is shown when the
/// [PreloadPageView] is first constructed, and the [PreloadPageController.viewportFraction],
/// which determines the size of the pages as a fraction of the viewport size.
///
/// See also:
///
///  * [PreloadPageController], which controls which page is visible in the view.
///  * [SingleChildScrollView], when you need to make a single child scrollable.
///  * [ListView], for a scrollable list of boxes.
///  * [GridView], for a scrollable grid of boxes.
///  * [ScrollNotification] and [NotificationListener], which can be used to watch
///    the scroll position without using a [ScrollController].
class PreloadPageView extends StatefulWidget {
  /// Creates a scrollable list that works page by page from an explicit [List]
  /// of widgets.
  ///
  /// This constructor is appropriate for page views with a small number of
  /// children because constructing the [List] requires doing work for every
  /// child that could possibly be displayed in the page view, instead of just
  /// those children that are actually visible.
  PreloadPageView({
    Key key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PreloadPageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    List<Widget> children = const <Widget>[],
    this.preloadPagesCount = 1,
  })  : controller = controller ?? _defaultPageController,
        childrenDelegate = SliverChildListDelegate(children),
        super(key: key);

  /// Creates a scrollable list that works page by page using widgets that are
  /// created on demand.
  ///
  /// This constructor is appropriate for page views with a large (or infinite)
  /// number of children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// Providing a non-null [itemCount] lets the [PreloadPageView] compute the maximum
  /// scroll extent.
  ///
  /// [itemBuilder] will be called only with indices greater than or equal to
  /// zero and less than [itemCount].
  ///
  /// You can add [preloadPagesCount] for PreloadPageView if you want preload multiple pages
  PreloadPageView.builder({
    Key key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PreloadPageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    @required IndexedWidgetBuilder itemBuilder,
    int itemCount,
    this.preloadPagesCount = 1,
  })  : controller = controller ?? _defaultPageController,
        childrenDelegate =
        SliverChildBuilderDelegate(itemBuilder, childCount: itemCount),
        super(key: key);

  /// Creates a scrollable list that works page by page with a custom child
  /// model.
  PreloadPageView.custom({
    Key key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PreloadPageController controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    @required this.childrenDelegate,
    this.preloadPagesCount = 1,
  })  : assert(childrenDelegate != null),
        controller = controller ?? _defaultPageController,
        super(key: key);

  /// The axis along which the page view scrolls.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis scrollDirection;

  /// Whether the page view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the page view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the page view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// An object that can be used to control the position to which this page
  /// view is scrolled.
  final PreloadPageController controller;

  /// How the page view should respond to user input.
  ///
  /// For example, determines how the page view continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics physics;

  /// Set to false to disable page snapping, useful for custom scroll behavior.
  final bool pageSnapping;

  /// Called whenever the page in the center of the viewport changes.
  final ValueChanged<int> onPageChanged;

  /// A delegate that provides the children for the [PreloadPageView].
  ///
  /// The [PreloadPageView.custom] constructor lets you specify this delegate
  /// explicitly. The [PreloadPageView] and [PreloadPageView.builder] constructors create a
  /// [childrenDelegate] that wraps the given [List] and [IndexedWidgetBuilder],
  /// respectively.
  final SliverChildDelegate childrenDelegate;

  /// An integer value that determines number pages that will be preloaded.
  ///
  /// [preloadPagesCount] value start from 0, default 1
  final int preloadPagesCount;

  @override
  _PreloadPageViewState createState() =>
      _PreloadPageViewState(preloadPagesCount);
}

class _PreloadPageViewState extends State<PreloadPageView> {
  int _lastReportedPage = 0;
  int _preloadPagesCount = 1;

  _PreloadPageViewState(int preloadPagesCount) {
    _validatePreloadPagesCount(preloadPagesCount);
    this._preloadPagesCount = preloadPagesCount;
  }

  @override
  void initState() {
    super.initState();
    _lastReportedPage = widget.controller.initialPage;
  }

  void _validatePreloadPagesCount(int preloadPagesCount) {
    if (preloadPagesCount == null) {
      throw 'preloadPagesCount cannot be null!';
    }

    if (preloadPagesCount < 0) {
      throw 'preloadPagesCount cannot be less than 0. Actual value: $preloadPagesCount';
    }
  }

  AxisDirection _getDirection(BuildContext context) {
    switch (widget.scrollDirection) {
      case Axis.horizontal:
        assert(debugCheckHasDirectionality(context));
        final TextDirection textDirection = Directionality.of(context);
        final AxisDirection axisDirection =
        textDirectionToAxisDirection(textDirection);
        return widget.reverse
            ? flipAxisDirection(axisDirection)
            : axisDirection;
      case Axis.vertical:
        return widget.reverse ? AxisDirection.up : AxisDirection.down;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final AxisDirection axisDirection = _getDirection(context);
    final ScrollPhysics physics = widget.pageSnapping
        ? _kPagePhysics.applyTo(widget.physics)
        : widget.physics;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0 &&
            widget.onPageChanged != null &&
            notification is ScrollEndNotification) {
          final PageMetrics metrics = notification.metrics;
          final int currentPage = metrics.page.round();
          if (currentPage != _lastReportedPage) {
            _lastReportedPage = currentPage;
            widget.onPageChanged(currentPage);
          }
        }
        return false;
      },
      child: Scrollable(
        axisDirection: axisDirection,
        controller: widget.controller,
        physics: physics,
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return Viewport(
            cacheExtent: _preloadPagesCount < 1
                ? 0
                : (_preloadPagesCount == 1
                ? 1
                : widget.scrollDirection == Axis.horizontal
                ? MediaQuery.of(context).size.width *
                _preloadPagesCount - 1
                : MediaQuery.of(context).size.height *
                _preloadPagesCount - 1),
            axisDirection: axisDirection,
            offset: position,
            slivers: <Widget>[
              SliverFillViewport(
                  viewportFraction: widget.controller.viewportFraction,
                  delegate: widget.childrenDelegate),
            ],
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description
        .add(EnumProperty<Axis>('scrollDirection', widget.scrollDirection));
    description.add(
        FlagProperty('reverse', value: widget.reverse, ifTrue: 'reversed'));
    description.add(DiagnosticsProperty<PreloadPageController>(
        'controller', widget.controller,
        showName: false));
    description.add(DiagnosticsProperty<ScrollPhysics>(
        'physics', widget.physics,
        showName: false));
    description.add(FlagProperty('pageSnapping',
        value: widget.pageSnapping, ifFalse: 'snapping disabled'));
  }
}