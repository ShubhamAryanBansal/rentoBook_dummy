
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoginState extends Equatable {

  late  bool? autoValidation = false;
  final bool? passwordSwitch;
  final formKey = GlobalKey<FormState>();
  late final String? token;

  LoginState({
    this.autoValidation,
    this.passwordSwitch,
    this.token
  });

  LoginState copyWith({
    bool? autoValidation,
    bool? passwordSwitch,
    String? token
  }) {
    return LoginState(
        autoValidation: autoValidation ?? this.autoValidation,
        passwordSwitch: passwordSwitch ?? this.passwordSwitch,
        token: token ?? this.token
    );
  }

  @override
  List<Object> get props => [autoValidation!,passwordSwitch!,token ?? ""];
}

