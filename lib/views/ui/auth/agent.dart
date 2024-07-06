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
                    style: appstyle(22, Color(kWhite2.value), FontWeight.w600),
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
                          "Gagal",
                          "Tolong cek kembali inputan anda",
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
