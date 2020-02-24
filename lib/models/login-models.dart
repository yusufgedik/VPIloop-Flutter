import 'package:flutter/foundation.dart';

class UserModelRequest {
  String userName;
  String password;
  UserModelRequest({@required this.userName, @required this.password});
  Map<String, dynamic> toJson() => {
        'UserName': userName,
        'Password': password,
      };
}

class UserModelResponse {
  bool authenticated;
  String fullName;
  int missingActivityCount;
  bool hasError;

  UserModelResponse(
      {this.authenticated,
      this.fullName,
      this.missingActivityCount,
      this.hasError});
  factory UserModelResponse.fromJson(Map<String, dynamic> item) {
    return UserModelResponse(
      authenticated: item['authenticated'],
      fullName: item['fullName'],
      missingActivityCount: item['missingActivityCount'],
      hasError: item['hasError'],
    );
  }
}
