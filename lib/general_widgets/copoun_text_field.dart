import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/modules/settings/models/coupoun_model.dart';
import 'package:trim/utils/services/rest_api_service.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DefaultButton(
              onPressed: enabled
                  ? null
                  : () async {
                      try {
                        FocusScope.of(context).unfocus();
                        if (controller.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg:
                                  getWord('Pleas Enter coupoun code', context));
                        } else {
                          final response = await DioHelper.postData(
                              url: 'winCoupone',
                              body: {
                                'code': controller.text,
                              });
                          if (!response.data['success']) {
                            Fluttertoast.showToast(
                                msg: isArabic
                                    ? 'الكوبون غير متاح'
                                    : response.data['message']);
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
              text: getWord('apply', context),
              color: Color(0xff2C73A8),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: TextFormField(
                enabled: !enabled,
                controller: controller,
                decoration: InputDecoration(
                  hintText: getWord('coupon code', context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
