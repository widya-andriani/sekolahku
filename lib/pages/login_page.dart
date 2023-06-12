import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/app_service.dart';
import 'package:sekolahku/navigation/app_navigation.dart';
import 'package:sekolahku/pages/student_page.dart';
import 'package:sekolahku/res/color_res.dart';
import 'package:sekolahku/res/dimen_res.dart';
import 'package:sekolahku/res/icon_res.dart';
import 'package:sekolahku/util/dialog_ext.dart';
import 'package:sekolahku/util/navigation_ext.dart';
import 'package:sekolahku/util/snackbar_ext.dart';
import 'package:sekolahku/widgets/button.dart';

import '../res/string_res.dart';
import '../widgets/input.dart';

class LoginPage extends StatefulWidget {

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  var loginEnabled = true;
  var _isButtonAlreadyHitOnce = false;
  final _formKey = GlobalKey<FormState>();

  void _login(BuildContext context) {
    var username = _usernameCtrl.text;
    var password = _passwordCtrl.text;
    _isButtonAlreadyHitOnce = true;

    final formState = _formKey.currentState;
    if(formState != null) {
      _togleBtn();
      loginEnabled = formState.validate();
      final service = AppService.userService;

      if(loginEnabled) {
        context.showLoadingDialog(
            message: "Please Wait",
            future: service.login(username, password),
            onGetResult: (v) => context.startListPage(),
            onGetError: (e,s) => context.showErrorSnackBar(e.toString()));
      }
    }
  }

  void _togleBtn() {
    if(_isButtonAlreadyHitOnce) {
      setState(() {
        final formState = _formKey.currentState;
        if(formState != null) {
          loginEnabled = formState.validate();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            StringRes.login,
            style: TextStyle(color: ColorRes.white),
          ),
          backgroundColor: ColorRes.red,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(DimenRes.size_16),
              child: Column(
                children: [
                  Image.asset(
                    IconRes.appLogo,
                    width: DimenRes.size_100,
                    height: DimenRes.size_100,
                  ),
                  Input(
                    label: StringRes.username,
                    keyboardType: TextInputType.emailAddress,
                    marginTop: DimenRes.size_16,
                    controller: _usernameCtrl,
                    onChanged: (input) => _togleBtn(),
                    validator: (input) {
                      if(input == null || input.isEmpty) {
                        return StringRes.required;
                      }
                      return null;
                    },
                  ),
                  Input(
                    label: StringRes.password,
                    obscureText: true,
                    marginTop: DimenRes.size_16,
                    controller: _passwordCtrl,
                    onChanged: (input) => _togleBtn(),
                    validator: (input) {
                      if(input == null || input.isEmpty) {
                        return StringRes.required;
                      }
                      return null;
                    },
                  ),
                  PrimaryButton(
                    label: StringRes.login,
                    enabled: loginEnabled,
                    onPressed: () => _login(context),
                    marginTop: DimenRes.size_16,
                  )
                ],
              ),
            ),),
        ));
  }
}
