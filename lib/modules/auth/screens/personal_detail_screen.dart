import 'package:flutter/material.dart';
import 'package:trim/core/auth/register/validate.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildCoverPhoto(),
                    BuildBackButtonWidget(
                      localHeight: 530,
                    ),
                    _changeCoverButton(),
                    _buildPersonPhoto(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Card(
                    margin: const EdgeInsets.all(15.0),
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
    return Positioned(
      bottom: 0,
      child: InkWell(
        onTap: () {
          print('Tapped');
        },
        child: Container(
            decoration: BoxDecoration(color: Colors.black.withAlpha(100)),
            child: Row(
              children: [
                Icon(Icons.camera_alt, color: Colors.white),
                Text('Change cover photo',
                    style: TextStyle(color: Colors.white)),
              ],
            )),
      ),
    );
  }

  Widget _buildPersonPhoto() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          ///TO-DO open gallery to choose picture
          print('image tapped');
        },
        child: Container(
          height: 150,
          width: 150,
          padding: const EdgeInsets.only(bottom: 30),
          decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('assets/images/2.jpg'), fit: BoxFit.fill)),
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
