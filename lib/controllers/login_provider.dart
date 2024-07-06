import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/request/auth/login_model.dart';
import 'package:jobhub/models/request/auth/profile_update_model.dart';
import 'package:jobhub/services/helpers/auth_helper.dart';
import 'package:jobhub/views/ui/auth/update_agent.dart';
import 'package:jobhub/views/ui/auth/update_user.dart';
import 'package:jobhub/views/ui/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  final profileFormKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _firstTime = true;
  bool? _entrypoint;
  bool? _loggedIn;
  bool _isLoading = false;

  bool get obscureText => _obscureText;
  bool get firstTime => _firstTime;
  bool get entrypoint => _entrypoint ?? false;
  bool get loggedIn => _loggedIn ?? false;
  bool get isLoading => _isLoading;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  set firstTime(bool value) {
    _firstTime = value;
    notifyListeners();
  }

  set entrypoint(bool value) {
    _entrypoint = value;
    notifyListeners();
  }

  set loggedIn(bool value) {
    _loggedIn = value;
    notifyListeners();
  }

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    entrypoint = prefs.getBool('entrypoint') ?? false;
    loggedIn = prefs.getBool('loggedIn') ?? false;
    firstTime = prefs.getBool('firstTime') ?? true;
  }

  bool validateAndSave() {
    final form = loginFormKey.currentState;

    if (form != null && form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  bool validateProfile() {
    final form = profileFormKey.currentState;

    if (form != null && form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  userLogin(LoginModel model) async {
    setIsLoading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? firstTimes = await prefs.getBool('firstTime');
    bool? agent = await prefs.getBool('agent');
    print("Ini first time ${firstTimes}");
    AuthHelper.login(model).then((response) {
      setIsLoading = false;
      if (response && firstTimes == true && agent != true) {
        Get.off(() => PersonalDetails());
      } else if (response && !firstTime) {
        Get.off(() => MainScreen());
      } else if (response && agent == true) {
        Get.off(() => UpdateAgent());
      } else if (response && firstTimes == null) {
        Get.off(() => MainScreen());
      } else if (!response) {
        Get.snackbar(
          "Gagal login",
          "Tolong cek kembali inputan anda",
          colorText: Color(kBlack2.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert),
          duration: Duration(milliseconds: 1500),
        );
      }
    });
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.setBool('firstTime', false);
    await prefs.remove('token');
    _firstTime = false;
  }

  Future<void> updateProfile(ProfileUpdateReq model) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String? userId = await prefs.getString('userId');
      print(userId);

      AuthHelper.updateProfile(model, userId ?? "").then((response) {
        if (response) {
          Get.snackbar(
            "Berhasil Update Profile",
            "Silahkan cari pekerjaan impianmu!",
            colorText: Color(kBlack2.value),
            backgroundColor: Color(kGreen2.value),
            icon: Icon(Icons.add_alert),
            duration: Duration(milliseconds: 1500),
          );
          Future.delayed(Duration(seconds: 2)).then(
            (value) => Get.offAll(() => MainScreen()),
          );
        } else {
          Get.snackbar(
            "Gagal",
            "Tolong periksa kembali inputan anda",
            colorText: Color(kBlack2.value),
            backgroundColor: Color(kGreen.value),
            icon: Icon(Icons.add_alert),
            duration: Duration(milliseconds: 1500),
          );
        }
      });
    } finally {
      setIsLoading = false;
    }
  }

  Future<void> updateAgent(ProfileUpdateReq model) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String? userId = await prefs.getString('userId');
      print(userId);

      AuthHelper.updateProfile(model, userId ?? "").then((response) {
        if (response) {
          Get.snackbar(
            "Berhasil perbarui profil",
            "Temukan kandidat terbaikmu!",
            colorText: Color(kBlack2.value),
            backgroundColor: Color(kGreen2.value),
            icon: Icon(Icons.add_alert),
            duration: Duration(milliseconds: 1500),
          );
          Future.delayed(Duration(seconds: 1)).then(
            (value) => Get.offAll(() => MainScreen()),
          );
        } else {
          Get.snackbar(
            "Gagal",
            "Tolong periksa kembali inputan anda",
            colorText: Color(kBlack2.value),
            backgroundColor: Color(kGreen.value),
            icon: Icon(Icons.add_alert),
            duration: Duration(milliseconds: 1500),
          );
        }
      });
    } finally {
      setIsLoading = false;
    }
  }
}
