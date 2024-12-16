import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geek_collectors/collection_screen.dart';
import 'package:geek_collectors/home_screen.dart';
import 'package:geek_collectors/info_page.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    super.key,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentIndex = 1;
  List<Widget> menuBody = [CollectionScreen(), HomeScreen(), const InfoPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 75.h,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                currentIndex = 0;
                setState(() {});
              },
              child: Container(
                width: 60.w,
                height: 75.h,
                decoration: BoxDecoration(
                    color: currentIndex == 0 ? const Color(0xFF4477B1) : null,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100.r),
                        topLeft: Radius.circular(100.r))),
                child: Padding(
                  padding: currentIndex == 0
                      ? EdgeInsets.only(bottom: 2.h)
                      : const EdgeInsets.all(0),
                  child: Icon(
                    IconsaxPlusLinear.edit,
                    color: currentIndex == 0
                        ? Colors.white
                        : const Color.fromRGBO(68, 119, 177, 0.5),
                    size: 30.h,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                currentIndex = 1;
                setState(() {});
              },
              child: Container(
                width: 60.w,
                height: 75.h,
                decoration: BoxDecoration(
                    color: currentIndex == 1 ? const Color(0xFF4477B1) : null,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100.r),
                        topLeft: Radius.circular(100.r))),
                child: Padding(
                  padding: currentIndex == 1
                      ? EdgeInsets.only(bottom: 2.h)
                      : const EdgeInsets.all(0),
                  child: Icon(
                    IconsaxPlusLinear.house_2,
                    color: currentIndex == 1
                        ? Colors.white
                        : const Color.fromRGBO(68, 119, 177, 0.5),
                    size: 30.h,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                currentIndex = 2;
                setState(() {});
              },
              child: Container(
                width: 60.w,
                height: 75.h,
                decoration: BoxDecoration(
                    color: currentIndex == 2 ? const Color(0xFF4477B1) : null,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100.r),
                        topLeft: Radius.circular(100.r))),
                child: Padding(
                  padding: currentIndex == 2
                      ? EdgeInsets.only(bottom: 2.h)
                      : const EdgeInsets.all(0),
                  child: Icon(
                    IconsaxPlusLinear.setting_2,
                    color: currentIndex == 2
                        ? Colors.white
                        : const Color.fromRGBO(68, 119, 177, 0.5),
                    size: 30.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: menuBody[currentIndex],
    );
  }
}
