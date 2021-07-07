class FacebookAuthModel {
  String name;
  String email;
  String profileId;
  String accessToken;

  FacebookAuthModel.fromJson(String accessToken, {Map<String, dynamic> json}) {
    name = json['name'];
    email = json['email'];
    profileId = json['id'];
    this.accessToken = accessToken;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> returnedMap = {
      'name': name,
      'provider': 'facebook',
      'provider_id': profileId,
      'provider_token': accessToken
    };
    if (email != null) returnedMap['email'] = email;
    return returnedMap;
  }
}
