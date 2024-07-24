import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/auth/reset_password_req.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loading_button.dart';
import 'package:jobhub/views/ui/auth/new_password.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
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
              text: "Reset Password",
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(CupertinoIcons.arrow_left),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: loginProvider.resetPassKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  HeightSpacer(size: 50),
                  ReusableText(
                    text: "Silahkan Inputkan Email Untuk Reset Password",
                    style: appstyle(20, Color(kWhite2.value), FontWeight.w600),
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
                  HeightSpacer(size: 50),
                  loginProvider.isLoading
                      ? LoadingButton(
                          onTap: () {},
                          isButton: true,
                        )
                      : CustomButton(
                          onTap: () async {
                            print("Berhasil");
                            if (loginProvider.validateResetPassword()) {
                              ResetPasswordReq model = ResetPasswordReq(
                                email: email.text,
                              );
                              String? tokenPass =
                                  await loginProvider.resetPassword(model);
                              if (tokenPass != null) {
                                Get.off(
                                    () => NewPassword(
                                          tokenPass: tokenPass,
                                        ),
                                    transition: Transition.rightToLeft,
                                    duration: Duration(milliseconds: 100));
                              }
                            } else {
                              print("Gagal");
                              Get.snackbar(
                                "Gagal reset password",
                                "Tolong cek kembali inputan anda",
                                colorText: Color(kBlack2.value),
                                backgroundColor: Colors.red,
                                icon: Icon(Icons.add_alert),
                                duration: Duration(milliseconds: 1500),
                              );
                            }
                          },
                          text: "Reset",
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
