import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/auth/signup_model.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/auth/agent.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context);

    return Consumer<SignUpProvider>(
      builder: (context, signUpProvider, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              text: "Daftar",
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: signUpProvider.signupFormKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  HeightSpacer(size: 50),
                  ReusableText(
                    text: "Halo, Selamat datang!",
                    style: appstyle(27, Color(kWhite2.value), FontWeight.w600),
                  ),
                  ReusableText(
                    text: "Isi di bawah ini untuk daftar",
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                  ),
                  HeightSpacer(size: 40),
                  CustomTextField(
                    controller: name,
                    keyboardType: TextInputType.text,
                    hintText: "Nama",
                    validator: (name) {
                      if (name!.isEmpty) {
                        return "Tolong masukkan nama anda";
                      } else {
                        return null;
                      }
                    },
                  ),
                  HeightSpacer(size: 20),
                  CustomTextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                    validator: (email) {
                      if (email!.isEmpty || !email.contains('@')) {
                        return "Tolong masukkan format email yang benar";
                      } else {
                        return null;
                      }
                    },
                  ),
                  HeightSpacer(size: 20),
                  CustomTextField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    hintText: "Password",
                    obscureText: signUpProvider.obscureText,
                    validator: (password) {
                      if (password!.isEmpty || password.length < 8) {
                        return "Password minimal ada huruf besar, angka, simbol,\ndan lebih dari 8";
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        signUpProvider.obscureText =
                            !signUpProvider.obscureText;
                      },
                      icon: Icon(
                        signUpProvider.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color(kWhite2.value),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Color(kWhite2.value).withOpacity(0.1)),
                      ),
                      onPressed: () {
                        Get.offAll(() => LoginPage());
                      },
                      child: ReusableText(
                        text: "Masuk",
                        style:
                            appstyle(14, Color(kWhite2.value), FontWeight.w500),
                      ),
                    ),
                  ),
                  HeightSpacer(size: 10),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Color(kWhite2.value).withOpacity(0.1)),
                      ),
                      onPressed: () {
                        Get.to(
                          () => Agent(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 100),
                        );
                      },
                      child: RichText(
                          text: TextSpan(
                        text: "Ingin mencari kandidat? ",
                        style: appstyle(
                            12, Color(kDarkGrey.value), FontWeight.w500),
                        children: [
                          TextSpan(
                            text: "Daftar sebagai mitra",
                            style: appstyle(
                                12, Color(kWhite2.value), FontWeight.w500),
                          ),
                        ],
                      )),
                    ),
                  ),
                  CustomButton(
                    onTap: () async {
                      loginProvider.firstTime = !loginProvider.firstTime;

                      if (signUpProvider.validateAndSave()) {
                        SignupModel model = SignupModel(
                          username: name.text,
                          email: email.text,
                          password: password.text,
                        );
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('firstTime', true);
                        signUpProvider.register(model);
                      } else {
                        Get.snackbar(
                          "Gagal",
                          "Tolong periksa kembali inputan anda",
                          colorText: Color(kBlack2.value),
                          backgroundColor: Colors.red,
                          icon: Icon(Icons.add_alert),
                          duration: Duration(milliseconds: 1500),
                        );
                      }
                    },
                    text: "Daftar",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
