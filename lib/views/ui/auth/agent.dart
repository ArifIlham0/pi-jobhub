import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/auth/signup_agent_model.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Agent extends StatefulWidget {
  const Agent({super.key});

  @override
  State<Agent> createState() => _AgentState();
}

class _AgentState extends State<Agent> {
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
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(CupertinoIcons.arrow_left),
                )),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: signUpProvider.agentFormKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  HeightSpacer(size: 50),
                  ReusableText(
                    text: "Halo, Cari karyawranmu!",
                    style: appstyle(22, Color(kDark.value), FontWeight.w600),
                  ),
                  ReusableText(
                    text: "Isi di bawah ini untuk daftar sebagai mitra",
                    style:
                        appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                  ),
                  HeightSpacer(size: 40),
                  CustomTextField(
                    controller: name,
                    keyboardType: TextInputType.text,
                    hintText: "Nama Perusahaan",
                    validator: (name) {
                      if (name!.isEmpty) {
                        return "Tolong masukkan nama perusahaan anda";
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
                        return "Please enter a valid email";
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
                        return "Password at least one uppercase, one digit, special character, and length 8";
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
                        color: Color(kDark.value),
                      ),
                    ),
                  ),
                  HeightSpacer(size: 50),
                  CustomButton(
                    onTap: () async {
                      loginProvider.firstTime = !loginProvider.firstTime;

                      if (signUpProvider.validateAndSaveAgent()) {
                        SignUpAgent model = SignUpAgent(
                          username: name.text,
                          email: email.text,
                          password: password.text,
                          isAgent: true,
                        );
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('firstTime', true);
                        await prefs.setBool('agent', true);
                        signUpProvider.registerAgent(model);
                      } else {
                        Get.snackbar(
                          "Register failed",
                          "Please check your email or password",
                          colorText: Color(kLight.value),
                          backgroundColor: Colors.red,
                          icon: Icon(Icons.add_alert),
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
