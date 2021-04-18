import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/CanceledReasons.dart';
import 'package:trim/modules/home/models/Reservation.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/BuildAlertDialog.dart';
import 'package:trim/widgets/BuildAppBar.dart';
import 'package:trim/widgets/BuildCardWidget.dart';
import 'package:trim/widgets/BuildItemReservation.dart';
import 'package:trim/widgets/default_button.dart';

class ReservationDetailsScreen extends StatelessWidget {
  static final String routeName = 'reservationDetailsScreen';
  double fontSize = 0;
  Reservation reservationData;
  Future<void> showReasonCancelled(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return InfoWidget(
            responsiveWidget: (context, deviceInfo) => Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            height:
                                deviceInfo.orientation == Orientation.portrait
                                    ? deviceInfo.type == deviceType.mobile
                                        ? 45
                                        : 80
                                    : deviceInfo.type == deviceType.mobile
                                        ? 80
                                        : 95),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            child: BuildListCanceledReasons(deviceInfo),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      heightFactor: 1,
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: MediaQuery.of(context).size.width /
                            (deviceInfo.orientation == Orientation.portrait
                                ? 5
                                : 6),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    reservationData = ModalRoute.of(context).settings.arguments as Reservation;
    return Scaffold(
      body: SafeArea(child: InfoWidget(
        responsiveWidget: (context, deviceInfo) {
          fontSize = getFontSize(deviceInfo);
          return Column(
            children: [
              buildAppBar(
                  localHeight: deviceInfo.localHeight,
                  fontSize: fontSize,
                  screenName: 'Reservation details'),
              Expanded(
                child: SingleChildScrollView(
                  child: buildCardWidget(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildItemReservation(
                              reservationData, fontSize, false, context),
                          SizedBox(
                            height: 3,
                          ),
                          Divider(
                            height: 2,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          Text(
                            'Total : 230 ',
                            style: TextStyle(fontSize: fontSize),
                          ),
                          Text(
                            'Dicount : 20',
                            style: TextStyle(fontSize: fontSize),
                          ),
                          Text(
                            'Total after dicount : 210',
                            style: TextStyle(fontSize: fontSize),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DefaultButton(
                                  text: 'Modify order',
                                  fontSize: fontSize,
                                  onPressed: () {},
                                ),
                              )),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DefaultButton(
                                    text: 'Cancel order',
                                    color: Colors.black,
                                    fontSize: fontSize,
                                    onPressed: () async {
                                      await showReasonCancelled(context);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}

class BuildListCanceledReasons extends StatefulWidget {
  final DeviceInfo deviceInfo;
  BuildListCanceledReasons(this.deviceInfo);
  @override
  _BuildListCanceledReasonsState createState() =>
      _BuildListCanceledReasonsState();
}

class _BuildListCanceledReasonsState extends State<BuildListCanceledReasons> {
  String selectedvalue = '';
  double fontSize;
  FocusNode focusNode;
  @override
  void initState() {
    fontSize = getFontSize(widget.deviceInfo);
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 45),
        BuildCanceledReasonItem(
          fontSize: fontSize,
          reason: canceledReasons[0],
          selected: selectedvalue,
          press: (selected) {
            setState(() {
              selectedvalue = selected;
            });
          },
        ),
        BuildCanceledReasonItem(
          fontSize: fontSize,
          reason: canceledReasons[1],
          selected: selectedvalue,
          press: (selected) {
            setState(() {
              selectedvalue = selected;
            });
          },
        ),
        BuildCanceledReasonItem(
          fontSize: fontSize,
          reason: canceledReasons[2],
          selected: selectedvalue,
          press: (selected) {
            setState(() {
              selectedvalue = selected;
            });
          },
        ),
        BuildCanceledReasonItem(
          fontSize: fontSize,
          reason: canceledReasons[3],
          selected: selectedvalue,
          press: (selected) {
            setState(() {
              selectedvalue = selected;
            });
          },
        ),
        BuildCanceledReasonItem(
          fontSize: fontSize,
          reason: canceledReasons[4],
          selected: selectedvalue,
          press: (selected) {
            setState(() {
              selectedvalue = selected;
            });
          },
        ),
        BuildCanceledReasonItem(
          fontSize: fontSize,
          reason: canceledReasons[5],
          selected: selectedvalue,
          press: (selected) {
            setState(() {
              selectedvalue = selected;
            });
          },
        ),
        BuildCanceledReasonItem(
          fontSize: fontSize,
          reason: canceledReasons[6],
          selected: selectedvalue,
          press: (selected) {
            setState(() {
              selectedvalue = selected;
            });
          },
        ),
        selectedvalue != canceledReasons[6]
            ? Container()
            : TextFormField(
                focusNode: focusNode,
                decoration: InputDecoration(
                  //contentPadding: ,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'من فضلك ادخل سبب الالغاء',
                  labelText: 'سبب الالغاء',
                ),
                onSaved: (reason) {
                  selectedvalue = reason;
                  print(selectedvalue);
                  FocusScope.of(context).unfocus();
                },
              ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          // child: ElevatedButton(
          //   child: Text(
          //     'موافق',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onPressed: () {
          //     if (selectedvalue != '') Navigator.pop(context, selectedvalue);
          //   },
          //   style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all(Colors.black),
          //       shape: MaterialStateProperty.all(
          //         RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20),
          //         ),
          //       )),
          child: DefaultButton(
              onPressed: () {
                if (selectedvalue != '') Navigator.pop(context, selectedvalue);
              },
              text: 'موافق',
              color: Colors.black),
        ),
      ],
    );
  }
}

class BuildCanceledReasonItem extends StatelessWidget {
  final String reason;
  final String selected;
  final double fontSize;
  final Function(String selectedValue) press;

  const BuildCanceledReasonItem(
      {@required this.reason,
      @required this.selected,
      @required this.press,
      @required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Radio<String>(
            groupValue: selected, value: reason, onChanged: press),
        title: Text(
          reason,
          style: TextStyle(fontSize: fontSize),
        ));
  }
}

Widget buildButton(
    {String name, Function function, Color color, double fontSize}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: function,
        child: Text(
          name,
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)))),
      ),
    ),
  );
}
