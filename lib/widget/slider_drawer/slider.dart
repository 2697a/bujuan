import 'package:bujuan/widget/slider_drawer/slider_bar.dart';
import 'package:bujuan/widget/slider_drawer/slider_direction.dart';
import 'package:flutter/widgets.dart';

import 'app_bar.dart';
import 'helper/slider_app_bar.dart';
import 'helper/slider_shadow.dart';
import 'helper/utils.dart';
import 'slider_shadow.dart';

/// SliderDrawer which have two [child] and [slider] parameter
///
///For Example :
///
/// Scaffold(
///         body: SliderDrawer(
///             appBar: SliderAppBar(
///                 appBarColor: Colors.white,
///                 title: Text(title,
///                     style: const TextStyle(
///                         fontSize: 22, fontWeight: FontWeight.w700))),
///             key: _key,
///             sliderOpenSize: 200,
///             slider: SliderView(
///               onItemClick: (title) {
///                 _key.currentState!.closeSlider();
///                 setState(() {
///                   this.title = title;
///                 });
///               },
///             ),
///             child: AuthorList()),
///       )
///
///
class SliderDrawer extends StatefulWidget {
  /// [Widget] which display when user open drawer
  ///
  final Widget slider;

  /// [Widget] rust screen widget
  ///
  final Widget child;

  /// [int] you can changes sliderDrawer open/close animation times with this [animationDuration]
  /// parameter
  ///
  final int animationDuration;

  /// [double] you can change open drawer size by this parameter [sliderOpenSize]
  ///
  final double sliderOpenSize;

  ///[double] you can change close drawer size by this parameter [sliderCloseSize]
  /// by Default it is 0. if you set 30 then drawer will not close full it will display 30 size of width always
  ///
  final double sliderCloseSize;

  ///[bool] if you set [false] then swipe to open feature disable.
  ///By Default it's true
  ///
  final bool isDraggable;

  ///[appBar] if you set [null] then it will not display app bar
  ///
  final Widget? appBar;

  /// The primary color of the button when the drawer button is in the down (pressed) state.
  /// The splash is represented as a circular overlay that appears above the
  /// [highlightColor] overlay. The splash overlay has a center point that matches
  /// the hit point of the user touch event. The splash overlay will expand to
  /// fill the button area if the touch is held for long enough time. If the splash
  /// color has transparency then the highlight and drawer button color will show through.
  ///
  /// Defaults to the Theme's splash color, [ThemeData.splashColor].
  ///
  final Color splashColor;

  ///[SliderBoxShadow] you can enable shadow of [child] Widget by this parameter
  final SliderBoxShadow? sliderBoxShadow;

  ///[slideDirection] you can change slide direction by this parameter [slideDirection]
  ///There are three type of [SlideDirection]
  ///[SlideDirection.RIGHT_TO_LEFT]
  ///[SlideDirection.LEFT_TO_RIGHT]
  ///[SlideDirection.TOP_TO_BOTTOM]
  ///
  /// By default it's [SlideDirection.LEFT_TO_RIGHT]
  ///
  final SlideDirection slideDirection;

  ///[bool] if you use CupertinoApp then it will true otherwise it will false
  ///
  final bool isCupertino;

  const SliderDrawer(
      {Key? key,
      required this.slider,
      required this.child,
      this.isDraggable = true,
      this.animationDuration = 400,
      this.sliderOpenSize = 265,
      this.splashColor = const Color(0xffffff),
      this.sliderCloseSize = 0,
      this.slideDirection = SlideDirection.LEFT_TO_RIGHT,
      this.sliderBoxShadow,
      this.appBar = const SliderAppBar(),
      this.isCupertino = false})
      : super(key: key);

  @override
  SliderDrawerState createState() => SliderDrawerState();
}

class SliderDrawerState extends State<SliderDrawer>
    with TickerProviderStateMixin {
  static const double WIDTH_GESTURE = 50.0;
  static const double HEIGHT_GESTURE = 30.0;
  static const double BLUR_SHADOW = 20.0;
  double _percent = 0.0;

  late AnimationController _animationDrawerController;
  late Animation _animation;

  bool _isDragging = false;

  /// check whether drawer is open
  bool get isDrawerOpen => _animationDrawerController.isCompleted;

  /// it's provide [animationController] for handle and lister drawer animation
  AnimationController get animationController => _animationDrawerController;

  /// Toggle drawer
  void toggle() => _animationDrawerController.isCompleted
      ? _animationDrawerController.reverse()
      : _animationDrawerController.forward();

  /// Open slider
  void openSlider() => _animationDrawerController.forward();

  /// Close slider
  void closeSlider() => _animationDrawerController.reverse();
  Color _appBarColor = Color(0xffffffff);

  @override
  void initState() {
    super.initState();

    _animationDrawerController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration));

    _animation =
        Tween<double>(begin: widget.sliderCloseSize, end: widget.sliderOpenSize)
            .animate(CurvedAnimation(
                parent: _animationDrawerController,
                curve: Curves.decelerate,
                reverseCurve: Curves.decelerate));
    if (widget.appBar is SliderAppBar) {
      _appBarColor = (widget.appBar as SliderAppBar).appBarColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      return SizedBox(
          child: Stack(children: [
        ///Menu
        SliderBar(
          slideDirection: widget.slideDirection,
          sliderMenu: widget.slider,
          sliderMenuOpenSize: widget.sliderOpenSize,
        ),

        /// Shadow
        if (widget.sliderBoxShadow != null) ...[
          SliderShadow(
            animationDrawerController: _animationDrawerController,
            slideDirection: widget.slideDirection,
            sliderOpenSize: widget.sliderOpenSize,
            animation: _animation,
            sliderBoxShadow: widget.sliderBoxShadow!,
          ),
        ],

        //Child
        AnimatedBuilder(
          animation: _animationDrawerController,
          builder: (_, child) {
            return Transform.translate(
              offset: Utils.getOffsetValues(
                  widget.slideDirection, _animation.value),
              child: child,
            );
          },
          child: GestureDetector(
            onHorizontalDragStart: _onHorizontalDragStart,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            onHorizontalDragUpdate: (detail) =>
                _onHorizontalDragUpdate(detail, constrain),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: _appBarColor,
              child: Column(
                children: <Widget>[
                  if (widget.appBar != null && widget.appBar is SliderAppBar)
                    SAppBar(
                      isCupertino: widget.isCupertino,
                      slideDirection: widget.slideDirection,
                      onTap: () => toggle(),
                      animationController: _animationDrawerController,
                      splashColor: widget.splashColor,
                      sliderAppBar: widget.appBar as SliderAppBar,
                    ),
                  if (widget.appBar != null && widget.appBar is! SliderAppBar)
                    widget.appBar!,
                  Expanded(child: widget.child),
                ],
              ),
            ),
          ),
        ),
      ]));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationDrawerController.dispose();
  }

  void _onHorizontalDragStart(DragStartDetails detail) {
    if (!widget.isDraggable) return;
    //Check use start dragging from left edge / right edge then enable dragging
    final rightSideWidthGesture =
        MediaQuery.of(context).size.width - WIDTH_GESTURE;
    if ((widget.slideDirection == SlideDirection.LEFT_TO_RIGHT &&
                detail.localPosition.dx <= WIDTH_GESTURE) ||
            (widget.slideDirection == SlideDirection.RIGHT_TO_LEFT &&
                detail.localPosition.dx >=
                    rightSideWidthGesture) /*&&
        detail.localPosition.dy <= widget.appBarHeight*/
        ) {
      this.setState(() {
        _isDragging = true;
      });
    }
    //Check use start dragging from top edge / bottom edge then enable dragging
    if (widget.slideDirection == SlideDirection.TOP_TO_BOTTOM &&
        detail.localPosition.dy >= HEIGHT_GESTURE) {
      this.setState(() {
        _isDragging = true;
      });
    }
  }

  void _onHorizontalDragEnd(DragEndDetails detail) {
    if (!widget.isDraggable) return;
    if (_isDragging) {
      openOrClose();
      setState(() {
        _isDragging = false;
      });
    }
  }

  void _onHorizontalDragUpdate(
    DragUpdateDetails detail,
    BoxConstraints constraints,
  ) {
    if (!widget.isDraggable) return;
    // Open Drawer : Slider Open -> Left/Right
    if (_isDragging &&
        (widget.slideDirection == SlideDirection.LEFT_TO_RIGHT ||
            widget.slideDirection == SlideDirection.RIGHT_TO_LEFT)) {
      var globalPosition = detail.globalPosition.dx;
      globalPosition = globalPosition < 0 ? 0 : globalPosition;
      double position = globalPosition / constraints.maxWidth;
      var realPosition = widget.slideDirection == SlideDirection.LEFT_TO_RIGHT
          ? position
          : (1 - position);
      move(realPosition);
    }
    // Open Drawer : Slider Open -> Top/Bottom
    /*if (dragging && widget.slideDirection == SlideDirection.TOP_TO_BOTTOM) {
      var globalPosition = detail.globalPosition.dx;
      globalPosition = globalPosition < 0 ? 0 : globalPosition;
      double position = globalPosition / constraints.maxHeight;
      var realPosition = widget.slideDirection == SlideDirection.TOP_TO_BOTTOM
          ? position
          : (1 - position);
      move(realPosition);
    }*/

    // Close Drawer : Slider Open -> Left/Right
    if (isDrawerOpen &&
        (widget.slideDirection == SlideDirection.LEFT_TO_RIGHT ||
            widget.slideDirection == SlideDirection.RIGHT_TO_LEFT) &&
        detail.delta.dx < 15) {
      closeSlider();
    }
  }

  move(double percent) {
    _percent = percent;
    _animationDrawerController.value = percent;
  }

  openOrClose() => _percent > 0.3 ? openSlider() : closeSlider();
}
