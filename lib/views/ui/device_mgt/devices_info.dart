import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/app_style.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/device_mgt/widgets/device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceManagement extends StatefulWidget {
  const DeviceManagement({super.key});

  @override
  State<DeviceManagement> createState() => _DeviceManagementState();
}

class _DeviceManagementState extends State<DeviceManagement> {
  String deviceBrand = 'Loading device info...';
  String deviceModel = 'Loading device info...';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDeviceInfo();
    });
  }

  Future<void> _loadDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        print(androidInfo.brand);
        setState(() {
          deviceBrand = androidInfo.brand;
          deviceModel = androidInfo.model;
        });
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceBrand = iosInfo.name;
        });
      }
    } catch (e) {
      setState(() {
        deviceBrand = 'Failed to get device info: $e';
        deviceModel = 'Failed to get device info: $e';
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String date = DateTime.now().toString();
    var loginDate = date.substring(0, 11);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Perangkat",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightSpacer(size: 50),
              Text(
                "Kamu masuk dari perangkat berikut ini",
                style: appstyle(15, Color(kDark.value), FontWeight.normal),
              ),
              HeightSpacer(size: 50),
              DeviceInfo(
                location: "Lagos, Nigeria",
                device: deviceBrand,
                platform: "Platform: Android",
                date: loginDate,
                ipAddress: deviceModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
