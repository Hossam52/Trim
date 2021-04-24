import 'package:flutter/material.dart';
import 'package:trim/core/auth/register/validate.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/BuildBackButtonWidget.dart';
import 'package:trim/widgets/default_button.dart';
import 'package:trim/widgets/trim_text_field.dart';

class PersonDetailScreen extends StatefulWidget {
  static const routeName = '/person-detail';

  @override
  _PersonDetailScreenState createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  String name = '';
  String email = '';
  String phone = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;

  TextEditingController _emailController;

  TextEditingController _phoneController;

  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    extractDataFromDataBase();
    _nameController = TextEditingController(text: name);

    _emailController = TextEditingController(text: email);

    _phoneController = TextEditingController(text: phone);

    _passwordController = TextEditingController(text: '############');
  }

  void extractDataFromDataBase() {
    name = 'Hossam Hassan';
    email = 'hossam.fcis@gmail.com';
    phone = '01115425561';
  }

  double getSizeProfileStack(DeviceInfo deviceInfo) {
    return deviceInfo.orientation == Orientation.portrait
        ? deviceInfo.localHeight / 2.5
        : deviceInfo.localHeight / 1.5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InfoWidget(
          responsiveWidget: (context, deviceInfo) => GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Container(
                  height: getSizeProfileStack(deviceInfo),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: getSizeProfileStack(deviceInfo) -
                            (deviceInfo.type == deviceType.mobile ? 50 : 60),
                        child: Stack(
                          children: [
                            _buildCoverPhoto(),
                            _changeCoverButton(),
                          ],
                        ),
                      ),
                      BuildBackButtonWidget(
                        localHeight: 530,
                      ),
                      _buildPersonPhoto(deviceInfo),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  // flex: 3,
                  child: SingleChildScrollView(
                    child: Card(
                      margin: const EdgeInsets.all(15.0),
                      elevation: 4,
                      child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              _personDetailForm(),
                              _buildButtons(),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoverPhoto() {
    return Image.asset(
      'assets/images/4.jpg',
      fit: BoxFit.fill,
      width: double.infinity,
    );
  }

  Widget _changeCoverButton() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: InkWell(
        onTap: () {
          print('Tapped');
        },
        child: Container(
            decoration: BoxDecoration(color: Colors.black.withAlpha(100)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.camera_alt, color: Colors.white),
                Text('Change cover photo',
                    style: TextStyle(color: Colors.white)),
              ],
            )),
      ),
    );
  }

  Widget _buildPersonPhoto(DeviceInfo deviceInfo) {
    // double sizeImage = deviceInfo.localHeight / 4;
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          ///TO-DO open gallery to choose picture
          print('image tapped');
        },
        child: CircleAvatar(
          radius: deviceInfo.type == deviceType.mobile ? 50 : 65,
          backgroundColor: Colors.red,
          backgroundImage: AssetImage('assets/images/2.jpg'),
        ),
      ),
    );
  }

  Widget _personDetailForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TrimTextField(
            controller: _nameController,
            placeHolder: 'Hossam Hassan',
            prefix: Icon(Icons.mode_edit),
            validator: validateName,
          ),
          TrimTextField(
            controller: _emailController,
            placeHolder: 'hossam.fcis@gmail.com',
            prefix: Icon(Icons.mode_edit),
            validator: validateEmail,
          ),
          TrimTextField(
            controller: _phoneController,
            placeHolder: '01115425561',
            prefix: Icon(Icons.mode_edit),
            validator: validatePhone,
          ),
          TrimTextField(
            controller: _passwordController,
            placeHolder: '#############',
            prefix: Icon(Icons.mode_edit),
            validator: validatePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
            child: DefaultButton(
          text: 'Save',
          onPressed: () {
            _formKey.currentState.validate();
          },
        )),
      ],
    );
  }
}
