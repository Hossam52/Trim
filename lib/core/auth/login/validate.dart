String validateLogin(String login) {
  if (login == null || login.isEmpty) return 'يجب ملء هذا الحقل';
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(login)) {
    // So, the email is valid
    return null;
  }
  if (validatePhone(login) != null) return 'Email or password not correct';
  return null;
}

String validatePhone(String phone) {
  if (phone == null || phone.isEmpty) return 'يجب ملء رقم الهاتف';
  if (phone.length != 12) return 'ادخل رقم هاتف صالح';
  return null;
}

String validatePassword(String password) {
  if (password == null || password.isEmpty) return 'يجب ادخال كلمة المرور';
  return null;
}
