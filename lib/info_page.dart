import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4477B1)),
              ),
            ),
            Icon(
              IconsaxPlusLinear.setting_2,
              color: Color(0xFF4477B1),
              size: 24.h,
            )
          ],
        ),
        leadingWidth: 160.w,
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    String? encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }

                    // ···
                    final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'TravisJohnson9902@outlook.com',
                      query: encodeQueryParameters(<String, String>{
                        '': '',
                      }),
                    );
                    try {
                      if (await canLaunchUrl(emailLaunchUri)) {
                        await launchUrl(emailLaunchUri);
                      } else {
                        throw Exception("Could not launch $emailLaunchUri");
                      }
                    } catch (e) {
                      print(
                          'Error launching email client: $e'); // Log the error
                    }
                  },
                  child: Container(
                    width: 310.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                        color: Color(0xFF4477B1),
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 21.h + 10.w,
                        ),
                        Expanded(
                          child: Text(
                            "Contact us",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                            textAlign: TextAlign.center, // Центрируем текст
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 21.h,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    final Uri _url = Uri.parse('https://flutter.dev');
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  child: Container(
                    width: 310.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                        color: Color(0xFF4477B1),
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 21.h + 10.w,
                        ),
                        Expanded(
                          child: Text(
                            "Privacy policy",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                            textAlign: TextAlign.center, // Центрируем текст
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 21.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    LaunchReview.launch(
                        androidAppId: "app.openauthenticator",
                        iOSAppId: "585027354");
                  },
                  child: Container(
                    width: 310.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                        color: Color(0xFF4477B1),
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 21.h + 10.w,
                        ),
                        Expanded(
                          child: Text(
                            "Rate us",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                            textAlign: TextAlign.center, // Центрируем текст
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 21.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
