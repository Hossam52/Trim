import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/core/auth/register/validate.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/general_widgets/BuildBackButtonWidget.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/general_widgets/trim_text_field.dart';

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
  ImagePicker imagePicker;
  File coverImage;
  File image;
  Future<File> getImageFromGellary() async {
    imagePicker = ImagePicker();
    final imagePicked = await imagePicker.getImage(source: ImageSource.gallery);
    return File(imagePicked.path);
    // setState(() {
    //   coverImage = File(imagePicked.path);
    // });
  }

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
    return coverImage == null
        ? Image.asset(
            'assets/images/4.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
          )
        : Image.file(
            coverImage,
            fit: BoxFit.fill,
            width: double.infinity,
          );
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
        onTap: () async {
          coverImage = await getImageFromGellary();

          setState(() {});
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
      child: CircleAvatar(
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon((Icons.add_a_photo)),
            onPressed: () async {
              image = await getImageFromGellary();
              setState(() {});
            },
          ),
        ),
        radius: deviceInfo.type == deviceType.mobile ? 50 : 65,
        backgroundColor: Colors.red,
        backgroundImage: image != null
            ? FileImage(image)
            : AssetImage('assets/images/2.jpg'),
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
          text: getWord('Save', context),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              print('data name ${_nameController.text}');
              // print(coverImage.path);
              String fileName = coverImage.path.split('/').last;
              //new

              var formData = FormData.fromMap(<String, dynamic>{
                'name': _nameController.text,
                'email': _emailController.text,
                'password': _passwordController.text,
                'password_confirmation': _passwordController.text,
                //   'image':,
                //    'cover': formData,
                'phone': _phoneController.text,
                "cover": await MultipartFile.fromFile(
                  coverImage.path,
                  filename: fileName,
                  //  contentType: MediaType('image', 'jpg'),
                ),
              });

              final response = await DioHelper.postDataToImages(
                url: 'user/profile',
                //body is a formData
                formData: formData,
              );
              print(response.data);
              if (response.statusCode > 400) {
                var data = response.data['errors'];
                print('Data of Errors\n');
                var email = data['email'] == null ? '' : data['email'][0];
                var phone = data['phone'] == null ? '' : data['phone'][0];
                var c = (email == '') ? '' : ' & ' + email;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(phone == '' ? email : phone + c)));
                print(email);
                print(phone);
              }
            }

            //    _formKey.currentState.validate();
          },
        )),
      ],
    );
  }
}
