String validateEmail(String email) {
  if (email == null || email.isEmpty) return 'يجب ملء الايميل';
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";
  RegExp regExp = new RegExp(p);

  if (regExp.hasMatch(email)) {
    // So, the email is valid
    return null;
  }

  // The pattern of the email didn't match the regex above.
  return 'Email is not valid';
}

String validatePhone(String phone) {
  if (phone == null || phone.isEmpty) return 'يجب ملء رقم الهاتف';
  if (phone.length != 11) return 'ادخل رقم هاتف صالح';
  return null;
}

String validatePassword(String password) {
  if (password == null || password.isEmpty) return 'يجب ملء كلمة المرور';
  if (password.length < 6) return 'كلمة المرور يجب ان تكون 6 احرف علي الاقل';
  return null;
}

String validateName(String string) {
  if (string == null || string.isEmpty) return 'يجب ملء الاسم';
  if (string.length < 5) return 'الاسم 5 احرف علي الاقل';
  return null;
}
