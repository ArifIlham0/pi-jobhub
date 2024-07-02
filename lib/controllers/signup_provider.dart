import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/request/auth/signup_agent_model.dart';
import 'package:jobhub/models/request/auth/signup_model.dart';
import 'package:jobhub/services/helpers/auth_helper.dart';
import 'package:jobhub/views/ui/auth/login.dart';

class SignUpProvider extends ChangeNotifier {
  final signupFormKey = GlobalKey<FormState>();
  final agentFormKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _processing = false;
  bool _firstTime = false;

  bool get obscureText => _obscureText;
  bool get processing => _processing;
  bool get firstTime => _firstTime;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  set processing(bool newValue) {
    _processing = newValue;
    notifyListeners();
  }

  set firstTime(bool newValue) {
    _firstTime = newValue;
    notifyListeners();
  }

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  bool validateAndSave() {
    final form = signupFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  bool validateAndSaveAgent() {
    final form = agentFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  register(SignupModel model) {
    AuthHelper.register(model).then((response) {
      if (response) {
        Get.off(() => LoginPage(),
            transition: Transition.fade, duration: Duration(seconds: 2));
      } else {
        Get.snackbar(
          "Register failed",
          "Please check your email or password",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert),
        );
      }
    });
  }

  registerAgent(SignUpAgent model) {
    AuthHelper.registerAgent(model).then((response) {
      if (response) {
        Get.off(() => LoginPage(),
            transition: Transition.fade, duration: Duration(seconds: 2));
      } else {
        Get.snackbar(
          "Register failed",
          "Please check your email or password",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert),
        );
      }
    });
  }
}
