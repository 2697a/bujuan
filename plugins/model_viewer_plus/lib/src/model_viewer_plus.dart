import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'model_viewer_plus_stub.dart'
    if (dart.library.io) 'model_viewer_plus_mobile.dart'
    if (dart.library.js) 'model_viewer_plus_web.dart';

import 'shim/dart_html_fake.dart' if (dart.library.html) 'dart:html';

enum Loading { auto, lazy, eager }

enum Reveal { auto, interaction, manual }

enum ArScale { auto, fixed }

enum ArPlacement { floor, wall }

enum TouchAction { panY, panX, none }

enum InteractionPrompt { auto, whenFocused, none }

enum InteractionPromptStyle { wiggle, basic }

// enum ArStatus { notPresenting, sessionStarted, objectPlaced, failed }

// enum ArTracking { tracking, notTracking }

/// Flutter widget for rendering interactive 3D models.
class ModelViewer extends StatefulWidget {
  ModelViewer({
    Key? key,
    this.backgroundColor = Colors.transparent,
    required this.src,
    this.alt,
    this.poster,
    this.loading,
    this.reveal,
    this.withCredentials,
    this.ar,
    this.arModes,
    this.arScale,
    this.arPlacement,
    this.iosSrc,
    this.xrEnvironment,
    this.cameraControls = true,
    this.disablePan,
    this.disableTap,
    this.touchAction,
    this.disableZoom,
    this.orbitSensitivity,
    this.autoRotate,
    this.autoRotateDelay,
    this.rotationPerSecond,
    this.interactionPrompt,
    this.interactionPromptStyle,
    this.interactionPromptThreshold,
    this.cameraOrbit,
    this.cameraTarget,
    this.fieldOfView,
    this.maxCameraOrbit,
    this.minCameraOrbit,
    this.maxFieldOfView,
    this.minFieldOfView,
    this.interpolationDecay,
    this.skyboxImage,
    this.environmentImage,
    this.exposure,
    this.shadowIntensity,
    this.shadowSoftness,
    this.animationName,
    this.animationCrossfadeDuration,
    this.autoPlay,
    this.variantName,
    this.orientation,
    this.scale,
    // this.arStatus,
    // this.arTracking,
    this.minHotspotOpacity,
    this.maxHotspotOpacity,
    this.innerModelViewerHtml,
    this.relatedCss,
    this.relatedJs,
    this.id,
    this.overwriteNodeValidatorBuilder,
    this.javascriptChannels,
    this.onWebViewCreated,
  }) : super(key: key);

  // Loading Attributes

  /// The URL or path to the 3D model. This parameter is required.
  /// Only glTF/GLB models are supported.
  ///
  /// The parameter value must conform to the following:
  ///
  /// - `http://` and `https://` for HTTP(S) URLs
  ///   (for example, `https://modelviewer.dev/shared-assets/models/Astronaut.glb`)
  ///
  /// - `file://` for local files
  ///   (NOT AVAILABLE in Web)
  ///
  /// - a relative pathname for Flutter app assets
  ///   (for example, `assets/MyModel.glb`)
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-loading-attributes-src
  final String src;

  /// Configures the model with custom text that will be used to describe the
  /// model to viewers who use a screen reader or otherwise depend on additional
  /// semantic context to understand what they are viewing.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-loading-attributes-alt
  final String? alt;

  /// Displays an image instead of the model, useful for showing the user
  /// something before a model is loaded and ready to render. If you use a
  /// poster with transparency, you may also want to set --poster-color to
  /// transparent so that the background shows through.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-loading-attributes-poster
  final String? poster;

  /// An enumerable attribute describing under what conditions the model should
  /// be preloaded. The supported values are "auto", "lazy" and "eager". Auto is
  /// equivalent to lazy, which loads the model when it is near the viewport for
  /// reveal="auto", and when interacted with for reveal="interaction". Eager
  /// loads the model immediately.
  ///
  /// You may use the [Loading] enum to set this attribute.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-loading-attributes-loading
  final Loading? loading;

  /// This attribute controls when the model should be revealed. It currently
  /// supports three values: "auto", "interaction", and "manual". If reveal is
  /// set to "interaction", <model-viewer> will wait until the user interacts
  /// with the poster before loading and revealing the model. If reveal is set
  /// to "auto", the model will be revealed as soon as it is done loading and
  /// rendering. If reveal is set to "manual", the model will remain hidden
  /// until dismissPoster() is called.
  ///
  /// You may use the [Reveal] enum to set this attribute.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-loading-attributes-reveal
  final Reveal? reveal;

  /// This attribute makes the browser include credentials (cookies,
  /// authorization headers or TLS client certificates) in the request to fetch
  /// the 3D model. It's useful if the 3D model file is stored on another server
  /// that require authentication. By default the file will be fetch without
  /// credentials. Note that this has no effect if you are loading files locally
  /// or from the same domain.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-loading-attributes-withCredentials
  final bool? withCredentials;

  // AR Attributes

  /// Enable the ability to launch AR experiences on supported devices.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-augmentedreality-attributes-ar
  final bool? ar;

  /// A prioritized list of the types of AR experiences to enable. Allowed values are
  /// "webxr", to launch the AR experience in the browser,
  /// "scene-viewer", to launch the Scene Viewer app,
  /// "quick-look", to launch the iOS Quick Look app.
  /// You can specify any number of modes separated by whitespace.
  /// Note that the presence of an ios-src will enable quick-look by itself;
  /// specifying quick-look here allows us to generate a USDZ on the fly rather
  /// than downloading a separate ios-src file.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-augmentedreality-attributes-arModes
  final List<String>? arModes;

  /// Controls the scaling behavior in AR mode.
  /// Set to "fixed" to disable scaling of the model, which sets it to always be at 100% scale.
  /// Defaults to "auto" which allows the model to be resized by pinch.
  ///
  /// You many use the [ArScale] enum to set this attribute.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-augmentedreality-attributes-arScale
  final ArScale? arScale;

  /// Selects whether to place the object on the floor (horizontal surface) or
  /// a wall (vertical surface) in AR. The back (negative Z) of the object's
  /// bounding box will be placed against the wall and the shadow will be put on
  /// this surface as well. Note that the different AR modes handle the
  /// placement UX differently.
  ///
  /// You may use the [ArPlacement] enum to set this attribute.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-augmentedreality-attributes-arPlacement
  final ArPlacement? arPlacement;

  /// The url to a [USDZ](https://graphics.pixar.com/usd/docs/Usdz-File-Format-Specification.html) model which will be used on [supported iOS 12+ devices](https://www.apple.com/ios/augmented-reality/)
  /// via [AR Quick Look](https://developer.apple.com/videos/play/wwdc2018/603/) on Safari. The presence of this attribute will
  /// automatically enable the quick-look ar-mode, however it is no longer
  ///  necessary. If instead the quick-look ar-mode is specified and ios-src
  /// is not specified, then we will generate a USDZ on the fly when the AR
  /// button is pressed. This means modifications via the scene-graph API will
  /// now be reflected in Quick Look. Hoowever, USDZ generation is not perfect,
  /// for instance animations are not yet supported, so in some cases supplying
  /// ios-src may give better results.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-augmentedreality-attributes-iosSrc
  final String? iosSrc;

  /// Enables AR lighting estimation in WebXR mode; this has a performance cost
  /// and replaces the lighting selected with environment-image during an AR
  /// session. Known issues: sometimes too dark, sudden updates, shiny materials
  /// look matte.
  ///
  /// https://modelviewer.dev/docs/#entrydocs-augmentedreality-attributes-iosSrc
  final bool? xrEnvironment;

  // Staing & Cameras Attributes

  /// Enables controls via mouse/touch. This attribute should nearly always be
  /// specified, unless all model motion is being controlled by JavaScript functions.
  ///
  /// Defaults to true.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-cameraControls
  final bool? cameraControls;

  /// Disables panning interactions, which are enabled by default using
  /// two-finger touch, or dragging with right-click or modifier keys.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-disablePan
  final bool? disablePan;

  /// Disables tap-to-recenter behavior (both center-the-tapped-point and
  /// reset-view-when-tapping-outside). This attribute has no effect in
  /// combination with 'disable-pan', as the tap-to-recenter behavior is part
  /// of the panning interactions. It is recommended to create custom
  /// re-centering behavior when using 'disable-tap' as after panning and
  /// rotating, it is effectively impossible for the user to exactly return to
  /// their starting view.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-disableTap
  final bool? disableTap;

  /// Akin to the CSS touch-action property (which does not work due to some
  /// iOS bugs), the default 'pan-y' allows touch users to vertically scroll
  /// the <model-viewer> element, but can interact if their gesture starts
  /// horizontal. Legacy behavior can be achieved with 'none', where all
  /// scrolling is prevented, while 'pan-x' is the opposite of
  /// 'pan-y'. The normal CSS default 'auto' is not allowed here,
  /// as this can be achieved by not including the camera-controls attribute.
  ///
  /// You may set this attribute with the [TouchAction] enum.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-touch-action
  final TouchAction? touchAction;

  /// Disables user zoom when [camera-controls] is enabled (has no effect
  /// otherwise). Has the secondary effect of not swallowing mouse wheel events
  /// and pinch gestures, so these will then scroll and zoom the page, respectively.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-disable-zoom
  final bool? disableZoom;

  /// Adjusts the speed of theta and phi orbit interactions. Can also be set
  /// negative to reverse, which is helpful when using zero radius to look
  /// around the inside of a cave-like model.
  ///
  /// Defaults to 1.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-orbitSensitivity
  final int? orbitSensitivity;

  /// Enables the auto-rotation of the model.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-autoRotate
  final bool? autoRotate;

  /// Sets the delay before auto-rotation begins. The format of the value is a
  /// number in milliseconds.
  ///
  /// Defaults to 3000. Should be a number >= 0.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-autoRotateDelay
  final int? autoRotateDelay;

  /// Sets the speed of auto-rotate, when enabled. Accepts values with units in
  /// degrees or radians (e.g., "30deg" or "0.5rad"), as well as percent
  /// (e.g. "-100%") of the default value of pi/32 radians.
  ///
  /// Defaults to "pi/32 radians".
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-rotationPerSecond
  final String? rotationPerSecond;

  /// Allows you to change the conditions under which the visual and audible
  /// interaction prompt will display.
  /// If set to "auto", the interaction prompt will be displayed as soon as the
  /// interaction-prompt-threshold (see below) time has elapsed (after the model
  /// is revealed).
  /// If set to "when-focused", the interaction prompt will only be activated
  /// if the element has first received focus. The interaction prompt will only
  /// display if camera-controls are enabled.
  ///
  /// You man use the [InteractionPrompt] enum to set this attribute.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-interactionPrompt
  final InteractionPrompt? interactionPrompt;

  /// Configures the presentation style of the interaction-prompt when it is raised.
  /// When set to "wiggle", the prompt will animate horizontally and the model
  /// will rotate as though the prompt is interacting with it.
  /// When set to "basic", the prompt is not animated, and instead simply appears
  /// until it is dismissed by user interaction.
  ///
  /// You man use the [interactionPromptStyle] enum to set this attribute.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-interactionPromptStyle
  final InteractionPromptStyle? interactionPromptStyle;

  /// When camera-controls are enabled, <model-viewer> will prompt the user
  /// visually (and audibly, for screen readers) to interact if they
  /// focus it but don't interact with it for some time. This attribute allows
  /// you to set how long <model-viewer> should wait (in milliseconds) before
  /// prompting to interact. Defaults to 3000.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-interactionPromptThreshold
  final num? interactionPromptThreshold;

  /// Set the starting and/or subsequent orbital position of the camera.
  /// You can control the azimuthal, theta, and polar, phi, angles
  /// (phi is measured down from the top), and the radius from the center
  /// of the model. Accepts values of the form "$theta $phi $radius", like
  /// "10deg 75deg 1.5m". Also supports units in radians ("rad") for angles
  /// and centimeters ("cm") or millimeters ("mm") for camera distance.
  /// Camera distance can also be set as a percentage ('%'), where 100%
  /// gives the model tight framing within any window based on all possible
  /// theta and phi values. Any time this value changes from its initially
  /// configured value, the camera will interpolate from its current position
  /// to the new value. Any value set to 'auto' will revert to the default.
  /// For camera-orbit, camera-target and field-of-view, parts of the property
  /// value can be configured with CSS-like functions. The CSS calc() function
  /// is supported for these values, as well as a specialized form of the env()
  /// function. You can use env(window-scroll-y) anywhere in the expression to
  /// get a number from 0-1 that corresponds to the current top-level scroll
  /// position of the current frame. For example, a value like
  /// "calc(30deg - env(window-scroll-y) * 60deg) 75deg 1.5m" cause the camera
  /// to orbit horizontally around the model as the user scrolls down the page.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-cameraOrbit
  final String? cameraOrbit;

  /// Set the starting and/or subsequent point the camera orbits around.
  /// Accepts values of the form "$X $Y $Z", like "0m 1.5m -0.5m".
  /// Also supports units in centimeters ("cm") or millimeters ("mm").
  /// A special value "auto" can be used, which sets the target to the center of
  /// the model's bounding box in that dimension. Any time this value changes
  /// from its initially configured value, the camera will interpolate from its
  /// current position to the new value.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-cameraTarget
  final String? cameraTarget;

  /// Used to configure the vertical field of view of the camera. Accepts
  /// values in both degrees and radians (e.g., "30deg" or "0.5rad"). Accepts
  /// any value between the configured min and max field of view. Any time this
  /// value changes from its initially configured value, the camera will
  /// interpolate from its current value to the new value. Defaults to "auto",
  /// which sets either the vertical or horizontal field of view to 45 degrees
  /// depending on the dimensions of the model and the aspect ratio of the canvas.
  /// Seamless poster transitions for arbitrary element aspect ratios are only
  /// possible using "auto".
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-fieldOfView
  final String? fieldOfView;

  /// Set the maximum orbital values of the camera. Takes values in the same
  /// form as camera-orbit, but does not support env(). Note "Infinity" is not
  /// an accepted keyword, but the default can still be obtained by passing "auto".
  /// The radius value for "auto" is the same as the camera-orbit radius "auto" value.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-maxCameraOrbit
  final String? maxCameraOrbit;

  /// Set the minimum orbital values of the camera. Note "Infinity" is not an
  /// accepted keyword, but the default can still be obtained by passing "auto".
  /// The radius value for "auto" is a conservative value to ensure the camera
  /// never enters the model, so be careful when setting this to another value.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-minCameraOrbit
  final String? minCameraOrbit;

  /// Set the maximum field of view of the camera, corresponding to maximum zoom-out.
  /// Takes values in the same form as field-of-view, but does not support env().
  /// The default "auto" is the same as the default field-of-view.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-maxFieldOfView
  final String? maxFieldOfView;

  /// Set the minimum field of view of the camera, corresponding to maximum
  /// zoom-in. Takes values in the same form as field-of-view, but does not
  /// support env(). Set this to a small value to get close zoom-in without
  /// the camera entering the model.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-minFieldOfView
  final String? minFieldOfView;

  /// Controls the rate of interpolation when the camera or model moves, due to
  /// either user interaction or attribute changes. The decay is asymptotic and
  /// the value is in milliseconds, where the majority of the movement will occur
  /// within this value's time. Doubling this value will cut the speed in half.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-stagingandcameras-attributes-interpolationDecay
  final num? interpolationDecay;

  // Lighting & Env Attributes

  /// Sets the background image of the scene. Takes a URL to an [equirectangular
  /// projection image](https://en.wikipedia.org/wiki/Equirectangular_projection) that's used for the skybox, as well as applied as an
  /// environment map on the model. Supports png, jpg and hdr (recommended) images.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-lightingandenv-attributes-skyboxImage
  final String? skyboxImage;

  /// Controls the environmental reflection of the model. Normally if
  /// skybox-image is set, that image will also be used for the environment-image.
  /// Use environment-image to only set the reflection without affecting the
  /// background. If neither is specified, default lighting will be applied.
  /// If 'neutral' is specified without a skybox, then a more evenly-lit
  /// environment is applied instead.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-lightingandenv-attributes-environmentImage
  final String? environmentImage;

  /// Controls the exposure of both the model and skybox, for use primarily with
  /// HDR environments.
  ///
  /// Defaultes to 1. Shoukd be any positive value.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-lightingandenv-attributes-exposure
  final num? exposure;

  /// Controls the opacity of the shadow. Set to 0 to turn off the shadow entirely.
  ///
  /// Defaultes to 0. Should be any any value between 0 and 1.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-lightingandenv-attributes-shadowIntensity
  final num? shadowIntensity;

  /// Controls the blurriness of the shadow. Set to 0 for hard shadows. Softness should not be changed every frame as it incurs a performance cost. Softer shadows render faster.
  ///
  /// Defaultes to 1. Should be any any value between 0 and 1.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-lightingandenv-attributes-shadowSoftness
  final num? shadowSoftness;

  // Animation Attributes

  /// Selects an animation to play by name. This animation will play when the `.play()`
  /// method is invoked, or when the <model-viewer> is configured to autoplay.
  /// If no animation-name is specified, <model-viewer> always picks the first
  /// animation it finds in the model.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-animation-attributes-animationName
  final String? animationName;

  /// When the current animation is changed, <model-viewer> automatically
  /// crossfades between the previous and next animations.
  /// This attribute controls how long the crossfade is in milliseconds.
  ///
  /// Defaults to 300. Should be any number >= 0.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-animation-attributes-animationCrossfadeDuration
  final num? animationCrossfadeDuration;

  /// If this is true and a model has animations, an animation will automatically
  /// begin to play when this attribute is set (or when the property is set to true).
  /// If no animation-name is specified, plays the first animation.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-animation-attributes-autoplay
  final bool? autoPlay;

  // Scene Graph Attributes

  /// Selects a model variant by name.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-scenegraph-attributes-variantName
  final String? variantName;

  /// Rotates the model to the orientation specified by roll, pitch, yaw Euler
  /// angles, where yaw is first applied about the Y-axis, then pitch about the
  /// new local X-axis (positive is front-down), then roll about the new local
  /// Z-axis. If specified before the model loads, automatic camera framing will
  /// take this change into account; otherwise the updateFraming() method must
  /// be called manually.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-scenegraph-attributes-orientation
  final String? orientation;

  /// Scales the model as specified in the X, Y, and Z directions.
  /// Scale is applied before orientation. If specified before the model loads,
  /// automatic camera framing will take this change into account; otherwise the
  /// updateFraming() method must be called manually.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-scenegraph-attributes-scale
  final String? scale;

  // CSS Styles

  /// The backgroundColor of the [ModelViewer]'s WebView.
  /// Defaults to [Colors.transparent].
  final Color backgroundColor;

  // Augmented Related CSS

  /// This read-only attribute enables DOM content to be styled based on the
  /// status of the WebXR AR presentation. For instance, a prompt for the user
  /// to move their phone until the object is successfully placed in their
  /// space can be shown by scoping a CSS rule to
  /// model-viewer[ar-status="session-started"].
  /// Setting this attribute has no effect.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-augmentedreality-css-arStatus
  // final ArStatus? arStatus;

  /// This read-only attribute enables DOM content to be styled based on the
  /// state of the WebXR AR tracking. For instance, a failure message can be
  /// shown by scoping a CSS rule to model-viewer[ar-tracking="not-tracking"].
  /// Setting this attribute has no effect. Most AR tracking failures are due
  /// to the camera being covered or seeing little discernable texture
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-augmentedreality-css-arTracking
  // final ArTracking? arTracking;

  // Annotations CSS

  /// Sets the opacity of hidden hotspots.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-annotations-css-minHotspotOpacity
  final num? minHotspotOpacity;

  /// Sets the opacity of visible hotspots.
  ///
  /// `<model-viewer>` offical document: https://modelviewer.dev/docs/#entrydocs-annotations-css-maxHotspotOpacity
  final num? maxHotspotOpacity;

  // Others
  /// HTML code inside `<model-viewer>` Tag.
  ///
  /// If you choose too use [innerModelViewerHtml], you may need to set [overwriteNodeValidatorBuilder].
  /// On the Web platform, not all the HTML tags and attributes are allowed due to performance reasons.
  /// You may see `Removing disallowed attribute ...` from the console if the tag / attribute is not allowed.
  ///
  /// This package only allows the following elements and attributes by default:
  ///
  /// - Elements allowed by [NodeValidatorBuilder.common()](https://api.flutter.dev/flutter/dart-html/NodeValidatorBuilder/NodeValidatorBuilder.common.html)
  /// - `<meta>`, with attributes ***name, content***
  /// - `<style>`
  /// - `<script>`, with attributes ***src, type, defer, async, crossorigin, integrity, nomodule, nonce, referrerpolicy***
  /// - `<model-viewer>`, with all the attributes that `<model-viewer>` supports
  ///
  /// Please take a look at [overwriteNodeValidatorBuilder] for more information.
  final String? innerModelViewerHtml;

  /// Custom CSS
  final String? relatedCss;

  /// Custom JS
  final String? relatedJs;

  /// The id of the [ModelViewer] in HTML.
  final String? id;

  /// Customize allowed tags & attrubutes for Web platform.
  ///
  /// Solution of console output `Removing disallowed attribute ...`.
  ///
  /// In [model-viewer Change Color Example](https://modelviewer.dev/examples/scenegraph/#changeColor),
  /// we can see codes like:
  ///
  /// ```html
  /// <model-viewer id="color" camera-controls touch-action="pan-y" interaction-prompt="none" src="../../shared-assets/models/Astronaut.glb" ar alt="A 3D model of an astronaut">
  ///   <div class="controls" id="color-controls">
  ///     <button data-color="#ff0000">Red</button>
  ///     <!-- ... some codes ... -->
  ///   </div>
  /// </model-viewer>
  /// ```
  ///
  /// If [overwriteNodeValidatorBuilder] is not specified, you may see
  /// `Removing disallowed attribute <BUTTON data-color="#0000ff">` in the console.
  /// To make them work on Flutter Web, you need to copy our
  /// defaultNodeValidatorBuilder and specify [overwriteNodeValidatorBuilder]
  /// for your need. You may do something like:
  ///
  /// ```dart
  /// import 'package:model_viewer_plus/src/model_viewer_plus_web.dart';
  /// import 'package:model_viewer_plus/src/shim/dart_html_fake.dart'
  ///     if (dart.library.html) 'dart:html';
  ///
  /// NodeValidatorBuilder myNodeValidatorBuilder = defaultNodeValidatorBuilder
  ///  ..allowElement('button',
  ///      attributes: ['data-color'], uriPolicy: AllowAllUri());
  ///
  /// ModelViewer(overwriteNodeValidatorBuilder: myNodeValidatorBuilder,);
  /// ```
  ///
  /// See also: [NodeValidatorBuilder](https://api.flutter.dev/flutter/dart-html/NodeValidatorBuilder-class.html)
  ///
  final NodeValidatorBuilder? overwriteNodeValidatorBuilder;

  /// Passthrough to `javascriptChannels` in the underlying `WebView`.
  final Set<JavascriptChannel>? javascriptChannels;

  /// Passthrough to `onWebViewCreated` in the underlying `WebView`.
  ///
  /// Called *after* the logic that initializes the model-viewer.
  final Function(WebViewController controller)? onWebViewCreated;

  @override
  State<ModelViewer> createState() => ModelViewerState();
}
