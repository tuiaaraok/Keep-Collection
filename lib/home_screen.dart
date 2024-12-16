import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geek_collectors/boxes.dart';
import 'package:geek_collectors/data/category.dart';
import 'package:geek_collectors/navigation/navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.isCreateCollection = false});
  bool? isCreateCollection;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Category> contactsBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                "Home",
                style: TextStyle(
                    fontSize: 24.sp,
                    color: const Color(0xFF4477B1),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Icon(
              IconsaxPlusBold.house_2,
              size: 24.sp,
              color: const Color(0xFF4477B1),
            )
          ],
        ),
        leadingWidth: 120.w,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: SizedBox(
            width: 390.w,
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(
                      addCategoryScreen,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 21.h),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(68, 119, 177, 0.75),
                      radius: 45.r,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 54.sp,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Add a new category",
                  style: kSubtitleStyle,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: SizedBox(
                    width: 370.w,
                    child: Text(
                      "Your category",
                      style: TextStyle(
                          color: const Color(0xFF4477B1), fontSize: 20.sp),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Category>(HiveBoxes.category).listenable(),
                    builder: (context, Box<Category> box, _) {
                      return box.isEmpty
                          ? SizedBox(
                              height: 370.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "#Empty",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Add the first wish",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          : buildGrid(box);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  GridView buildGrid(Box<Category> box) {
    List<Category> friends = box.values.toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (140.w / 199.h),
      ),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final currentIndex = box.length - index - 1;
        if (index < friends.length) {
          return buildFriendCard(
            friends[currentIndex],
          );
        } else {
          return const SizedBox.shrink(); // Безопасно возвращаем пустой вид
        }
      },
    );
  }

  Padding buildFriendCard(
    Category category,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: GestureDetector(
        onTap: () {
          if (widget.isCreateCollection == true) {
            Navigator.pop(context, category.nameCategory);
          } else {
            Navigator.of(
              context,
            ).pushNamed(collectionScreen, arguments: category);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  image: DecorationImage(
                    image: MemoryImage(category.imageCategory),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                category.nameCategory,
                style: TextStyle(color: Colors.white, fontSize: 21.sp),
              ),
            ),
          ],
        ),
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
