import 'package:flutter/material.dart';
import 'package:trim/general_widgets/transparent_appbar.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/widgets/rater_item.dart';
import 'package:trim/modules/home/widgets/trim_app_bar.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/rater_model.dart';

class RatersScreen extends StatelessWidget {
  static final String routeName = 'RatersScreen';
  @override
  Widget build(BuildContext context) {
    List<RateModel> rates = SalonsCubit.getInstance(context).salonDetail.rates;
    return Scaffold(
      appBar: TransparentAppBar(),
      body: SafeArea(
        child: Padding(
          padding: kPadding,
          child: InfoWidget(
            responsiveWidget: (context, deviceInfo) {
              return rates.isEmpty
                  ? Center(
                      child: Text(
                      'No Raters up till now',
                      style:
                          TextStyle(fontSize: getFontSizeVersion2(deviceInfo)),
                    ))
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: rates.length,
                      itemBuilder: (context, index) => Container(
                          width: deviceInfo.localWidth,
                          height: deviceInfo.orientation == Orientation.portrait
                              ? deviceInfo.localHeight / 4.5
                              : deviceInfo.localHeight / 2,
                          child: RaterItem(rater: rates[index])),
                    );
            },
          ),
        ),
      ),
    );
  }
}
