import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable(ignoreUnannotated: false)
class LoginRequestModel {
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'password')
  final String? password;

  LoginRequestModel({this.email, this.password});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
