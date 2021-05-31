import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/modules/auth/cubits/auth_states.dart';
import 'package:trim/modules/auth/models/login_model.dart';
import 'package:trim/modules/auth/models/register_model.dart';
import 'package:trim/modules/auth/repositries/login_repositries.dart';
import 'package:trim/modules/auth/repositries/register_repositry.dart';
import 'package:trim/modules/auth/screens/login_screen.dart';
import 'package:trim/modules/auth/screens/registration_screen.dart';
import 'package:trim/modules/home/cubit/app_cubit.dart';
import 'package:trim/modules/home/screens/home_Screen.dart';
import 'package:trim/utils/services/sercure_storage_service.dart';

enum Gender {
  Male,
  Female,
}

class _LoginErrors {
  static const String notActivated = "User Account Not Activated";
  static const String unauthorised = "UnAuthorised";
}

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(IntialAuthLoginState());
  static AuthCubit getInstance(context) => BlocProvider.of(context);
  RegisterModel registerModel;
  LoginModel userDetailModel;
  Gender selectedGender = Gender.Male;
//----------------------API Calls Start-------------------
  void login(BuildContext context, String userName, String password) async {
    emit(LoadingAuthState());
    String fieldsValidateError = _validateLogin(userName, password, context);
    if (fieldsValidateError == null) {
      //Call API
      final response = await loginUser(userName, password);
      if (response.error) {
        if (response.errorMessage == _LoginErrors.notActivated)
          emit(NotActivatedAccountState());
        else
          emit(ErrorAuthState(
              getWord('Email or password not correct', context)));
      } else {
        //Use shared prefrences
        await TrimShared.storeProfileData(response.data);
        await AppCubit.getInstance(context).intializeDio(response.data.token);

        Navigator.pushReplacementNamed(context, HomeScreen.routeName);

        emit(LoadedAuthState());
      }
    } else {
      emit(InvalidFieldState(fieldsValidateError));
    }
  }

  void register(
      {@required String name,
      @required String email,
      @required String password,
      @required String phone,
      @required BuildContext context}) async {
    String _validateRegisterStatus = _validateRegister(
        context: context,
        name: name,
        email: email,
        password: password,
        phone: phone);
    if (_validateRegisterStatus != null) {
      emit(InvalidFieldState(_validateRegisterStatus));
    } else {
      emit(LoadingRegisterState());
      final response = await registerUser(body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'phone': phone,
        'gender': selectedGender == Gender.Male ? 'male' : 'female',
      });
      if (response.error) {
        emit(ErrorRegisterState(response.errorMessage));
      } else {
        registerModel = response.data;
        print(response.data.accessToken);
        emit(NotActivatedAccountState());
      }
    }
  }

  Future<void> logout() async {
    emit(LoadingLogoutState());
    final response = await logoutUserFromServer();
    if (response.error) {
      emit(ErrorLogoutState(response.errorMessage));
    } else {
      emit(LoadedLogoutState());
    }
  }

  Future<void> changePassword(String newPassword, String token) async {
    try {
      emit(ChangingPasswordState());
      final response = await changeUserPasswordFromServer(newPassword, token);
      if (response.error) {
        emit(ErrorChangingPasswordState(response.errorMessage));
      } else {
        emit(SuccessChangedPasswordState());
      }
    } catch (e) {
      emit(ErrorChangingPasswordState(e.toString()));
    }
  }

//---------------------API Calls End ----------------------
  Future<void> updateUserInfo(
      {@required BuildContext context,
      @required GlobalKey<FormState> formKey,
      @required String name,
      @required String email,
      @required String phone,
      @required File coverImage,
      @required File image}) async {
    if (formKey.currentState.validate()) {
      emit(UpdatingUserInformationState());
      Map<String, dynamic> body = {};
      if (name != AppCubit.getInstance(context).name) body['name'] = name;
      if (email != AppCubit.getInstance(context).email) body['email'] = email;
      if (phone != AppCubit.getInstance(context).phone) body['phone'] = phone;
      if (coverImage != null)
        body['cover'] = await MultipartFile.fromFile(coverImage.path);
      if (image != null)
        body['image'] = await MultipartFile.fromFile(image.path);
      if (body.isEmpty) {
        emit(NoUpdatingUserInformationState());
        return;
      }
      var formData = FormData.fromMap(body);

      final response = await updateUserInformationFromServer(formData);
      if (response.error) {
        emit(ErrorUpdatingUserInformationState(response.errorMessage));
      } else {
        AppCubit.getInstance(context).updateInfo(response.data['data']);
        emit(SuccessUpdatingUserInformationState());
      }
    }
  }

  void navigateToLogin(BuildContext context) {
    emit(IntialAuthLoginState());
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  void navigateToRegister(BuildContext context) {
    emit(IntialAuthRegisterState());
    Navigator.pushReplacementNamed(context, RegistrationScreen.routeName);
  }

  void changeGender(Gender gender) {
    selectedGender = gender;
    emit(ChangeGenderState());
  }

  String _validateRegister({
    @required BuildContext context,
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    String validateEamilStatus = _validateEmail(email, context);
    String validatePhoneStatus = validatePhone(phone, context);
    String validatePasswordStatus = validatePassword(password, context);
    String validateNameStatus = validateName(name, context);
    if (validateNameStatus != null) return validateNameStatus;
    if (validateEamilStatus != null && validateEamilStatus.isNotEmpty)
      return validateEamilStatus;
    if (validateEamilStatus != null && validateEamilStatus.isEmpty) {
      return getWord('Email entered is not correct', context);
    }
    if (validatePhoneStatus != null) return validatePhoneStatus;
    if (validatePasswordStatus != null) return validatePasswordStatus;
    return null;
  }

  String _validateLogin(
      String userName, String password, BuildContext context) {
    String validateUserNameStatus = validateLogin(userName, context);
    if (validateUserNameStatus != null)
      return validateUserNameStatus;
    else {
      String validatePasswordStatus = validatePassword(password, context);
      if (validatePasswordStatus != null)
        return validatePasswordStatus;
      else
        return null;
    }
  }

  String _validateEmail(String email, BuildContext context) {
    if (email == null || email.isEmpty)
      return getWord("Email field can not be empty", context);
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(email)) {
      return null;
    } else
      return '';
  }

  String validateLogin(String login, BuildContext context) {
    String emailValidation = _validateEmail(login, context);
    if (emailValidation == null || emailValidation != '')
      return emailValidation;
    if (validatePhone(login, context) != null)
      return getWord('Email or phone is not on correct format', context);
    return null;
  }

  String validatePhone(String phone, BuildContext context) {
    String p = '^(01)(1|0|2)[0-9]{8}\$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(phone))
      return null;
    else
      return getWord('Phone not correct', context);
  }

  String validatePassword(String password, BuildContext context) {
    if (password == null || password.isEmpty)
      return getWord("Password field can not be empty", context);
    return null;
  }

  String validateName(String name, BuildContext context) {
    if (name == null || name.isEmpty)
      return getWord("Name field can not be empty", context);
    return null;
  }
}
