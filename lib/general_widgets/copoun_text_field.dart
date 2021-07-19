import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class CoupounTextField extends StatelessWidget {
  final bool enabled;
  final TextEditingController controller;
  final void Function(bool correctCopon, int discount) updateUi;
  const CoupounTextField(
      {Key key,
      @required this.enabled,
      @required this.controller,
      @required this.updateUi})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(child: Text(getWord('Coupone', context))),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: TextFormField(
                  onEditingComplete: () async {
                    FocusScope.of(context).unfocus();
                    try {
                      FocusScope.of(context).unfocus();
                      if (controller.text.isEmpty || controller.text == ' ') {
                        Fluttertoast.showToast(
                            msg: getWord('Please Enter coupoun code', context));
                      } else {
                        final response =
                            await DioHelper.postData(url: couponeUrl, body: {
                          'code': controller.text,
                        });
                        if (!response.data['success']) {
                          Fluttertoast.showToast(
                              msg: isArabic
                                  ? 'الكوبون غير متاح'
                                  : 'Coupone not  available');
                        } else {
                          updateUi(
                              true,
                              int.tryParse(response.data['data']['price']) ??
                                  0);
                        }
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: getWord(
                              'Please Make sure from internet connection',
                              context));
                    }
                  },
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: getWord('coupon code', context),
                      hintStyle: TextStyle(
                          fontSize: getFontSizeVersion2(deviceInfo) * 0.6)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
