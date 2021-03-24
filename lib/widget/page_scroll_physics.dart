// import 'package:flutter/material.dart';
// import 'package:flutter/physics.dart';
//
// class pageScrollPhysics extends PageScrollPhysics {
//   const pageScrollPhysics({ScrollPhysics parent}) : super(parent: parent);
//
//   @override
//   pageScrollPhysics applyTo(ScrollPhysics ancestor) {
//     return pageScrollPhysics(parent: buildParent(ancestor));
//   }
//
//   double _getPage(ScrollMetrics position) {
//     if (position is _PagePosition) return position.page;
//     return position.pixels / position.viewportDimension;
//   }
//
//   double _getPixels(ScrollMetrics position, double page) {
//     if (position is _PagePosition) return position.getPixelsFromPage(page);
//     return page * position.viewportDimension;
//   }
//
//   double _getTargetPixels(
//       ScrollMetrics position, Tolerance tolerance, double velocity) {
//     double page = _getPage(position);
//     if (velocity < -tolerance.velocity)
//       page -= 0.5;
//     else if (velocity > tolerance.velocity) page += 0.5;
//     return _getPixels(position, page.roundToDouble());
//   }
//
//   @override
//   Simulation createBallisticSimulation(
//       ScrollMetrics position, double velocity) {
//     if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
//         (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
//       return super.createBallisticSimulation(position, velocity);
//     final Tolerance tolerance = this.tolerance;
//     final double target = _getTargetPixels(position, tolerance, velocity);
//     if (target != position.pixels)
//       return ScrollSpringSimulation(SpringDescription(
//         mass: 8,
//         stiffness: 150,
//         damping: 15,
//       ), position.pixels, target, velocity,
//           tolerance: tolerance);
//     return null;
//   }
//
//   @override
//   bool get allowImplicitScrolling => false;
// }