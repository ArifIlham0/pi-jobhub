import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/common/custom_outline_btn.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({
    super.key,
    this.location,
    this.device,
    this.platform,
    this.date,
    this.ipAddress,
  });

  final String? location;
  final String? device;
  final String? platform;
  final String? date;
  final String? ipAddress;

  @override
  Widget build(BuildContext context) {
    var zoomProvider = Provider.of<ZoomProvider>(context);
    var onBoardProvider = Provider.of<OnBoardProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(
          text: device!,
          style: appstyle(22, Color(kDark.value), FontWeight.bold),
        ),
        HeightSpacer(size: 15),
        ReusableText(
          text: platform!,
          style: appstyle(22, Color(kDark.value), FontWeight.bold),
        ),
        HeightSpacer(size: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: date!,
                  style: appstyle(16, Color(kDarkGrey.value), FontWeight.w400),
                ),
                ReusableText(
                  text: ipAddress!,
                  style: appstyle(16, Color(kDarkGrey.value), FontWeight.w400),
                ),
              ],
            ),
            Consumer<LoginProvider>(
              builder: (context, loginProvider, child) {
                return CustomOutlineBtn(
                  onTap: () {
                    onBoardProvider.isLastPage = false;
                    zoomProvider.currentIndex = 0;
                    loginProvider.logout();
                    Get.offAll(() => OnBoardingScreen());
                  },
                  text: "Keluar",
                  color: Color(kLight.value),
                  color2: Color(kOrange.value),
                  height: height * 0.05,
                  width: width * 0.3,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
