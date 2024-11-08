import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geek_collectors/navigation/navigation.dart';

class CreateFirstCategory extends StatelessWidget {
  const CreateFirstCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 330.w,
                decoration: BoxDecoration(
                    color: const Color(0xFF4477B1),
                    borderRadius: BorderRadius.circular(24.r)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: SizedBox(
                    width: 280.h,
                    child: Column(
                      children: [
                        Container(
                          width: 280.w,
                          height: 280.h,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage(
                                      "assets/images/empty_category.png"))),
                        ),
                        SizedBox(
                            width: 280.w,
                            child: Text(
                              "Empty",
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color(0xFF000000).withOpacity(0.5)),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: SizedBox(
                              width: 280.w,
                              child: Text(
                                "You don't have any\ncategory yet",
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    height: 1.h,
                                    fontWeight: FontWeight.w700),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                "Сreate one now!",
                style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(
                    addCategoryScreen,
                    arguments: true,
                  );
                },
                child: Container(
                  width: 320.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: const Color(0xFF4477B1),
                      borderRadius: BorderRadius.all(Radius.circular(18.r))),
                  child: Center(
                    child: Text(
                      "Create",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
