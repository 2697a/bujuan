import 'dart:ui';

import 'package:flutter/material.dart';

/// A backdrop widget that displaying contextual and actionable content. =]
// ignore: must_be_immutable
class WeSlide extends StatefulWidget {
  /// This is the widget that will be below as a footer,
  /// this can be used as a [BottomNavigationBar]
  final Widget? footer;

  /// This is the widget that will be on top as a AppBar,
  /// this can be used as a [AppBar]
  final Widget? appBar;

  /// This is the widget that will be hided with [Panel].
  /// You can fit any widget. This parameter is required
  final Widget body;

  /// This is the widget that will slide over the [Body].
  /// You can fit any widget.
  final Widget? panel;

  /// This is the header that will be over the [Panel].
  /// You can fit any widget.
  final Widget? panelHeader;

  /// This is the initial value that set the panel min height.
  /// If the value is greater than 0, panel will be this size over [body]
  /// By default is [150.0]. Set [0.0] if you want to hide [Panel]
  final double panelMinSize;

  /// This is the value that set the panel max height.
  /// When slide up the panel this value define the max height
  /// that panel will be over [Body]. By default is [400.0]
  /// if you want that panel cover the whole [Body], set with
  /// MediaQuery.of(context).size.height
  final double panelMaxSize;

  /// This is the value that set the panel width
  /// by default is MediaQuery.of(context).size.width
  final double? panelWidth;

  /// Set this value to create a border radius over Panel.
  /// When panelBorderRadiusBegin is diffrent from panelBorderRadiusEnd
  /// and the panel is slide up, this create an animation border over panel
  /// By default is 0.0
  final double panelBorderRadiusBegin;

  /// Set this value to create a border radius over Panel.
  /// When panelBorderRadiusBegin is diffrent from panelBorderRadiusEnd
  /// and the panel is slide up, this create an animation border over panel
  /// By default is 0.0
  final double panelBorderRadiusEnd;

  /// Set this value to create a border radius over Body.
  /// When bodyBorderRadiusBegin is diffrent from bodyBorderRadiusEnd
  /// and the panel is slide up, this create an animation border over body
  /// By default is 0.0
  final double bodyBorderRadiusBegin;

  /// Set this value to create a border radius over Body.
  /// When bodyBorderRadiusBegin is diffrent from bodyBorderRadiusEnd
  /// and the panel is slide up, this create an animation border over body.
  /// By default is 0.0
  final double bodyBorderRadiusEnd;

  /// This is the value that set the body width.
  /// By default is MediaQuery.of(context).size.width
  final double? bodyWidth;

  /// Set this value to create a parallax effect when the panel is slide up.
  /// By default is 0.1
  final double parallaxOffset;

  /// This is the value that set the footer height.
  /// by default is 60.0
  final double footerHeight;

  /// This is the value that set the appbar height.
  /// by default is 80.0
  final double appBarHeight;

  /// This is the value that defines opacity
  /// overlay effect bethen body and panel.
  final double overlayOpacity;

  /// This is the value that creates an image filter
  /// that applies a Gaussian blur.
  final double blurSigma;

  /// This is the value that defines Transform scale begin effect
  /// By default is 1.0
  final double transformScaleBegin;

  /// This is the value that defines Transform scale end effect
  /// by default is 0.9
  final double transformScaleEnd;

  /// This is the value that defines overlay color effect.
  /// By default is Colors.black
  final Color overlayColor;

  /// This is the value that defines blur color effect.
  /// By default is Colors.black
  final Color blurColor;

  /// This is the value that defines background color.
  /// By default is Colors.black end should be the same as [body]
  final Color backgroundColor;

  /// This is the value that defines if you want to hide the footer.
  /// By default is true
  final bool hideFooter;

  /// This is the value that defines if you want to hide the [panelHeader].
  /// By default is true
  final bool hidePanelHeader;

  /// This is the value that defines if you want to enable paralax effect.
  /// By default is false
  final bool parallax;

  /// This is the value that defines if you want
  /// to enable transform scale effect. By default is false
  final bool transformScale;

  /// This is the value that defines if you want
  /// to enable overlay effect. By default is false
  final bool overlay;

  /// This is the value that defines if you want
  /// to enable Gaussian blur effect. By default is false
  final bool blur;

  /// This is the value that defines if you want
  /// to enable Gaussian blur effect. By default is false
  final bool hideAppBar;

  /// The [isDismissible] parameter specifies whether the panel
  /// will be dismissed when user taps on the screen.
  final bool isDismissible;

  /// This is the value that need up sliding panel if you want
  /// to enable Slide up through panel. By default is true
  final bool isUpSlide;

  /// This is the value that create a fade transition over panel header
  final List<TweenSequenceItem<double>> fadeSequence;

  /// This is the value that sets the duration of the animation.
  /// By default is 300 milliseconds
  final Duration animateDuration;

  /// This object used to control animations, using methods like hide or show
  /// to display panel or check if is visible with variable [isOpened]
  WeSlideController? controller;

  /// This object used to control additional animation  for footer
  WeSlideController? footerController;

  /// If non-null, this callback
  /// is called as the panel slides around with the
  /// current position of the panel. The position is a double
  /// between 0.0 and 1.0 where 0.0 is fully collapsed and 1.0 is fully open.
  final void Function(double position)? onPanelSlide;

  /// WeSlide Constructor
  WeSlide({
    Key? key,
    this.footer,
    this.appBar,
    required this.body,
    this.panel,
    this.panelHeader,
    this.panelMinSize = 150.0,
    this.panelMaxSize = 400.0,
    this.panelWidth,
    this.panelBorderRadiusBegin = 0.0,
    this.panelBorderRadiusEnd = 0.0,
    this.bodyBorderRadiusBegin = 0.0,
    this.bodyBorderRadiusEnd = 0.0,
    this.bodyWidth,
    this.transformScaleBegin = 1.0,
    this.transformScaleEnd = 0.85,
    this.parallaxOffset = 0.1,
    this.overlayOpacity = 0.0,
    this.blurSigma = 5.0,
    this.overlayColor = Colors.black,
    this.blurColor = Colors.black,
    this.backgroundColor = Colors.black,
    this.footerHeight = 60.0,
    this.appBarHeight = 80.0,
    this.hideFooter = true,
    this.hidePanelHeader = true,
    this.parallax = false,
    this.transformScale = false,
    this.overlay = false,
    this.blur = false,
    this.hideAppBar = true,
    this.isDismissible = true,
    this.isUpSlide = true,
    List<TweenSequenceItem<double>>? fadeSequence,
    this.animateDuration = const Duration(milliseconds: 300),
    this.controller,
    this.footerController,
    this.onPanelSlide,
  })  : /*assert(body != null, 'body could not be null'),*/
        assert(panelMinSize >= 0.0, 'panelMinSize cannot be negative'),
        assert(footerHeight >= 0.0, 'footerHeight cannot be negative'),
        assert(appBarHeight >= 0.0, 'appBarHeight cannot be negative'),
        assert(panel != null, 'panel could not be null'),
        assert(panelMaxSize >= panelMinSize, 'panelMaxSize cannot be less than panelMinSize'),
        fadeSequence = fadeSequence ??
            [
              TweenSequenceItem<double>(weight: 1.0, tween: Tween(begin: 1, end: 0)),
              TweenSequenceItem<double>(weight: 8.0, tween: Tween(begin: 0, end: 0)),
            ],
        super(key: key) {
    if (controller == null) {
      // ignore: unnecessary_this
      this.controller = WeSlideController();
    }
    if (footerController == null) {
      // ignore: unnecessary_this
      this.footerController = WeSlideController(initial: true);
    }
  }

  @override
  _WeSlideState createState() => _WeSlideState();
}

class _WeSlideState extends State<WeSlide> with TickerProviderStateMixin {
  // Main Animation Controller
  late AnimationController _ac;

  // Panel Border Radius Effect[Tween]
  late Animation<double> _panelBorderRadius;

  // Body Border Radius Effect [Tween]
  late Animation<double> _bodyBorderRadius;

  // Scale Animation Effect [Tween]
  late Animation<double> _scaleAnimation;

  // PanelHeader animation Effect [Tween]
  late Animation<double> _fadeAnimation;

  // Footer Animation Controller
  late AnimationController _acFooter;

  // Get current controller
  WeSlideController get _effectiveController => widget.controller!;

  WeSlideController get _effectiveFooterController => widget.footerController!;

  // Check if panel is visible
  bool get _isPanelVisible => _ac.status == AnimationStatus.completed || _ac.status == AnimationStatus.forward;

  bool get _isFooterVisible => _acFooter.status == AnimationStatus.completed || _acFooter.status == AnimationStatus.forward;

  @override
  void initState() {
    // Subscribe to animated when value change
    _effectiveController.addListener(_animatedPanel);
    _effectiveFooterController.addListener(_animatedFooter);
    // Animation controller;
    _ac = AnimationController(vsync: this, duration: widget.animateDuration, value: _effectiveController.isOpened ? 1 : 0)
      ..addListener(() {
        if (widget.onPanelSlide != null) widget.onPanelSlide!(_ac.value);
      });
    _acFooter = AnimationController(vsync: this, duration: widget.animateDuration, value: _effectiveFooterController.isOpened ? 1 : 0); // show by default
    // panel Border radius animation

    _panelBorderRadius = Tween<double>(begin: widget.panelBorderRadiusBegin, end: widget.panelBorderRadiusEnd).animate(_ac);
    // body border radius animation

    _bodyBorderRadius = Tween<double>(begin: widget.bodyBorderRadiusBegin, end: widget.bodyBorderRadiusEnd).animate(_ac);
    // Transform scale animation

    _scaleAnimation = Tween<double>(begin: widget.transformScaleBegin, end: widget.transformScaleEnd).animate(_ac);
    // Fade Animation sequence
    _fadeAnimation = TweenSequence(widget.fadeSequence).animate(_ac);

    // Super Init State
    super.initState();
  }

  /// Required for resubscribing when hot reload occurs [ValueNotifier]
  @override
  void didUpdateWidget(WeSlide oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.controller?.removeListener(_animatedPanel);
    widget.controller?.addListener(_animatedPanel);
  }

  /// Animate the panel [ValueNotifier]
  void _animatedPanel() {
    if (_effectiveController.value != _isPanelVisible) {
      _ac.fling(velocity: _isPanelVisible ? -2.0 : 2.0);
    }
  }

  /// Animate the footer [ValueNotifier]
  void _animatedFooter() {
    if (_effectiveFooterController.value != _isFooterVisible) {
      _acFooter.fling(velocity: _isFooterVisible ? -2.0 : 2.0);
    }
  }

  /// Dispose
  @override
  void dispose() {
    ///Animation Controller
    _ac.dispose();
    _acFooter.dispose();

    /// ValueNotifier
    _effectiveController.dispose();
    super.dispose();
  }

  /// Gesture Vertical Update [GestureDetector]
  void _handleVerticalUpdate(DragUpdateDetails updateDetails) {
    var delta = updateDetails.primaryDelta!;
    var fractionDragged = delta / widget.panelMaxSize;
    if (widget.isUpSlide == false && _effectiveController.value == false) {
      return;
    }
    _ac.value -= 1.5 * fractionDragged;
  }

  /// Gesture Vertical End [GestureDetector]
  void _handleVerticalEnd(DragEndDetails endDetails) {
    var velocity = endDetails.primaryVelocity!;

    if (velocity > 0.0) {
      _ac.reverse().then((x) {
        _effectiveController.value = false;
      });
    } else if (velocity < 0.0) {
      if (widget.isUpSlide) {
        _ac.forward().then((x) {
          _effectiveController.value = true;
        });
      }
    } else if (_ac.value >= 0.5 && endDetails.primaryVelocity == 0.0) {
      _ac.forward().then((x) {
        _effectiveController.value = true;
      });
    } else {
      _ac.reverse().then((x) {
        _effectiveController.value = false;
      });
    }
  }

  // Get Body Animation [Paralax]
  Animation<Offset> _getAnimationOffSet({required double minSize, required double maxSize}) {
    final _closedPercentage = (widget.panelMaxSize - minSize) / widget.panelMaxSize;

    final _openPercentage = (widget.panelMaxSize - maxSize) / widget.panelMaxSize;

    return Tween<Offset>(begin: Offset(0.0, _closedPercentage), end: Offset(0.0, _openPercentage)).animate(_ac);
  }

  //Get Panel size
  double _getPanelSize() {
    var _size = 0.0;
    /* If footer is visible*/
    if (!widget.hideFooter && widget.footer != null) {
      _size += widget.footerHeight;
    }
    /* If appbar is visible*/
    if (!widget.hideAppBar && widget.appBar != null) {
      _size += widget.appBarHeight;
    }

    return _size;
  }

  /* Get panel maxsize location*/
  double _getPanelLocation() {
    var _location = widget.panelMaxSize;
    if (widget.appBar != null && !widget.hideAppBar) {
      _location += -widget.appBarHeight;
    }
    return _location;
  }

  double _getFooterOffset() {
    final offset = widget.hideFooter ? (_ac.value * -widget.footerHeight + (1 - _acFooter.value) * -widget.footerHeight) : .0;
    if (offset < -widget.footerHeight) {
      return -widget.footerHeight;
    } else if (offset > widget.footerHeight) {
      return widget.footerHeight;
    } else {
      return offset;
    }
  }

  /* Get Body location*/
  double _getBodyLocation() {
    var _location = 0.0;

    /* if appbar */
    if (widget.appBar != null) {
      _location += widget.appBarHeight;
    }

    /* if paralax*/
    if (widget.parallax) {
      _location += _ac.value * (widget.panelMaxSize - widget.panelMinSize) * -widget.parallaxOffset;
    }
    return _location;
  }

  double _getBodyHeight() {
    var _size = widget.panelMinSize;
    /* If appbar is visible*/
    if (widget.appBar != null) _size += widget.appBarHeight;

    /* if no panelMinSize value*/
    if (widget.panelMinSize == 0.0 && widget.footer != null) {
      _size += widget.footerHeight;
    }

    return _size;
  }

  @override
  Widget build(BuildContext context) {
    //Get MediaQuery Sizes
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      color: widget.backgroundColor, // Same as body,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          /** Body widget **/
          AnimatedBuilder(
            animation: Listenable.merge([_ac, _acFooter]),
            builder: (context, child) {
              return Positioned(
                top: _getBodyLocation(),
                child: Transform.scale(
                  scale: widget.transformScale ? _scaleAnimation.value : 1.0,
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_bodyBorderRadius.value),
                      topRight: Radius.circular(_bodyBorderRadius.value),
                    ),
                    child: SizedBox(
                      height: height - _getBodyHeight() - _getFooterOffset(),
                      width: widget.bodyWidth ?? width,
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: widget.body,
          ),
          /** Enable Blur Effect **/
          if (widget.blur)
            AnimatedBuilder(
              animation: _ac,
              builder: (context, _) {
                /** Fix problem with body scroll */
                if (_ac.value <= 0) return const SizedBox.shrink();
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: widget.blurSigma * _ac.value, sigmaY: widget.blurSigma * _ac.value),
                  child: Container(
                    color: widget.blurColor.withOpacity(0.1),
                  ),
                );
              },
            ),
          /** Enable Overlay Effect **/
          if (widget.overlay)
            AnimatedBuilder(
              animation: _ac,
              builder: (context, _) {
                return Container(
                  color: _ac.value == 0.0 ? null : widget.overlayColor.withOpacity(widget.overlayOpacity * _ac.value),
                );
              },
            ),
          /** Dismiss Panel **/
          ValueListenableBuilder(
            valueListenable: _effectiveController,
            builder: (_, __, ___) {
              if (_effectiveController.isOpened && widget.isDismissible) {
                return GestureDetector(
                  onTap: _effectiveController.hide,
                  child: Container(
                    color: Colors.transparent,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          /** Panel widget **/
          AnimatedBuilder(
            animation: Listenable.merge([_ac, _acFooter]),
            builder: (_, child) {
              return SlideTransition(
                position: _getAnimationOffSet(maxSize: _getPanelLocation(), minSize: widget.panelMinSize + _getFooterOffset()),
                child: GestureDetector(
                  onVerticalDragUpdate: _handleVerticalUpdate,
                  onVerticalDragEnd: _handleVerticalEnd,
                  child: AnimatedContainer(
                    height: widget.panelMaxSize,
                    width: widget.panelWidth ?? width,
                    duration: const Duration(milliseconds: 200),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_panelBorderRadius.value),
                        topRight: Radius.circular(_panelBorderRadius.value),
                      ),
                      child: child,
                    ),
                  ),
                ),
              );
            },
            child: Stack(
              children: <Widget>[
                /** Panel widget **/
                SizedBox(
                  height: height - _getPanelSize(),
                  child: widget.panel!,
                ),
                /** Panel Header widget **/
                widget.panelHeader != null && widget.hidePanelHeader
                    ? FadeTransition(
                        opacity: _fadeAnimation,
                        child: ValueListenableBuilder(
                          valueListenable: _effectiveController,
                          builder: (_, __, ___) {
                            return IgnorePointer(
                              ignoring: _effectiveController.value && widget.hidePanelHeader,
                              child: widget.panelHeader,
                            );
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
                /** panelHeader widget is null ?**/
                widget.panelHeader != null && !widget.hidePanelHeader ? widget.panelHeader! : const SizedBox.shrink(),
              ],
            ),
          ),
          // Footer Widget
          widget.footer != null
              ? AnimatedBuilder(
                  animation: Listenable.merge([_ac, _acFooter]),
                  builder: (context, child) {
                    return Positioned(
                      height: widget.footerHeight,
                      bottom: _getFooterOffset(),
                      width: MediaQuery.of(context).size.width,
                      child: widget.footer!,
                    );
                  },
                )
              : const SizedBox.shrink(),
          // AppBar
          widget.appBar != null
              ? AnimatedBuilder(
                  animation: _ac,
                  builder: (context, child) {
                    return Positioned(
                      height: widget.appBarHeight,
                      top: widget.hideAppBar ? _ac.value * -widget.appBarHeight : 0.0,
                      left: 0,
                      right: 0,
                      child: widget.appBar!,
                    );
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

/// This class used to control animations, using methods like hide or show
class WeSlideController extends ValueNotifier<bool> {
  /// WeSlideController Construction
  // ignore: avoid_positional_boolean_parameters
  WeSlideController({bool initial = false}) : super(initial);

  /// show WeSlide Panel
  void show() => value = true;

  /// hide WeSlide Panel
  void hide() => value = false;

  /// Returns if the WeSlide Panel is opened or not
  bool get isOpened => value;
}
