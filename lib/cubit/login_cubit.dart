import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginState(
    autoValidation: false,
    passwordSwitch: false,
  ));

  void togglePasswordVisibility(bool newValue) {
    print('togglePasswordVisibility');
    emit(state.copyWith(passwordSwitch: newValue));
  }

  void checkLogin(Map<String,dynamic> body,BuildContext context){
    print('Body $body');
    print('FormResult ${state.formKey.currentState!.validate()}');
    if(state.formKey.currentState!.validate()){
      login(body,context);
      return;
    }else{
      emit(state.copyWith(autoValidation: true));
    }
  }

  void login(Map<String,dynamic> body,BuildContext context) async{

    //MAKING AN API CALL USING CHOPPER
    //state.token = await loginRepository!.login(body, context);
    emit(state);
  }

}
