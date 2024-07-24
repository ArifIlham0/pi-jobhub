import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/auth/login_model.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loading_button.dart';
import 'package:jobhub/views/ui/auth/agent.dart';
import 'package:jobhub/views/ui/auth/reset_password.dart';
import 'package:jobhub/views/ui/auth/signup.dart';
import 'package:jobhub/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        loginProvider.getPrefs();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              text: "Masuk",
              child: loginProvider.entrypoint && loginProvider.loggedIn
                  ? GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(CupertinoIcons.arrow_left),
                    )
                  : SizedBox.shrink(),
              actions: [
                TextButton(
                  onPressed: () => Get.offAll(
                    () => MainScreen(),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 100),
                  ),
                  child: ReusableText(
                    text: "Login nanti",
                    style: appstyle(
                      12,
                      Color(kWhite2.value),
                      FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: loginProvider.loginFormKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  HeightSpacer(size: 50),
                  ReusableText(
                    text: "Selamat Datang!",
                    style: appstyle(30, Color(kWhite2.value), FontWeight.w600),
                  ),
                  ReusableText(
                    text: "Isi kolom dibawah ini untuk login",
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                  ),
                  HeightSpacer(size: 50),
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
                    obscureText: loginProvider.obscureText,
                    validator: (password) {
                      if (password!.isEmpty || password.length < 7) {
                        return "Password tidak boleh kosong dan lebih dari 7";
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        loginProvider.obscureText = !loginProvider.obscureText;
                      },
                      icon: Icon(
                        loginProvider.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color(kWhite2.value),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Color(kWhite2.value).withOpacity(0.1)),
                          ),
                          onPressed: () {
                            Get.to(
                              () => ResetPassword(),
                              transition: Transition.rightToLeft,
                              duration: Duration(milliseconds: 100),
                            );
                          },
                          child: ReusableText(
                            text: "Lupa Password?",
                            style: appstyle(
                                12, Color(kWhite2.value), FontWeight.w500),
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Color(kLightGrey.value),
                                  title: Text(
                                    'Ingin daftar sebagai apa?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(kDarkGrey.value),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: ReusableText(
                                        text: "Pengguna",
                                        style: appstyle(13, Color(kGreen.value),
                                            FontWeight.w600),
                                      ),
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Color(kWhite.value)
                                                .withOpacity(0.1)),
                                      ),
                                      onPressed: () {
                                        Get.offAll(() => RegistrationPage());
                                      },
                                    ),
                                    TextButton(
                                      child: ReusableText(
                                        text: "Mitra",
                                        style: appstyle(13, Color(kGreen.value),
                                            FontWeight.w600),
                                      ),
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Color(kWhite.value)
                                                .withOpacity(0.1)),
                                      ),
                                      onPressed: () {
                                        Get.to(
                                          () => Agent(),
                                          transition: Transition.rightToLeft,
                                          duration: Duration(milliseconds: 100),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: ReusableText(
                            text: "Daftar Pengguna/Mitra",
                            style: appstyle(
                                12, Color(kWhite2.value), FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  HeightSpacer(size: 50),
                  loginProvider.isLoading
                      ? LoadingButton(
                          onTap: () {},
                          isButton: true,
                        )
                      : CustomButton(
                          onTap: () {
                            print("Berhasil");
                            if (loginProvider.validateAndSave()) {
                              LoginModel model = LoginModel(
                                email: email.text,
                                password: password.text,
                              );
                              loginProvider.userLogin(model);
                            } else {
                              print("Gagal");
                              Get.snackbar(
                                "Gagal Login",
                                "Tolong cek kembali inputan anda",
                                colorText: Color(kBlack2.value),
                                backgroundColor: Colors.red,
                                icon: Icon(Icons.add_alert),
                                duration: Duration(milliseconds: 1500),
                              );
                            }
                          },
                          text: "Masuk",
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
