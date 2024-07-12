import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/admin_provider.dart';
import 'package:jobhub/controllers/chat_provider.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/firebase_options.dart';
import 'package:jobhub/views/ui/splash_screen.dart';
import 'package:provider/provider.dart';
import 'views/common/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnBoardProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => ZoomProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => JobsProvider()),
        ChangeNotifierProvider(create: (context) => BookMarkProvider()),
        ChangeNotifierProvider(create: (context) => ImageUploader()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => AdminProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'JobHunt',
          theme: ThemeData(
            scaffoldBackgroundColor: Color(kBlack2.value),
            iconTheme: IconThemeData(color: Color(kWhite2.value)),
            primarySwatch: Colors.grey,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
