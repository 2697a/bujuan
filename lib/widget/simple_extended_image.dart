import 'dart:io';

import 'package:bujuan/common/constants/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class SimpleExtendedImage extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final String placeholder;
  final BoxShape shape;
  final BorderRadius? borderRadius;
  final Widget? replacement;
  final BoxFit? fit;
  final int? cacheWidth;

  const SimpleExtendedImage(this.url,
      {Key? key, this.width, this.height, this.placeholder = placeholderImage, this.replacement, this.fit, this.shape = BoxShape.rectangle, this.borderRadius, this.cacheWidth})
      : super(key: key);

  const SimpleExtendedImage.avatar(this.url,
      {Key? key,
      this.width,
      this.height,
      this.placeholder = avatarPlaceholderImage,
      this.replacement,
      this.fit,
      this.shape = BoxShape.circle,
      this.borderRadius,
      this.cacheWidth = 300})
      : super(key: key);

  @override
  SimpleExtendedImageState createState() {
    return SimpleExtendedImageState();
  }
}

class SimpleExtendedImageState extends State<SimpleExtendedImage> {
  String? url;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return ExtendedImage.network(
    //   widget.url,
    //   width: widget.width,
    //   height: widget.height,
    //   shape: widget.shape,
    //   fit: BoxFit.cover,
    //   gaplessPlayback: true,
    //   borderRadius: widget.borderRadius,
    //   cache: true,
    //   cacheWidth: widget.cacheWidth ?? 500,
    //   //展厅
    //   loadStateChanged: (ExtendedImageState state) {
    //     Widget image;
    //     switch (state.extendedImageLoadState) {
    //       case LoadState.loading:
    //         image = widget.replacement ??
    //             Image.asset(
    //               widget.placeholder,
    //               fit: BoxFit.cover,
    //             );
    //         break;
    //       case LoadState.completed:
    //         image = ExtendedRawImage(
    //           image: state.extendedImageInfo?.image,
    //           width: widget.width,
    //           height: widget.height,
    //           fit: widget.fit ?? BoxFit.cover,
    //         );
    //         break;
    //       case LoadState.failed:
    //         image = Image.asset(
    //           widget.placeholder,
    //           fit: BoxFit.cover,
    //         );
    //
    //         break;
    //     }
    //     return image;
    //   },
    // );
    if (widget.url.startsWith('http')) {
      return Visibility(
        visible: widget.shape != BoxShape.circle,
        replacement: ClipOval(
          child: CachedNetworkImage(
            imageUrl: widget.url,
            width: widget.width,
            height: widget.height,
            fit: widget.fit??BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
          child: CachedNetworkImage(
            imageUrl: widget.url,
            width: widget.width,
            height: widget.height,
            fit: widget.fit??BoxFit.cover,
            useOldImageOnUrlChange: true,
            placeholder: (c, u) => Image.asset(
              widget.placeholder,
              fit: BoxFit.cover,
            ),
            errorWidget: (c,u,e) => Image.asset(
              widget.placeholder,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
        child: ExtendedImage.file(
          borderRadius: widget.borderRadius,
          File(widget.url.split('?').first),
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          loadStateChanged: (state) {
            Widget image;
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                image = Image.asset(
                  widget.placeholder,
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.cover,
                );
                break;
              case LoadState.completed:
                image = ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  width: widget.width,
                  height: widget.height,
                  fit: BoxFit.cover,
                );
                break;
              case LoadState.failed:
                image = Image.asset(
                  width: widget.width,
                  height: widget.height,
                  widget.placeholder,
                  fit: BoxFit.cover,
                );
                break;
            }
            return image;
          },
        ),
      );
    }

    // if (widget.url.startsWith('http')) {
    //
    // } else {
    // return ExtendedImage.file(
    //   File(widget.url),
    //   width: widget.width,
    //   height: widget.height,
    //   shape: widget.shape,
    //   cacheRawData: true,
    //   gaplessPlayback: true,
    //   fit: BoxFit.cover,
    //   borderRadius: widget.borderRadius,
    //   cacheWidth: widget.cacheWidth ?? 800,
    //   //展厅
    //   loadStateChanged: (ExtendedImageState state) {
    //     Widget image;
    //     switch (state.extendedImageLoadState) {
    //       case LoadState.loading:
    //         image = widget.replacement ??
    //             Container(
    //               color: Colors.grey,
    //               width: widget.width,
    //               height: widget.height,
    //               child: Icon(Icons.image,size:( widget.width??100/3).toDouble(),),
    //             );
    //         break;
    //       case LoadState.completed:
    //         image = ExtendedRawImage(
    //           image: state.extendedImageInfo?.image,
    //           width: widget.width,
    //           height: widget.height,
    //           fit: widget.fit ?? BoxFit.cover,
    //         );
    //         break;
    //       case LoadState.failed:
    //         image = Image.asset(
    //           widget.placeholder,
    //           fit: BoxFit.cover,
    //         );
    //         break;
    //     }
    //     return image;
    //   },
    // );
    // }
  }
}
