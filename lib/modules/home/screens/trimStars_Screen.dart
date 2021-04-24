import 'package:flutter/material.dart';
import 'package:trim/modules/home/widgets/trim_app_bar.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/widgets/BuildTrimStarItem.dart';

class TrimStarsScreen extends StatelessWidget {
  static final String routeName = 'TrimStarsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: kPadding,
              child: InfoWidget(
                responsiveWidget: (context, deviceInfo) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {},
                            child: Container(
                                width: deviceInfo.localWidth,
                                height: deviceInfo.orientation ==
                                        Orientation.portrait
                                    ? deviceInfo.localHeight / 4.5
                                    : deviceInfo.localHeight / 2.5,
                                child: TrimStarItem()),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            TrimAppBar(),
          ],
        ),
      ),
    );
  }
}
