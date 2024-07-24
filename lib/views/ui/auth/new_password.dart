import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/auth/new_password_req.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/loading_button.dart';
import 'package:provider/provider.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key, this.tokenPass});

  final String? tokenPass;

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
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
              text: "New Password",
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
              key: loginProvider.newPassKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  HeightSpacer(size: 50),
                  ReusableText(
                    text: "Silahkan Buat Password Baru",
                    style: appstyle(20, Color(kWhite2.value), FontWeight.w600),
                  ),
                  HeightSpacer(size: 50),
                  CustomTextField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    hintText: "Password Baru",
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
                  HeightSpacer(size: 50),
                  loginProvider.isLoading
                      ? LoadingButton(
                          onTap: () {},
                          isButton: true,
                        )
                      : CustomButton(
                          onTap: () {
                            if (loginProvider.validateNewPassword()) {
                              print("Berhasil");
                              NewPasswordReq model = NewPasswordReq(
                                password: password.text,
                              );
                              loginProvider.newPassword(
                                  widget.tokenPass!, model);
                            } else {
                              print("Gagal");
                              Get.snackbar(
                                "Gagal buat password baru",
                                "Tolong cek kembali inputan anda",
                                colorText: Color(kBlack2.value),
                                backgroundColor: Colors.red,
                                icon: Icon(Icons.add_alert),
                                duration: Duration(milliseconds: 1500),
                              );
                            }
                          },
                          text: "Buat",
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
