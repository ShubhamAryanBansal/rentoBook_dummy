import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rento_dummy/cubit/login_cubit.dart';
import 'package:rento_dummy/cubit/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Login_page extends StatelessWidget {


  final password = new TextEditingController();
  final username = new TextEditingController();
  final emailId = new TextEditingController();
  bool _isObscure = true;


  _validateEmail(String value) {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      print('Email_validator_come');
      return "Please Enter Valid Email";
    } else {
      print('Email_validator_null');
      return null;
    }
  }

  _validateUsername(String value) {
    if (value.toString().trim().length == 0) {
      print('Username_validator_come');
      return "Please Enter Valid Username";
    } else {
      print('Username_validator_null');
      return null;
    }
  }

  _validatePassword(String value) {
    if (value.toString().trim().length == 0) {
      print('Password_validator_come');
      return "Please Enter Valid Password";
    } else if (value
        .toString()
        .trim()
        .length < 6) {
      return "Please Enter At least 6 Character Password";
    } else {
      print('Password_validator_null');
      return null;
    }
  }

  Widget _textFields(BuildContext context, TextEditingController textController,
      String hintText, {bool? isUsername, required bool isPassword, bool? isEmail, LoginState? state}) {

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey[200]!))),
      child: !isPassword ? TextFormField(
        controller: textController,
        validator: (String? value) {
          if (isUsername!) {
            _validateUsername(value!);
          } else if (isEmail!) {
            _validateEmail(value!);
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          errorStyle: GoogleFonts.openSans(
            textStyle: TextStyle(fontSize: 12.sp),
          ),
          //TODO FIX THIS
          //errorText:
        ),
      ) : TextFormField(
        controller: textController,
        obscureText: state!.passwordSwitch!,
        validator: (String? value) {
          if (isPassword) {
            String? message = _validatePassword(value!);
            return message;
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              state.passwordSwitch!
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: Color.fromRGBO(255, 127, 80, 1),
            ),
            onPressed: () {
              _isObscure = !_isObscure;
              context.read<LoginCubit>().togglePasswordVisibility(_isObscure);
            },
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          errorStyle: GoogleFonts.openSans(
            textStyle: TextStyle(fontSize: 12.sp),
          ),
        ),
      ),
    );
  }


  Future<void> _persistingSharedPref(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print('Build');
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                          Text(
                            "Login",
                            style: GoogleFonts.playfairDisplay(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 127, 80, 1),
                                fontSize: 30.sp,
                              ),
                            ),
                          ),
                      SizedBox(
                        height: 10.h,
                      ),
                          BlocConsumer<LoginCubit, LoginState>(
                            listener: (context, state) async {
                              if (state.token != null && state.token != "") {
                                print('Token : ${state.token}');
                                //WILL BE PERSISTING DATA IN SHAREDPREF
                                await _persistingSharedPref(state.token ?? "");


                                //showToast("Logged In SuccessFully");

                              } else if (state.token == "") {
                              //  showToast("Error in Logging In");
                              }
                            },
                            builder: (context, state) {
                              _isObscure = state.passwordSwitch!;
                              print('AutoValidation: ${state.autoValidation}');
                              return Form(
                                key: state.formKey,
                                autovalidate: state.autoValidation!,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              255, 127, 80, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10),
                                        )
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      _textFields(context, username, "Username", isUsername: true, isPassword: false, isEmail: false),
                                      _textFields(context, emailId, "Email", isEmail: true, isUsername: false, isPassword: false),
                                      _textFields(context, password, "Password", isPassword: true, isEmail: false, isUsername: false, state: state),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      SizedBox(
                        height: 10.h,
                      ),
                          Center(
                              child: FlatButton(
                                onPressed: () async {
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Color.fromRGBO(
                                              255, 127, 80, 1))),
                                ),
                              )),
                        Container(
                            height: 45.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFFF8A65),
                                  Color(0xFFFF7043),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(255, 127, 80, .3),
                                  blurRadius: 10,
                                  offset: Offset(0, 10),
                                )
                              ],
                            ),
                            child: InkWell(
                              onTap: () async {
                                Map<String, dynamic> body = {
                                  "name": username.text.toString().trim(),
                                  "email": emailId.text.toString().trim(),
                                  "password": password.text.toString().trim()
                                };
                                context.read<LoginCubit>().checkLogin(body, context);
                              },
                              child: Center(
                                child: Text(
                                  'LOGIN',
                                ),
                              ),
                            )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

