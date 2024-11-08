import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geek_collectors/navigation/navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: isActive ? 6.0.h : 6.h,
      width: isActive ? 35.w : 20.h,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4477B1) : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    child: PageView(
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: const <Widget>[
                        WidgetForOnBoardingInfo(
                          assetImage: 'assets/images/create_section.png',
                          title: 'Add sections with\ncollections!',
                          subtitle:
                              'Create a section with your\ncollections, record and add the image\nyou need',
                        ),
                        WidgetForOnBoardingInfo(
                          assetImage: 'assets/images/buy_add.png',
                          title: 'Do you have the things\nyou want?',
                          subtitle:
                              "Add what you plan to buy in the\nfuture, keep track of your goals",
                        ),
                        WidgetForOnBoardingInfo(
                          assetImage: 'assets/images/update_collection.png',
                          title: 'Update and edit your\ncollection!',
                          subtitle: "Add different items, edit the\ncollection",
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_currentPage == 2) {
                          Navigator.pushNamed(context, createFirstCategory);
                        }
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        width: 320.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: const Color(0xFF4477B1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(
                              'https://docs.google.com/document/d/1yHOPBUMcVkKtSBBL5AZURSEPIsRNA4Rfdp9UrTkcUho/mobilebasic');
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Terms of use",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.sp),
                              child: Container(
                                width: 1,
                                height: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetForOnBoardingInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetImage;

  const WidgetForOnBoardingInfo(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40.h, bottom: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(
              assetImage,
            ),
            fit: BoxFit.fitHeight,
            height: 280.h,
            width: 280.w,
          ),
          SizedBox(height: 30.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: kTitleStyle,
          ),
          SizedBox(height: 15.h),
          SizedBox(
            width: 380.w,
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: kSubtitleStyle,
            ),
          ),
        ],
      ),
    );
  }
}

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 24.sp,
);

final kSubtitleStyle = TextStyle(
  color: Colors.grey,
  fontSize: 18.sp,
);
