// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/services.dart';
//
// class RemovableTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String? hintText;
//   final int? maxLines;
//   final bool obscureText;
//   final double? fontSize;
//   final Color? textColor;
//   final EdgeInsetsGeometry? contentPadding;
//   final EdgeInsetsGeometry? prefixPadding;
//   final TextInputType keyboardType;
//   final ValueChanged<String>? onSubmitted;
//   final FocusNode? focusNode;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputAction? textInputAction;
//   final bool? enabled;
//   final bool autoFocus;
//   final TextStyle? hintStyle;
//   final Color? iconColor;
//   final ValueChanged<String>? onChanged;
//   final Widget? prefixIcon;
//   final bool readOnly;
//   final GestureTapCallback? onTap;
//   final BoxDecoration? decoration;
//   final TextAlign? textAlign;
//   final FontWeight? fontWeight;
//   final showDeleteIcon;
//
//   RemovableTextField({Key? key,
//     this.textInputAction,
//     required this.controller,
//     this.hintText,
//     this.maxLines,
//     TextInputType? keyboardType,
//     this.obscureText = false,
//     this.fontSize,
//     this.textColor,
//     this.contentPadding,
//     this.prefixPadding,
//     this.onSubmitted,
//     this.focusNode,
//     this.inputFormatters,
//     this.enabled,
//     this.hintStyle,
//     this.iconColor,
//     this.onChanged,
//     this.prefixIcon,
//     this.readOnly = false,
//     this.onTap,
//     this.decoration,
//     this.autoFocus = false,
//     this.fontWeight,
//     this.textAlign,
//     this.showDeleteIcon = true})
//       : keyboardType = keyboardType ?? TextInputType.text,
//         super(key: key);
//
//   @override
//   _RemovableTextFieldState createState() {
//     return _RemovableTextFieldState();
//   }
// }
//
// class _RemovableTextFieldState extends State<RemovableTextField> {
//   bool _hasDeleteIcon = false;
//   late bool _obscureText;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _obscureText = widget.obscureText;
//     widget.controller.addListener(() {
//       if (widget.controller.text.isEmpty) {
//         if (!mounted) {
//           return;
//         }
//         _hasDeleteIcon = false;
//         setState(() {});
//         widget.onChanged?.call('');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return CupertinoTextField(
//       readOnly: widget.readOnly,
//       onTap: widget.onTap,
//       autofocus: widget.autoFocus,
//       enabled: widget.enabled,
//       textInputAction: widget.textInputAction,
//       onSubmitted: widget.onSubmitted,
//       controller: widget.controller,
//       keyboardType: widget.keyboardType,
//       obscureText: _obscureText,
//       focusNode: widget.focusNode,
//       maxLines: widget.maxLines ?? 1,
//       cursorColor: Colors.blue,
//       textAlign: widget.textAlign ?? TextAlign.start,
//       padding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 6),
//       inputFormatters: widget.inputFormatters ?? [],
//       style: TextStyle(
//           fontSize: widget.fontSize,
//           color: widget.textColor,
//           fontWeight: widget.fontWeight),
//       suffix: Wrap(
//         alignment: WrapAlignment.end,
//         runAlignment: WrapAlignment.center,
//         direction: Axis.horizontal,
//         children: <Widget>[
//           Visibility(
//               visible: (_hasDeleteIcon || widget.controller.text.isNotEmpty) &&
//                   widget.showDeleteIcon,
//               child: GestureDetector(
//                 onTap: () {
//                   widget.controller.clear();
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: ScreenUtil().setWidth(20)),
//                   child: Image.asset('assets/images/icon_close_round.png',width: 32.w,height: 32.w,),
//                 ),
//               )),
//           Visibility(
//               visible: widget.obscureText,
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _obscureText = !_obscureText;
//                   });
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 10),
//                   child: _obscureText
//                       ? Icon(
//                     const IconData(0xe613, fontFamily: 'Iconfont'),
//                     color: widget.iconColor ?? Colors.grey,
//                     size: 40.w,
//                   )
//                       : Icon(
//                     const IconData(0xe76c, fontFamily: 'Iconfont'),
//                     color: widget.iconColor ?? Colors.grey,
//                     size: 40.w,
//                   ),
//                 ),
//               ))
//         ],
//       ),
//       placeholder: widget.hintText,
//       placeholderStyle: widget.hintStyle ??
//           TextStyle(
//               height: Platform.isAndroid ? 1.2 : 1.3, color: Colors.black26),
//       prefix: widget.prefixIcon != null
//           ? Container(
//         padding: widget.prefixPadding ??
//             EdgeInsets.fromLTRB(
//                 ScreenUtil().setWidth(13),
//                 ScreenUtil().setWidth(19),
//                 ScreenUtil().setWidth(17),
//                 ScreenUtil().setWidth(19)),
//         child: widget.prefixIcon,
//       )
//           : const SizedBox.shrink(),
//       decoration: widget.decoration ?? cupertinoTextFieldDecoration,
//       onChanged: (str) {
//         if (widget.showDeleteIcon)
//           setState(() {
//             _hasDeleteIcon = (str.isNotEmpty);
//           });
//         widget.onChanged?.call(str);
//       },
//     );
//   }
// }
//
// BoxDecoration cupertinoTextFieldDecoration = const BoxDecoration(
//   color: CupertinoDynamicColor.withBrightness(
//     color: CupertinoColors.white,
//     darkColor: CupertinoColors.black,
//   ),
//   border: Border.fromBorderSide(BorderSide(
//     color: CupertinoDynamicColor.withBrightness(
//       color: Color(0x33000000),
//       darkColor: Color(0x33FFFFFF),
//     ),
//     style: BorderStyle.solid,
//     width: 0.0,
//   )),
//   borderRadius: BorderRadius.all(Radius.circular(10.0)),
// );
