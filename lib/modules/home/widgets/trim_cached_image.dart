import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TrimCachedImage extends StatelessWidget {
  final String src;
  final double height;

  const TrimCachedImage({Key key, @required this.src, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      width: double.infinity,
      height: height,
      imageUrl: src,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red),
            Text('No image found'),
          ],
        );
      },
    );
  }
}
