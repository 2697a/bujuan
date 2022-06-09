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
      {Key? key,
      this.width,
      this.height,
      this.placeholder = '',
      this.replacement,
      this.fit,
      this.shape = BoxShape.rectangle,
      this.borderRadius, this.cacheWidth})
      : super(key: key);

  const SimpleExtendedImage.avatar(this.url,
      {Key? key,
      this.width,
      this.height,
      this.placeholder = 'AppIcons.avatarPlaceholder',
      this.replacement,
      this.fit,
      this.shape = BoxShape.circle,
      this.borderRadius, this.cacheWidth = 300})
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
    if (widget.url.startsWith('http')) {
      url = widget.url;
    } else {
      url = widget.url;
    }
    return ExtendedImage.network(
      url ?? '',
      width: widget.width,
      height: widget.height,
      shape: widget.shape,
      fit: BoxFit.cover,
      borderRadius: widget.borderRadius,
      cache: true,
      cacheWidth: widget.cacheWidth??800,
      //展厅
      loadStateChanged: (ExtendedImageState state) {
        Widget image;
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            image = widget.replacement ??
                Image.asset(
                  widget.placeholder,
                  fit: BoxFit.cover,
                );
            break;
          case LoadState.completed:
            image = ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              width: widget.width,
              height: widget.height,
              fit: widget.fit ?? BoxFit.cover,
            );
            break;
          case LoadState.failed:
            image = Image.asset(
              widget.placeholder,
              fit: BoxFit.cover,
            );
            break;
        }
        return image;
      },
    );
  }
}
