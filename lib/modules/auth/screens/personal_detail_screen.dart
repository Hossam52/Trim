import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/core/auth/register/validate.dart';
import 'package:trim/modules/auth/cubits/auth_cubit.dart';
import 'package:trim/modules/auth/cubits/auth_states.dart';
import 'package:trim/modules/home/cubit/app_cubit.dart';
import 'package:trim/modules/home/widgets/trim_cached_image.dart';
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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;

  TextEditingController _emailController;

  TextEditingController _phoneController;

  TextEditingController _passwordController;
  ImagePicker imagePicker;
  File coverImage;
  File image;
  Future<File> getImageFromGellary() async {
    try {
      imagePicker = ImagePicker();
      final imagePicked =
          await imagePicker.getImage(source: ImageSource.gallery);
      if (imagePicked == null) return null;
      return File(imagePicked.path);
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: AppCubit.getInstance(context).name);

    _emailController =
        TextEditingController(text: AppCubit.getInstance(context).email);

    _phoneController =
        TextEditingController(text: AppCubit.getInstance(context).phone);

    _passwordController = TextEditingController(text: '############');
  }

  double getSizeProfileStack(DeviceInfo deviceInfo) {
    return deviceInfo.orientation == Orientation.portrait
        ? deviceInfo.localHeight / 2.5
        : deviceInfo.localHeight / 1.5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
     
      body: SafeArea(
        child: InfoWidget(
          responsiveWidget: (context, deviceInfo) => SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                    Container(
                    height: getSizeProfileStack(deviceInfo),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Container(
                          height: getSizeProfileStack(deviceInfo) -
                              (deviceInfo.type == deviceType.mobile ? 50 : 60),
                          child: Stack(
                             alignment: AlignmentDirectional.bottomEnd,
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
                  SingleChildScrollView(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoverPhoto() {
    return coverImage == null
        ? TrimCachedImage(src: AppCubit.getInstance(context).cover)
        : Image.file(
            coverImage,
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
                Text(getWord('Change cover photo', context),
                    style: TextStyle(color: Colors.white)),
              ],
            )),
      ),
    );
  }

  Widget _buildPersonPhoto(DeviceInfo deviceInfo) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CircleAvatar(
        
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: Container(
                child: image != null
                    ? Image.file(
                        image,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                        width: double.infinity,
                      )
                    : TrimCachedImage(src: AppCubit.getInstance(context).image),
              ),
            ),
          //  Expanded()
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon((Icons.add_a_photo)),
              onPressed: () async {
                 image = await getImageFromGellary();
                setState(()  {
                });
              },
            ),
          ],
        ),
        radius:(deviceInfo.localWidth)* (deviceInfo.orientation==Orientation.portrait?0.15:0.085)
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
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (_, state) {
        if (state is ErrorUpdatingUserInformationState)
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        if (state is NoUpdatingUserInformationState)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(getWord('You dont modify any thing', context)),
            duration: Duration(seconds: 1),
          ));

        if (state is SuccessUpdatingUserInformationState)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(getWord('Modify Done', context)),
            duration: Duration(seconds: 1),
          ));
      },
      builder: (_, state) => Row(
        children: [
          Expanded(
              child: DefaultButton(
            text: getWord('Save', context),
            widget: state is UpdatingUserInformationState
                ? CircularProgressIndicator()
                : null,
            onPressed: state is UpdatingUserInformationState
                ? null
                : () async {
                    await AuthCubit.getInstance(context).updateUserInfo(
                      context: context,
                      formKey: _formKey,
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      coverImage: coverImage,
                      image: image,
                    );
                  },
          )),
        ],
      ),
    );
  }
}
