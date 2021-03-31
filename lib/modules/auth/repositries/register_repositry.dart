class RegisterReposistry {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final String gender;

  RegisterReposistry(
      {this.name,
      this.email,
      this.phone,
      this.password,
      this.confirmPassword,
      this.gender});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "password_confirmation": confirmPassword,
      "gender": gender,
    };
  }
}
