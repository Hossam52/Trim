import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class TrimCachedImage extends StatelessWidget {
  final String src;
  final double height;
  final double width;

  const TrimCachedImage({
    Key key,
    @required this.src,
    this.height,
    this.width = double.infinity,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => CachedNetworkImage(
        fit: BoxFit.fill,
        width: width,
        height: height,
        imageUrl: src,
        placeholder: (context, url) => TrimLoadingWidget(),
        errorWidget: (context, url, error) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red),
              Flexible(
                child: Text(getWord('No image found', context),
                    style: TextStyle(
                        fontSize: getFontSizeVersion2(deviceInfo) * 0.7)),
              ),
            ],
          );
        },
      ),
    );
  }
}
