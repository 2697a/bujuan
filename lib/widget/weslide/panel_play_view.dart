/*
Name: Akshath Jain
Date: 3/18/2019 - 4/2/2020
Purpose: Defines the sliding_up_panel widget
Copyright: © 2020, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

import 'dart:io';
import 'dart:ui';

import 'package:bujuan/common/constants/enmu.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/play_more_info.dart';
import 'package:bujuan/widget/swipeable.dart';
import 'package:bujuan/widget/weslide/panel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/physics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../common/constants/images.dart';
import '../mobile/flashy_navbar.dart';

enum SlideDirection {
  UP,
  DOWN,
}

enum PanelState { OPEN, CLOSED }

class SlidingUpPlayViewPanel extends StatefulWidget {
  /// The Widget that slides into view. When the
  /// panel is collapsed and if [collapsed] is null,
  /// then top portion of this Widget will be displayed;
  /// otherwise, [collapsed] will be displayed overtop
  /// of this Widget. If [panel] and [panelBuilder] are both non-null,
  /// [panel] will be used.
  final Widget? panel;

  /// WARNING: This feature is still in beta and is subject to change without
  /// notice. Stability is not gauranteed. Provides a [ScrollController] and
  /// [ScrollPhysics] to attach to a scrollable object in the panel that links
  /// the panel position with the scroll position. Useful for implementing an
  /// infinite scroll behavior. If [panel] and [panelBuilder] are both non-null,
  /// [panel] will be used.
  final Widget Function(ScrollController sc)? panelBuilder;

  /// The Widget displayed overtop the [panel] when collapsed.
  /// This fades out as the panel is opened.
  final Widget? collapsed;

  /// The Widget that lies underneath the sliding panel.
  /// This Widget automatically sizes itself
  /// to fill the screen.
  final Widget? body;

  /// Optional persistent widget that floats above the [panel] and attaches
  /// to the top of the [panel]. Content at the top of the panel will be covered
  /// by this widget. Add padding to the bottom of the `panel` to
  /// avoid coverage.
  final Widget? header;

  /// Optional persistent widget that floats above the [panel] and
  /// attaches to the bottom of the [panel]. Content at the bottom of the panel
  /// will be covered by this widget. Add padding to the bottom of the `panel`
  /// to avoid coverage.
  final Widget? footer;

  /// The height of the sliding panel when fully collapsed.
  final double minHeight;

  /// The height of the sliding panel when fully open.
  final double maxHeight;

  /// A point between [minHeight] and [maxHeight] that the panel snaps to
  /// while animating. A fast swipe on the panel will disregard this point
  /// and go directly to the open/close position. This value is represented as a
  /// percentage of the total animation distance ([maxHeight] - [minHeight]),
  /// so it must be between 0.0 and 1.0, exclusive.
  final double? snapPoint;

  /// A border to draw around the sliding panel sheet.
  final Border? border;

  /// If non-null, the corners of the sliding panel sheet are rounded by this [BorderRadiusGeometry].
  final BorderRadiusGeometry? borderRadius;

  /// A list of shadows cast behind the sliding panel sheet.
  final List<BoxShadow>? boxShadow;

  /// The color to fill the background of the sliding panel sheet.
  final Color color;

  /// The amount to inset the children of the sliding panel sheet.
  final EdgeInsetsGeometry? padding;

  /// Empty space surrounding the sliding panel sheet.
  final EdgeInsetsGeometry? margin;

  /// Set to false to not to render the sheet the [panel] sits upon.
  /// This means that only the [body], [collapsed], and the [panel]
  /// Widgets will be rendered.
  /// Set this to false if you want to achieve a floating effect or
  /// want more customization over how the sliding panel
  /// looks like.
  final bool renderPanelSheet;

  /// Set to false to disable the panel from snapping open or closed.
  final bool panelSnapping;

  /// If non-null, this can be used to control the state of the panel.
  final PlayViewPanelController? controller;

  /// If non-null, shows a darkening shadow over the [body] as the panel slides open.
  final bool backdropEnabled;

  /// Shows a darkening shadow of this [Color] over the [body] as the panel slides open.
  final Color backdropColor;

  /// The opacity of the backdrop when the panel is fully open.
  /// This value can range from 0.0 to 1.0 where 0.0 is completely transparent
  /// and 1.0 is completely opaque.
  final double backdropOpacity;

  /// Flag that indicates whether or not tapping the
  /// backdrop closes the panel. Defaults to true.
  final bool backdropTapClosesPanel;

  /// If non-null, this callback
  /// is called as the panel slides around with the
  /// current position of the panel. The position is a double
  /// between 0.0 and 1.0 where 0.0 is fully collapsed and 1.0 is fully open.
  final void Function(double position)? onPanelSlide;

  /// If non-null, this callback is called when the
  /// panel is fully opened
  final VoidCallback? onPanelOpened;

  /// If non-null, this callback is called when the panel
  /// is fully collapsed.
  final VoidCallback? onPanelClosed;

  /// If non-null and true, the SlidingUpPanel exhibits a
  /// parallax effect as the panel slides up. Essentially,
  /// the body slides up as the panel slides up.
  final bool parallaxEnabled;

  /// Allows for specifying the extent of the parallax effect in terms
  /// of the percentage the panel has slid up/down. Recommended values are
  /// within 0.0 and 1.0 where 0.0 is no parallax and 1.0 mimics a
  /// one-to-one scrolling effect. Defaults to a 10% parallax.
  final double parallaxOffset;

  /// Allows toggling of the draggability of the SlidingUpPanel.
  /// Set this to false to prevent the user from being able to drag
  /// the panel up and down. Defaults to true.
  final bool isDraggable;

  /// Either SlideDirection.UP or SlideDirection.DOWN. Indicates which way
  /// the panel should slide. Defaults to UP. If set to DOWN, the panel attaches
  /// itself to the top of the screen and is fully opened when the user swipes
  /// down on the panel.
  final SlideDirection slideDirection;

  /// The default state of the panel; either PanelState.OPEN or PanelState.CLOSED.
  /// This value defaults to PanelState.CLOSED which indicates that the panel is
  /// in the closed position and must be opened. PanelState.OPEN indicates that
  /// by default the Panel is open and must be swiped closed by the user.
  final PanelState defaultPanelState;

  const SlidingUpPlayViewPanel(
      {Key? key,
      this.panel,
      this.panelBuilder,
      this.body,
      this.collapsed,
      this.minHeight = 100.0,
      this.maxHeight = 500.0,
      this.snapPoint,
      this.border,
      this.borderRadius,
      this.boxShadow = const <BoxShadow>[
        BoxShadow(
          blurRadius: 8.0,
          color: Color.fromRGBO(0, 0, 0, 0.25),
        )
      ],
      this.color = Colors.white,
      this.padding,
      this.margin,
      this.renderPanelSheet = true,
      this.panelSnapping = true,
      this.controller,
      this.backdropEnabled = false,
      this.backdropColor = Colors.black,
      this.backdropOpacity = 0.5,
      this.backdropTapClosesPanel = true,
      this.onPanelSlide,
      this.onPanelOpened,
      this.onPanelClosed,
      this.parallaxEnabled = false,
      this.parallaxOffset = 0.1,
      this.isDraggable = true,
      this.slideDirection = SlideDirection.UP,
      this.defaultPanelState = PanelState.CLOSED,
      this.header,
      this.footer})
      : assert(panel != null || panelBuilder != null),
        assert(0 <= backdropOpacity && backdropOpacity <= 1.0),
        assert(snapPoint == null || 0 < snapPoint && snapPoint < 1.0),
        super(key: key);

  @override
  SlidingUpPlayViewPanelState createState() => SlidingUpPlayViewPanelState();
}

class SlidingUpPlayViewPanelState extends State<SlidingUpPlayViewPanel> with TickerProviderStateMixin {
  late AnimationController _ac;
  late AnimationController _ac2;

  // late ScrollController _sc;

  final VelocityTracker _vt = VelocityTracker.withKind(PointerDeviceKind.touch);

  bool _isPanelVisible = true;

  final double _imageMinSize = 80.w;
  final double _imageMaxSize = 628.w;
  final double _width = 750.w;
  final double _imageTop = 80.h;

  @override
  void initState() {
    super.initState();

    _ac = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        value: widget.defaultPanelState == PanelState.CLOSED ? 0.0 : 1.0 //set the default panel state (i.e. set initial value of _ac)
        )
      ..addListener(() {
        if (widget.onPanelSlide != null) widget.onPanelSlide!(_ac.value);

        if (widget.onPanelOpened != null && _ac.value == 1.0) {
          widget.onPanelOpened!();
        }

        if (widget.onPanelClosed != null && _ac.value == 0.0) {
          widget.onPanelClosed!();
        }
      });

    _ac2 = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        value: widget.defaultPanelState == PanelState.CLOSED ? 0.0 : 1.0 //set the default panel state (i.e. set initial value of _ac)
        );

    // prevent the panel content from being scrolled only if the widget is
    // draggable and panel scrolling is enabled
    // _sc = ScrollController();
    // _sc.addListener(() {
    //   if (widget.isDraggable && !_scrollingEnabled) _sc.jumpTo(0);
    // });

    widget.controller?._addState(this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.slideDirection == SlideDirection.UP ? Alignment.bottomCenter : Alignment.topCenter,
      children: <Widget>[
        //make the back widget take up the entire back side
        widget.body != null ? widget.body ?? Container() : Container(),

        Container(),
        //the actual sliding part

        _gestureHandler(
          child: AnimatedBuilder(
            animation: _ac,
            builder: (context, child) {
              return Container(
                height: _ac.value * (widget.maxHeight - widget.minHeight) + widget.minHeight,
                margin: widget.margin,
                padding: widget.padding,
                child: child,
              );
            },
            child: Stack(
              children: <Widget>[
                //open panel
                Positioned(
                    top: widget.slideDirection == SlideDirection.UP ? 0.0 : null,
                    bottom: widget.slideDirection == SlideDirection.DOWN ? 0.0 : null,
                    width: MediaQuery.of(context).size.width - (widget.margin != null ? widget.margin!.horizontal : 0) - (widget.padding != null ? widget.padding!.horizontal : 0),
                    child: SizedBox(
                      height: widget.maxHeight,
                      child: SlidingUpPanel(
                        color: Colors.transparent,
                        controller: Home.to.panelController,
                        body: widget.panel ?? Container(),
                        onPanelSlide: (value) {
                          _ac2.value = 1 - value;
                          if (Home.to.second.value != value >= 0.3) {
                            Home.to.second.value = value > 0.3;
                          }
                        },
                        onPanelOpened: () {},
                        panel: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 130.17.w + MediaQuery.of(context).padding.bottom, left: 20.1.w, right: 20.1.w, bottom: 30.2.w),
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.all(Radius.circular(25.w)),
                              ),
                            ),
                            Obx(() {
                              return AnimatedContainer(
                                margin: EdgeInsets.only(top: 130.w + MediaQuery.of(context).padding.bottom, left: 20.w, right: 20.w, bottom: 30.w),
                                duration: const Duration(milliseconds: 150),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    !Home.to.gradientBackground.value
                                        ? Home.to.rx.value.dominantColor?.color.withOpacity(.7) ?? Colors.transparent
                                        : Home.to.rx.value.lightVibrantColor?.color.withOpacity(.7) ??
                                            Home.to.rx.value.lightMutedColor?.color.withOpacity(.7) ??
                                            Home.to.rx.value.dominantColor?.color.withOpacity(.7) ??
                                            Colors.transparent,
                                    Home.to.rx.value.dominantColor?.color.withOpacity(.7) ?? Colors.transparent,
                                  ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.all(Radius.circular(25.w)),
                                ),
                              );
                            }),
                            Padding(
                              padding: EdgeInsets.only(top: 130.w + MediaQuery.of(context).padding.bottom, bottom: 40.w),
                              child: Obx(
                                () => IndexedStack(
                                  index: Home.to.selectIndex.value,
                                  children: Home.to.pages,
                                ),
                              ),
                            )
                          ],
                        ),
                        header: SizedBox(
                          height: 130.w + MediaQuery.of(context).padding.bottom,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Obx(() => Container(
                                    width: 70.w,
                                    height: 8.w,
                                    margin: EdgeInsets.only(top: 12.w),
                                    decoration: BoxDecoration(color: Home.to.bodyColor.value.withOpacity(.3), borderRadius: BorderRadius.circular(4.w)),
                                  )),
                              FlashyNavbar(
                                height: 120.w + MediaQuery.of(context).padding.bottom,
                                selectedIndex: 0,
                                items: [
                                  FlashyNavbarItem(icon: const Icon(TablerIcons.atom_2)),
                                  FlashyNavbarItem(icon: const Icon(TablerIcons.playlist)),
                                  FlashyNavbarItem(icon: const Icon(TablerIcons.quote)),
                                  FlashyNavbarItem(icon: const Icon(TablerIcons.message_2)),
                                ],
                                onItemSelected: (index) {
                                  Home.to.selectIndex.value = index;
                                  if (Home.to.panelController.isPanelClosed) {
                                    Home.to.panelController.open();
                                  }
                                },
                                backgroundColor: Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                        maxHeight: Get.height - 130.w - MediaQuery.of(context).padding.bottom,
                        minHeight: 130.w + MediaQuery.of(context).padding.bottom,
                      ),
                    )),
                // header
                Positioned(
                  top: widget.slideDirection == SlideDirection.UP ? 0.0 : null,
                  bottom: widget.slideDirection == SlideDirection.DOWN ? 0.0 : null,
                  child: Swipeable(
                      onSwipeRight: () {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Home.to.audioServeHandler.skipToPrevious();
                        });
                      },
                      onSwipeLeft: () {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Home.to.audioServeHandler.skipToNext();
                        });
                      },
                      background: const SizedBox.shrink(),
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          width: _width,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              AnimatedBuilder(
                                animation: _ac2,
                                builder: (context, child) {
                                  return Container(
                                    margin: EdgeInsets.only(top: ((_imageTop * _ac2.value) + MediaQuery.of(context).padding.top) * _ac.value),
                                    height: Home.to.panelMobileMinSize + (_ac2.value * 528.w),
                                    child: child,
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(padding: EdgeInsets.symmetric(horizontal: 50.w)),
                                    Expanded(
                                        child: Obx(
                                      () => RichText(
                                        text: TextSpan(
                                            text: '${Home.to.mediaItem.value.title} - ',
                                            children: [
                                              TextSpan(
                                                text: Home.to.mediaItem.value.artist ?? '',
                                                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
                                              )
                                            ],
                                            style: TextStyle(
                                                fontSize: 28.sp,
                                                color: Home.to.second.value ? Home.to.bodyColor.value : Home.to.getLightTextColor(context),
                                                fontWeight: FontWeight.w500)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )),
                                    IconButton(
                                        onPressed: () => Home.to.playOrPause(),
                                        icon: Obx(() => Icon(
                                              Home.to.playing.value ? TablerIcons.player_pause : TablerIcons.player_play,
                                              size: Home.to.panelOpenPositionThan1.value && !Home.to.second.value
                                                  ? 0
                                                  : Home.to.playing.value
                                                      ? 46.w
                                                      : 42.w,
                                              color: Home.to.second.value ? Home.to.bodyColor.value : Home.to.getLightTextColor(context),
                                            )))
                                  ],
                                ),
                              ),
                              AnimatedBuilder(
                                animation: _ac2,
                                builder: (context, child) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: ((_width - _imageMaxSize - 40.w) / 2) * _ac2.value, top: ((_imageTop * _ac2.value) + MediaQuery.of(context).padding.top) * _ac.value),
                                    height: _imageMinSize + _ac2.value * (_imageMaxSize - _imageMinSize),
                                    width: _imageMinSize + _ac2.value * (_imageMaxSize - _imageMinSize),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular((_imageMinSize + _ac2.value * (_imageMaxSize - _imageMinSize)) / 2 * (1 - _ac2.value * .88)),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Obx(() {
                                  return Visibility(
                                    visible: Home.to.mediaItem.value.extras?['type'] != MediaType.local.name,
                                    replacement: ExtendedImage.file(
                                      File(Home.to.mediaItem.value.extras?['image'] ?? ''),
                                      width: _imageMaxSize,
                                      height: _imageMaxSize,
                                      fit: BoxFit.cover,
                                      loadStateChanged: (state) {
                                        Widget image;
                                        switch (state.extendedImageLoadState) {
                                          case LoadState.loading:
                                            image = Image.asset(
                                              placeholderImage,
                                              fit: BoxFit.cover,
                                            );
                                            break;
                                          case LoadState.completed:
                                            image = ExtendedRawImage(
                                              image: state.extendedImageInfo?.image,
                                              width: _imageMaxSize,
                                              height: _imageMaxSize,
                                              fit: BoxFit.cover,
                                            );
                                            break;
                                          case LoadState.failed:
                                            image = Image.asset(
                                              placeholderImage,
                                              width: _imageMaxSize,
                                              height: _imageMaxSize,
                                              fit: BoxFit.cover,
                                            );
                                            break;
                                        }
                                        return image;
                                      },
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: '${Home.to.mediaItem.value.extras?['image'] ?? ''}?param=500y500',
                                      width: _imageMaxSize,
                                      height: _imageMaxSize,
                                      fit: BoxFit.cover,
                                      useOldImageOnUrlChange: true,
                                      placeholder: (c, u) => Image.asset(
                                        placeholderImage,
                                        width: _imageMaxSize,
                                        height: _imageMaxSize,
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (c, u, e) => Image.asset(
                                        placeholderImage,
                                        width: _imageMaxSize,
                                        height: _imageMaxSize,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (!Home.to.second.value) {
                            widget.controller?.open();
                          } else {
                            Home.to.panelController.close();
                          }
                        },
                      )),
                )
              ],
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _ac2,
          builder: (context, child) {
            return Positioned(
              top: -((1 - _ac2.value) * 70.h * 2),
              child: child!,
            );
          },
          child: Container(
            height: 70.h,
            width: _width,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      widget.controller?.close();
                    },
                    icon: Obx(() => Icon(
                          TablerIcons.chevron_down,
                          color: Home.to.bodyColor.value,
                        ))),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const PlayMoreInfo(),
                        barrierColor: Colors.black87,
                      );
                    },
                    icon: Obx(() => Icon(
                          TablerIcons.brand_stackoverflow,
                          color: Home.to.bodyColor.value,
                        )))
                // Expanded(
                //   child: Obx(() => Visibility(
                //     visible: controller.topLyric.value,
                //     child: Obx(() => Text(
                //       controller.currLyric.value.fixAutoLines(),
                //       style: TextStyle(fontSize: 28.sp, color: controller.bodyColor.value),
                //       maxLines: 1,
                //       overflow: TextOverflow.ellipsis,
                //       textAlign: TextAlign.center,
                //     )),
                //   )),
                // ),
                // Obx(() => Visibility(
                //   visible: (controller.mediaItem.value.extras?['mv'] ?? 0) > 0,
                //   child: IconButton(
                //       onPressed: () {
                //         context.router.push(const MvView().copyWith(queryParams: {'mvId': controller.mediaItem.value.extras?['mv'] ?? 0}));
                //       },
                //       icon: Icon(
                //         TablerIcons.brand_youtube,
                //         color: controller.bodyColor.value,
                //       )),
                // )),
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).padding.bottom,
          ),
          onVerticalDragEnd: (e) {},
        )
        // !_isPanelVisible
        //     ? Container()
        //     : ,
      ],
    );
  }

  @override
  void dispose() {
    _ac.dispose();
    _ac2.dispose();
    super.dispose();
  }

  double _getParallax() {
    if (widget.slideDirection == SlideDirection.UP) {
      return -_ac.value * (widget.maxHeight - widget.minHeight) * widget.parallaxOffset;
    } else {
      return _ac.value * (widget.maxHeight - widget.minHeight) * widget.parallaxOffset;
    }
  }

  // returns a gesture detector if panel is used
  // and a listener if panelBuilder is used.
  // this is because the listener is designed only for use with linking the scrolling of
  // panels and using it for panels that don't want to linked scrolling yields odd results
  Widget _gestureHandler({required Widget child}) {
    // if (!widget.isDraggable) return child;

    if (widget.panel != null) {
      return GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails dets) => _onGestureSlide(dets.delta.dy),
        onVerticalDragEnd: (DragEndDetails dets) => _onGestureEnd(dets.velocity),
        child: child,
      );
    }

    return Listener(
      onPointerDown: (PointerDownEvent p) => _vt.addPosition(p.timeStamp, p.position),
      onPointerMove: (PointerMoveEvent p) {
        _vt.addPosition(p.timeStamp, p.position); // add current position for velocity tracking
        _onGestureSlide(p.delta.dy);
      },
      onPointerUp: (PointerUpEvent p) => _onGestureEnd(_vt.getVelocity()),
      child: child,
    );
  }

  // handles the sliding gesture
  void _onGestureSlide(double dy) {
    // only slide the panel if scrolling is not enabled
    if (!Home.to.second.value) {
      if (widget.slideDirection == SlideDirection.UP) {
        _ac.value -= dy / (widget.maxHeight - widget.minHeight);
        _ac2.value -= dy / (widget.maxHeight - widget.minHeight);
      } else {
        _ac.value += dy / (widget.maxHeight - widget.minHeight);
        _ac2.value += dy / (widget.maxHeight - widget.minHeight);
      }
    }

    // if the panel is open and the user hasn't scrolled, we need to determine
    // whether to enable scrolling if the user swipes up, or disable closing and
    // begin to close the panel if the user swipes down
    // if (_isPanelOpen && _sc.hasClients && _sc.offset <= 0) {
    //   setState(() {
    //     if (dy < 0) {
    //       _scrollingEnabled = true;
    //     } else {
    //       _scrollingEnabled = false;
    //     }
    //   });
    // }
  }

  // handles when user stops sliding
  void _onGestureEnd(Velocity v) {
    double minFlingVelocity = 365.0;
    double kSnap = 8;
    if (Home.to.second.value) return;
    //let the current animation finish before starting a new one
    if (_ac.isAnimating) return;
    if (_ac2.isAnimating) return;

    // if scrolling is allowed and the panel is open, we don't want to close
    // the panel if they swipe up on the scrollable
    if (_isPanelOpen) return;

    //check if the velocity is sufficient to constitute fling to end
    double visualVelocity = -v.pixelsPerSecond.dy / (widget.maxHeight - widget.minHeight);

    // reverse visual velocity to account for slide direction
    if (widget.slideDirection == SlideDirection.DOWN) {
      visualVelocity = -visualVelocity;
    }

    // get minimum distances to figure out where the panel is at
    double d2Close = _ac.value;
    double d2Open = 1 - _ac.value;
    double d2Snap = ((widget.snapPoint ?? 3) - _ac.value).abs(); // large value if null results in not every being the min
    double minDistance = min(d2Close, min(d2Snap, d2Open));

    // check if velocity is sufficient for a fling
    if (v.pixelsPerSecond.dy.abs() >= minFlingVelocity) {
      // snapPoint exists
      if (widget.panelSnapping && widget.snapPoint != null) {
        if (v.pixelsPerSecond.dy.abs() >= kSnap * minFlingVelocity || minDistance == d2Snap) {
          _ac.fling(velocity: visualVelocity);
          _ac2.fling(velocity: visualVelocity);
        } else {
          _flingPanelToPosition(widget.snapPoint!, visualVelocity);
        }

        // no snap point exists
      } else if (widget.panelSnapping) {
        _ac.fling(velocity: visualVelocity);
        _ac2.fling(velocity: visualVelocity);
        // panel snapping disabled
      } else {
        _ac.animateTo(
          _ac.value + visualVelocity * 0.16,
          duration: const Duration(milliseconds: 200),
          curve: Curves.decelerate,
        );
        _ac2.animateTo(
          _ac.value + visualVelocity * 0.16,
          duration: const Duration(milliseconds: 200),
          curve: Curves.decelerate,
        );
      }

      return;
    }

    // check if the controller is already halfway there
    if (widget.panelSnapping) {
      if (minDistance == d2Close) {
        _close();
      } else if (minDistance == d2Snap) {
        _flingPanelToPosition(widget.snapPoint!, visualVelocity);
      } else {
        _open();
      }
    }
  }

  void _flingPanelToPosition(double targetPos, double velocity) {
    final Simulation simulation = SpringSimulation(
        SpringDescription.withDampingRatio(
          mass: 1.0,
          stiffness: 500.0,
          ratio: 1.0,
        ),
        _ac.value,
        targetPos,
        velocity);

    _ac.animateWith(simulation);
    _ac2.animateWith(simulation);
  }

  //---------------------------------
  //PanelController related functions
  //---------------------------------

  //close the panel
  Future<void> _close() {
    _ac2.fling(velocity: -2.871089586513999);
    return _ac.fling(velocity: -2.871089586513999);
  }

  //open the panel
  Future<void> _open() {
    _ac2.fling(velocity: 1.5488696754064553);
    return _ac.fling(velocity: 1.5488696754064553);
  }

  //hide the panel (completely offscreen)
  Future<void> _hide() {
    return _ac.fling(velocity: -1.0).then((x) {
      setState(() {
        _isPanelVisible = false;
      });
    });
  }

  //show the panel (in collapsed mode)
  Future<void> _show() {
    return _ac.fling(velocity: -1.0).then((x) {
      setState(() {
        _isPanelVisible = true;
      });
    });
  }

  //animate the panel position to value - must
  //be between 0.0 and 1.0
  Future<void> _animatePanelToPosition(double value, {Duration? duration, Curve curve = Curves.linear}) {
    assert(0.0 <= value && value <= 1.0);
    return _ac.animateTo(value, duration: duration, curve: curve);
  }

  //animate the panel position to the snap point
  //REQUIRES that widget.snapPoint != null
  Future<void> _animatePanelToSnapPoint({Duration? duration, Curve curve = Curves.linear}) {
    assert(widget.snapPoint != null);
    return _ac.animateTo(widget.snapPoint!, duration: duration, curve: curve);
  }

  //set the panel position to value - must
  //be between 0.0 and 1.0
  set _panelPosition(double value) {
    assert(0.0 <= value && value <= 1.0);
    _ac.value = value;
  }

  //get the current panel position
  //returns the % offset from collapsed state
  //as a decimal between 0.0 and 1.0
  double get _panelPosition => _ac.value;

  //returns whether or not
  //the panel is still animating
  bool get _isPanelAnimating => _ac.isAnimating;

  //returns whether or not the
  //panel is open
  bool get _isPanelOpen => _ac.value == 1.0;

  //returns whether or not the
  //panel is closed
  bool get _isPanelClosed => _ac.value == 0.0;

  //returns whether or not the
  //panel is shown/hidden
  bool get _isPanelShown => _isPanelVisible;
}

class PlayViewPanelController {
  SlidingUpPlayViewPanelState? _panelState;

  void _addState(SlidingUpPlayViewPanelState panelState) {
    _panelState = panelState;
  }

  /// Determine if the panelController is attached to an instance
  /// of the SlidingUpPanel (this property must return true before any other
  /// functions can be used)
  bool get isAttached => _panelState != null;

  /// Closes the sliding panel to its collapsed state (i.e. to the  minHeight)
  Future<void> close() {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _panelState!._close();
  }

  /// Opens the sliding panel fully
  /// (i.e. to the maxHeight)
  Future<void> open() {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _panelState!._open();
  }

  /// Hides the sliding panel (i.e. is invisible)
  Future<void> hide() {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _panelState!._hide();
  }

  /// Shows the sliding panel in its collapsed state
  /// (i.e. "un-hide" the sliding panel)
  Future<void> show() {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _panelState!._show();
  }

  /// Animates the panel position to the value.
  /// The value must between 0.0 and 1.0
  /// where 0.0 is fully collapsed and 1.0 is completely open.
  /// (optional) duration specifies the time for the animation to complete
  /// (optional) curve specifies the easing behavior of the animation.
  Future<void> animatePanelToPosition(double value, {Duration? duration, Curve curve = Curves.linear}) {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    assert(0.0 <= value && value <= 1.0);
    return _panelState!._animatePanelToPosition(value, duration: duration, curve: curve);
  }

  /// Animates the panel position to the snap point
  /// Requires that the SlidingUpPanel snapPoint property is not null
  /// (optional) duration specifies the time for the animation to complete
  /// (optional) curve specifies the easing behavior of the animation.
  Future<void> animatePanelToSnapPoint({Duration? duration, Curve curve = Curves.linear}) {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    assert(_panelState!.widget.snapPoint != null, "SlidingUpPanel snapPoint property must not be null");
    return _panelState!._animatePanelToSnapPoint(duration: duration, curve: curve);
  }

  /// Sets the panel position (without animation).
  /// The value must between 0.0 and 1.0
  /// where 0.0 is fully collapsed and 1.0 is completely open.
  set panelPosition(double value) {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    assert(0.0 <= value && value <= 1.0);
    _panelState!._panelPosition = value;
  }

  /// Gets the current panel position.
  /// Returns the % offset from collapsed state
  /// to the open state
  /// as a decimal between 0.0 and 1.0
  /// where 0.0 is fully collapsed and
  /// 1.0 is full open.
  double get panelPosition {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _panelState!._panelPosition;
  }

  /// Returns whether or not the panel is
  /// currently animating.
  bool get isPanelAnimating {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _panelState!._isPanelAnimating;
  }

  /// Returns whether or not the
  /// panel is open.
  bool get isPanelOpen {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _panelState!._isPanelOpen;
  }

  /// Returns whether or not the
  /// panel is closed.
  bool get isPanelClosed {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _panelState!._isPanelClosed;
  }

  /// Returns whether or not the
  /// panel is shown/hidden.
  bool get isPanelShown {
    assert(isAttached, "PanelController must be attached to a SlidingUpPanel");
    return _panelState!._isPanelShown;
  }
}
