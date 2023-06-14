library flutter_zoom_drawer;

import 'dart:io';
import 'dart:math' show pi;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';

extension ZoomDrawerContext on BuildContext {
  /// Drawer
  _ZoomDrawerState? get drawer => ZoomDrawer.of(this);

  /// drawerLastAction
  DrawerLastAction? get drawerLastAction =>
      ZoomDrawer.of(this)?.drawerLastAction;

  /// drawerState
  DrawerState? get drawerState => ZoomDrawer.of(this)?.stateNotifier.value;

  /// drawerState notifier
  ValueNotifier<DrawerState>? get drawerStateNotifier =>
      ZoomDrawer.of(this)?.stateNotifier;

  /// Screen Width
  double get _screenWidth => MediaQuery.of(this).size.width;

  /// Screen Height
  double get _screenHeight => MediaQuery.of(this).size.height;
}

class ZoomDrawer extends StatefulWidget {
  const ZoomDrawer({
    required this.menuScreen,
    required this.mainScreen,
    this.style = DrawerStyle.defaultStyle,
    this.controller,
    this.mainScreenScale = 0.3,
    this.slideWidth = 275.0,
    this.menuScreenWidth,
    this.borderRadius = 16.0,
    this.angle = -12.0,
    this.dragOffset = 60.0,
    this.openDragSensitivity = 425,
    this.closeDragSensitivity = 425,
    this.drawerShadowsBackgroundColor = const Color(0xffffffff),
    this.menuBackgroundColor = Colors.transparent,
    this.mainScreenOverlayColor,
    this.menuScreenOverlayColor,
    this.overlayBlend = BlendMode.srcATop,
    this.overlayBlur,
    this.shadowLayer1Color,
    this.shadowLayer2Color,
    this.showShadow = false,
    this.openCurve = const Interval(0.0, 1.0, curve: Curves.easeOut),
    this.closeCurve = const Interval(0.0, 1.0, curve: Curves.easeOut),
    this.duration = const Duration(milliseconds: 250),
    this.reverseDuration = const Duration(milliseconds: 250),
    this.androidCloseOnBackTap = false,
    this.moveMenuScreen = true,
    this.disableDragGesture = false,
    this.isRtl = false,
    this.clipMainScreen = true,
    this.mainScreenTapClose = false,
    this.menuScreenTapClose = false,
    this.mainScreenAbsorbPointer = true,
    this.shrinkMainScreen = false,
    this.boxShadow,
    this.drawerStyleBuilder,
  }) : assert(angle <= 0.0 && angle >= -30.0);

  /// Layout style
  final DrawerStyle style;

  /// controller to have access to the open/close/toggle function of the drawer
  final ZoomDrawerController? controller;

  /// Screen containing the menu/bottom screen
  final Widget menuScreen;

  /// Screen containing the rust content to display
  final Widget mainScreen;

  /// MainScreen scale factor
  final double mainScreenScale;

  /// Sliding width of the drawer
  final double slideWidth;

  /// menuScreen Width
  /// Set it to double.infinity to make it take screen width
  final double? menuScreenWidth;

  /// Border radius of the slide content
  final double borderRadius;

  /// Rotation angle of the drawer
  final double angle;

  /// Background color of the menuScreen
  final Color menuBackgroundColor;

  /// Background color of the drawer shadows
  final Color drawerShadowsBackgroundColor;

  /// First shadow background color
  final Color? shadowLayer1Color;

  /// Second shadow background color
  final Color? shadowLayer2Color;

  /// Boolean, whether to show the drawer shadows - Applies to defaultStyle only
  final bool showShadow;

  /// Close drawer on android back button
  /// Note: This won't work if you are using WillPopScope in mainScreen,
  /// If that is the case, you have to manually close the drawer from there
  /// By using ZoomDrawer.of(context)?.close()
  final bool androidCloseOnBackTap;

  /// Make menuScreen slide along with mainScreen animation
  /// Has no effects to style1
  final bool moveMenuScreen;

  /// Drawer slide out curve
  final Curve openCurve;

  /// Drawer slide in curve
  final Curve closeCurve;

  /// Drawer forward Duration
  final Duration duration;

  /// Drawer reverse Duration
  final Duration reverseDuration;

  /// Disable swipe gesture
  final bool disableDragGesture;

  /// display the drawer in RTL
  final bool isRtl;

  /// Depreciated: Set [borderRadius] to 0 instead
  final bool clipMainScreen;

  /// The offset to trigger drawer drag
  final double dragOffset;

  /// How fast the opening drawer drag in response to a touch, the lower the more sensitive
  final double openDragSensitivity;

  /// How fast the closing drawer drag in response to a touch, the lower the more sensitive
  final double closeDragSensitivity;

  /// Color of the rust screen's cover overlay
  final Color? mainScreenOverlayColor;

  /// Color of the menu screen's cover overlay
  final Color? menuScreenOverlayColor;

  /// The BlendMode of the [mainScreenOverlayColor] and [menuScreenOverlayColor] filter
  final BlendMode overlayBlend;

  /// Apply a Blur amount to the mainScreen
  final double? overlayBlur;

  /// The Shadow of the mainScreenWidget
  final List<BoxShadow>? boxShadow;

  /// Close drawer when tapping menuScreen
  final bool menuScreenTapClose;

  /// Close drawer when tapping mainScreen
  final bool mainScreenTapClose;

  /// Prevent touches to mainScreen while drawer is open
  final bool mainScreenAbsorbPointer;

  /// Shrinks the mainScreen by [slideWidth]
  final bool shrinkMainScreen;

  /// Build custom animated style to override [DrawerStyle]
  /// ```dart
  /// drawerStyleBuilder: (context, animationValue, slideWidth, menuScreen, mainScreen) {
  ///     double slide = slideWidth * animationValue;
  ///     return Stack(
  ///       children: [
  ///         menuScreen,
  ///         Transform(
  ///           transform: Matrix4.identity()..translate(slide),
  ///           alignment: Alignment.center,
  ///           child: mainScreen,
  ///         )]);
  ///   },
  /// ```
  final DrawerStyleBuilder? drawerStyleBuilder;

  @override
  _ZoomDrawerState createState() => _ZoomDrawerState();

  /// static function to provide the drawer state
  static _ZoomDrawerState? of(BuildContext context) {
    return context.findAncestorStateOfType<State<ZoomDrawer>>()
        as _ZoomDrawerState?;
  }
}

class _ZoomDrawerState extends State<ZoomDrawer>
    with SingleTickerProviderStateMixin {
  /// Triggers drag animation
  bool _shouldDrag = false;

  /// Decides where the drawer will reside in screen
  late int _slideDirection;

  /// Once drawer is open, _absorbingMainScreen will absorb any pointer to avoid
  /// mainScreen interactions
  late final ValueNotifier<bool> _absorbingMainScreen;

  /// Drawer state
  final ValueNotifier<DrawerState> _stateNotifier =
      ValueNotifier(DrawerState.closed);

  ValueNotifier<DrawerState> get stateNotifier => _stateNotifier;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: widget.duration,
    reverseDuration: widget.duration,
  )..addStatusListener(_animationStatusListener);

  double get animationValue => _animationController.value;

  /// Is similar to DrawerState but with only (open, closed) values
  /// Very useful case you want to know the drawer is either open or closed
  DrawerLastAction _drawerLastAction = DrawerLastAction.closed;

  DrawerLastAction get drawerLastAction => _drawerLastAction;

  /// Check whether drawer is open
  bool isOpen() => stateNotifier.value == DrawerState.open;

  /// Decides if drag animation should start according to dragOffset
  void _onHorizontalDragStart(DragStartDetails startDetails) {
    // Offset required to to open drawer
    final _maxDragSlide = widget.isRtl
        ? context._screenWidth - widget.dragOffset
        : widget.dragOffset;

    // Will help us to set the offset according to RTL value
    // Without this user can open the drawer without respecing initial offset required
    final _toggleValue = widget.isRtl
        ? _animationController.isCompleted
        : _animationController.isDismissed;

    final _isDraggingFromLeft =
        _toggleValue && startDetails.globalPosition.dx < _maxDragSlide;

    final _isDraggingFromRight =
        !_toggleValue && startDetails.globalPosition.dx > _maxDragSlide;

    _shouldDrag = _isDraggingFromLeft || _isDraggingFromRight;
  }

  /// Update animation value continuesly upon draging.
  void _onHorizontalDragUpdate(DragUpdateDetails updateDetails) {
    /// Drag animation can be triggered when _shouldDrag is true,
    /// or when DrawerState is opening or closing
    if (_shouldDrag == false &&
        ![DrawerState.opening, DrawerState.closing]
            .contains(_stateNotifier.value)) {
      return;
    }

    final _dragSensitivity = drawerLastAction == DrawerLastAction.open
        ? widget.closeDragSensitivity
        : widget.openDragSensitivity;

    final _delta = updateDetails.primaryDelta ?? 0 / widget.dragOffset;

    if (widget.isRtl) {
      _animationController.value -= _delta / _dragSensitivity;
    } else {
      _animationController.value += _delta / _dragSensitivity;
    }
  }

  /// Case _onHorizontalDragUpdate didn't complete its full drawer animation
  /// _onHorizontalDragEnd will decide where the drawer reside
  /// Whether continue to its destination or return to initial position
  void _onHorizontalDragEnd(DragEndDetails dragEndDetails) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }

    /// Min swipe strength
    const _minFlingVelocity = 350.0;

    /// Actual swipe strength
    final _dragVelocity = dragEndDetails.velocity.pixelsPerSecond.dx.abs();

    // Shall drawer continue to its destination?
    final _willFling = _dragVelocity > _minFlingVelocity;

    if (_willFling) {
      // Strong swipe will cause the animation continue to its destination
      final _visualVelocityInPx = dragEndDetails.velocity.pixelsPerSecond.dx /
          (context._screenWidth * 50);

      final _visualVelocityInPxRTL = -_visualVelocityInPx;

      _animationController.fling(
        velocity: widget.isRtl ? _visualVelocityInPxRTL : _visualVelocityInPx,
        animationBehavior: AnimationBehavior.preserve,
      );
    }

    /// We use DrawerLastAction instead of DrawerState,
    /// because on draging, Drawer state is always equal to DrawerState.opening.
    /// User must pass 35% of animation value to proceed the full animation,
    /// Otherwise, it will return to initial position
    else if (drawerLastAction == DrawerLastAction.open) {
      // Because drawer is open, Animation value starts from 1.0 to 0
      if (_animationController.value > 0.65) {
        // User have not passed 35% of animation value
        // Return back to initial position
        open();
        return;
      }
      // Continue animation to close the drawer
      close();
    } else if (drawerLastAction == DrawerLastAction.closed) {
      // Because drawer is closed, Animation value starts from 0 to 1.0
      if (_animationController.value < 0.35) {
        // User have not passed 35% of animation value
        // Return back to initial position
        close();
        return;
      }
      // Continue animation to open the drawer
      open();
    }
  }

  /// Close drawer on Tap
  void _mainScreenTapHandler() {
    if (widget.mainScreenTapClose && stateNotifier.value == DrawerState.open) {
      return close();
    }
  }

  void _menuScreenTapHandler() {
    if (widget.menuScreenTapClose && stateNotifier.value == DrawerState.open) {
      return close();
    }
  }

  /// Open drawer
  void open() {
    if (mounted) {
      _animationController.forward();
    }
  }

  /// Close drawer
  void close() {
    if (mounted) {
      _animationController.reverse();
    }
  }

  /// Toggle drawer,
  /// forceToggle: Will toggle even if it's currently animating - defaults to false
  void toggle({bool forceToggle = false}) {
    /// We use DrawerLastAction instead of DrawerState,
    /// because on draging, Drawer state is always equal to DrawerState.opening
    if (stateNotifier.value == DrawerState.open ||
        (forceToggle && drawerLastAction == DrawerLastAction.open)) {
      close();
    } else if (stateNotifier.value == DrawerState.closed ||
        (forceToggle && drawerLastAction == DrawerLastAction.closed)) {
      open();
    }
  }

  /// Assign widget methods to controller
  void _assignToController() {
    if (widget.controller == null) return;

    widget.controller!.open = open;
    widget.controller!.close = close;
    widget.controller!.toggle = toggle;
    widget.controller!.isOpen = isOpen;
    widget.controller!.stateNotifier = stateNotifier;
  }

  /// Updates stateNotifier, drawerLastAction, and _absorbingMainScreen
  void _animationStatusListener(AnimationStatus status) {
    switch (status) {

      /// The to animation.fling causes the AnimationStatus to be
      /// emmitted with forward & reverse for the same action
      /// Adding a check to determine if the drawer is in the process of opening or closing
      case AnimationStatus.forward:
        if (drawerLastAction == DrawerLastAction.open &&
            _animationController.value < 1) {
          _stateNotifier.value = DrawerState.closing;
        } else {
          _stateNotifier.value = DrawerState.opening;
        }
        break;
      case AnimationStatus.reverse:
        if (drawerLastAction == DrawerLastAction.closed &&
            _animationController.value > 0) {
          _stateNotifier.value = DrawerState.opening;
        } else {
          _stateNotifier.value = DrawerState.closing;
        }
        break;
      case AnimationStatus.completed:
        _stateNotifier.value = DrawerState.open;
        _drawerLastAction = DrawerLastAction.open;
        _absorbingMainScreen.value = widget.mainScreenAbsorbPointer;
        break;
      case AnimationStatus.dismissed:
        _stateNotifier.value = DrawerState.closed;
        _drawerLastAction = DrawerLastAction.closed;
        _absorbingMainScreen.value = false;
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    _absorbingMainScreen = ValueNotifier(widget.mainScreenAbsorbPointer);

    _assignToController();

    _slideDirection = widget.isRtl ? -1 : 1;
  }

  @override
  void didUpdateWidget(covariant ZoomDrawer oldWidget) {
    if (oldWidget.isRtl != widget.isRtl) {
      _slideDirection = widget.isRtl ? -1 : 1;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _stateNotifier.dispose();
    _absorbingMainScreen.dispose();
    _animationController.dispose();
    super.dispose();
  }

  /// Build the widget based on the animation value
  ///
  /// * [container] is the widget to be displayed
  ///
  /// * [angle] is the the Z rotation angle
  ///
  /// * [scale] is a string to help identify this animation during
  ///   debugging (used by [toString]).
  ///
  /// * [slide] is the sliding amount of the drawer
  ///
  Widget _applyDefaultStyle(
    Widget? child, {
    double? angle,
    double scale = 1,
    double slide = 0,
  }) {
    double _slidePercent;
    double _scalePercent;

    /// Determine current slide percent based on the MenuStatus
    switch (stateNotifier.value) {
      case DrawerState.closed:
        _slidePercent = 0.0;
        _scalePercent = 0.0;
        break;
      case DrawerState.open:
        _slidePercent = 1.0;
        _scalePercent = 1.0;
        break;
      case DrawerState.opening:
        _slidePercent = (widget.openCurve).transform(animationValue);
        _scalePercent = Interval(0.0, 0.3, curve: widget.openCurve)
            .transform(animationValue);
        break;
      case DrawerState.closing:
        _slidePercent = (widget.closeCurve).transform(animationValue);
        _scalePercent = Interval(0.0, 1.0, curve: widget.closeCurve)
            .transform(animationValue);
        break;
    }

    /// Sliding
    final _xPosition =
        ((widget.slideWidth - slide) * animationValue * _slideDirection) *
            _slidePercent;

    /// Scale
    final _scalePercentage = scale - (widget.mainScreenScale * _scalePercent);

    /// BorderRadius
    final _radius = widget.borderRadius * animationValue;

    /// Rotation
    final _rotationAngle =
        ((((angle ?? widget.angle) * pi) / 180) * animationValue) *
            _slideDirection;

    return Transform(
      transform: Matrix4.translationValues(_xPosition, 0.0, 0.0)
        ..rotateZ(_rotationAngle)
        ..scale(_scalePercentage, _scalePercentage),
      alignment: widget.isRtl ? Alignment.centerRight : Alignment.centerLeft,

      // We exclude mainScreen from ClipRRect because it already has borderRadius applied
      // Only mainScreen has Scale of 1 while others has < 1
      // We apply borderRadius to shadowLayer1Color and shadowLayer2Color
      child: scale == 1
          ? child
          : ClipRRect(
              borderRadius: BorderRadius.circular(_radius),
              child: child,
            ),
    );
  }

  /// Builds the layers of menuScreen
  Widget get menuScreenWidget {
    // Add layer - GestureDetector
    Widget _menuScreen = GestureDetector(
      behavior: HitTestBehavior.translucent,
      // onTap shouldn't be null to avoid loosing state
      onTap: _menuScreenTapHandler,
      // Full width and hight to make menuScreen behind mainScreen
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        // Without Align, SizedBox won't work
        child: Align(
          alignment: widget.isRtl ? Alignment.topRight : Alignment.topLeft,
          // By default menuScreen width is calculated based on slideWidth
          // Unless user set menuScreenWidth
          child: SizedBox(
            width: widget.menuScreenWidth ??
                widget.slideWidth -
                    (context._screenWidth / widget.slideWidth) -
                    20,
            child: widget.menuScreen,
          ),
        ),
      ),
    );

    // Add layer - Transform
    if (widget.moveMenuScreen && widget.style != DrawerStyle.style1) {
      final _left = (1 - animationValue) * widget.slideWidth * _slideDirection;
      _menuScreen = Transform.translate(
        offset: Offset(-_left, 0),
        child: _menuScreen,
      );
    }
    // Add layer - Overlay color
    // Material widget needs to be set after ColorFilter,
    // Storing Material widget in variable will make
    // ColorFiltered renders only 50% of the width
    if (widget.menuScreenOverlayColor != null) {
      final _overlayColor = ColorTween(
        begin: widget.menuScreenOverlayColor,
        end: widget.menuScreenOverlayColor!.withOpacity(0.0),
      );

      _menuScreen = ColorFiltered(
        colorFilter: ColorFilter.mode(
          _overlayColor.lerp(animationValue)!,
          widget.overlayBlend,
        ),
        child: Material(
          color: widget.menuBackgroundColor,
          child: _menuScreen,
        ),
      );
    } else {
      _menuScreen = Material(
        color: widget.menuBackgroundColor,
        child: _menuScreen,
      );
    }

    return _menuScreen;
  }

  /// Builds the layers of mainScreen
  Widget get mainScreenWidget {
    Widget _mainScreen = widget.mainScreen;

    // Add layer - Shrink Screen
    if (widget.shrinkMainScreen) {
      final _mainSize =
          context._screenWidth - (widget.slideWidth * animationValue);
      _mainScreen = SizedBox(
        width: _mainSize,
        child: _mainScreen,
      );
    }

    // Add layer - Overlay color
    if (widget.mainScreenOverlayColor != null) {
      final _overlayColor = ColorTween(
        begin: widget.mainScreenOverlayColor!.withOpacity(0.0),
        end: widget.mainScreenOverlayColor,
      );
      _mainScreen = ColorFiltered(
        colorFilter: ColorFilter.mode(
          _overlayColor.lerp(animationValue)!,
          widget.overlayBlend,
        ),
        child: _mainScreen,
      );
    }

    // Add layer - Border radius
    if (widget.borderRadius != 0) {
      final _borderRadius = widget.borderRadius * animationValue;
      _mainScreen = ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: _mainScreen,
      );
    }

    // Add layer - Box shadow
    if (widget.boxShadow != null) {
      final _radius = widget.borderRadius * animationValue;

      _mainScreen = Container(
        margin: EdgeInsets.all(8.0 * animationValue),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius),
          boxShadow: widget.boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 5,
                )
              ],
        ),
        child: _mainScreen,
      );
    }

    // Add layer - Angle
    if (widget.angle != 0 && widget.style != DrawerStyle.defaultStyle) {
      final _rotationAngle =
          (((widget.angle) * pi * _slideDirection) / 180) * animationValue;
      _mainScreen = Transform.rotate(
        angle: _rotationAngle,
        alignment: widget.isRtl
            ? AlignmentDirectional.topEnd
            : AlignmentDirectional.topStart,
        child: _mainScreen,
      );
    }

    // Add layer - Overlay blur
    if (widget.overlayBlur != null) {
      final _blurAmount = widget.overlayBlur! * animationValue;
      _mainScreen = ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: _blurAmount,
          sigmaY: _blurAmount,
        ),
        child: _mainScreen,
      );
    }

    // Add layer - AbsorbPointer
    /// Prevents touches to mainScreen while drawer is open
    if (widget.mainScreenAbsorbPointer) {
      _mainScreen = Stack(
        children: [
          _mainScreen,
          ValueListenableBuilder(
            valueListenable: _absorbingMainScreen,
            builder: (_, bool _valueNotifier, ___) {
              if (_valueNotifier && stateNotifier.value == DrawerState.open) {
                return AbsorbPointer(
                  child: Container(
                    color: Colors.transparent,
                    width: context._screenWidth,
                    height: context._screenHeight,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      );
    }

    // Add layer - GestureDetector
    if (widget.mainScreenTapClose) {
      _mainScreen = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _mainScreenTapHandler,
        child: _mainScreen,
      );
    }

    return _mainScreen;
  }

  @override
  Widget build(BuildContext context) => _renderLayout();

  Widget _renderLayout() {
    Widget _parentWidget;

    if (widget.drawerStyleBuilder != null) {
      _parentWidget = _renderCustomStyle();
    } else {
      switch (widget.style) {
        case DrawerStyle.style1:
          _parentWidget = _renderStyle1();
          break;
        case DrawerStyle.style2:
          _parentWidget = _renderStyle2();
          break;
        case DrawerStyle.style3:
          _parentWidget = _renderStyle3();
          break;
        case DrawerStyle.style4:
          _parentWidget = _renderStyle4();
          break;
        default:
          _parentWidget = _renderDefault();
      }
    }

    // Add layer - GestureDetector
    if (!widget.disableDragGesture) {
      _parentWidget = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragStart: _onHorizontalDragStart,
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragEnd: _onHorizontalDragEnd,
        child: _parentWidget,
      );
    }

    // Add layer - WillPopScope
    if (!kIsWeb && Platform.isAndroid && widget.androidCloseOnBackTap) {
      _parentWidget = WillPopScope(
        onWillPop: () async {
          // Case drawer is opened or will open, either way will close
          if ([DrawerState.open, DrawerState.opening]
              .contains(stateNotifier.value)) {
            close();
            return false;
          }
          return true;
        },
        child: _parentWidget,
      );
    }

    return _parentWidget;
  }

  Widget _renderCustomStyle() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        return widget.drawerStyleBuilder!(
          context,
          animationValue,
          widget.slideWidth,
          menuScreenWidget,
          mainScreenWidget,
        );
      },
    );
  }

  Widget _renderDefault() {
    const _slidePercent = 10.0;

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) => menuScreenWidget,
        ),
        if (widget.showShadow) ...[
          /// Displaying the first shadow
          AnimatedBuilder(
            animation: _animationController,
            builder: (_, w) => _applyDefaultStyle(
              w,
              angle: (widget.angle == 0.0) ? 0.0 : widget.angle - 8,
              scale: .9,
              slide: _slidePercent * 2,
            ),
            child: Container(
              color: widget.shadowLayer1Color ??
                  widget.drawerShadowsBackgroundColor.withAlpha(60),
            ),
          ),

          /// Displaying the second shadow
          AnimatedBuilder(
            animation: _animationController,
            builder: (_, w) => _applyDefaultStyle(
              w,
              angle: (widget.angle == 0.0) ? 0.0 : widget.angle - 4.0,
              scale: .95,
              slide: _slidePercent,
            ),
            child: Container(
              color: widget.shadowLayer2Color ??
                  widget.drawerShadowsBackgroundColor.withAlpha(90),
            ),
          )
        ],

        /// Displaying the Main screen
        AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) => _applyDefaultStyle(
            mainScreenWidget,
          ),
        ),
      ],
    );
  }

  Widget _renderStyle1() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        final _xOffset =
            (1 - animationValue) * widget.slideWidth * _slideDirection;

        return Stack(
          children: [
            mainScreenWidget,
            Transform.translate(
              offset: Offset(-_xOffset, 0),
              child: Container(
                width: widget.slideWidth,
                color: widget.menuBackgroundColor,
                child: menuScreenWidget,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _renderStyle2() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        final _xPosition = widget.slideWidth * _slideDirection * animationValue;
        final _yPosition = animationValue * widget.slideWidth;
        final _scalePercentage = 1 - (animationValue * widget.mainScreenScale);

        return Stack(
          children: [
            menuScreenWidget,
            Transform(
              transform: Matrix4.identity()
                ..translate(_xPosition, _yPosition)
                ..scale(_scalePercentage),
              alignment: Alignment.center,
              child: mainScreenWidget,
            ),
          ],
        );
      },
    );
  }

  Widget _renderStyle3() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        final _xPosition =
            (widget.slideWidth / 2) * animationValue * _slideDirection;
        final _scalePercentage = 1 - (animationValue * widget.mainScreenScale);
        final _yAngle = animationValue * (pi / 4) * _slideDirection;

        return Stack(
          children: [
            menuScreenWidget,
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0009)
                ..translate(_xPosition)
                ..scale(_scalePercentage)
                ..rotateY(_yAngle),
              alignment:
                  widget.isRtl ? Alignment.centerLeft : Alignment.centerRight,
              child: mainScreenWidget,
            ),
          ],
        );
      },
    );
  }

  Widget _renderStyle4() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        final _xPosition =
            (widget.slideWidth * 1.2) * animationValue * _slideDirection;
        final _scalePercentage = 1 - (animationValue * widget.mainScreenScale);
        final _yAngle = animationValue * (pi / 4) * _slideDirection;

        return Stack(
          children: [
            menuScreenWidget,
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0009)
                ..translate(_xPosition)
                ..scale(_scalePercentage)
                ..rotateY(-_yAngle),
              alignment:
                  widget.isRtl ? Alignment.centerRight : Alignment.centerLeft,
              child: mainScreenWidget,
            ),
          ],
        );
      },
    );
  }
}
