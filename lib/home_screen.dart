import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geek_collectors/boxes.dart';
import 'package:geek_collectors/data/category.dart';
import 'package:geek_collectors/navigation/navigation.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

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
                    color: Color(0xFF4477B1),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Icon(
              IconsaxPlusBold.house_2,
              size: 24.sp,
              color: Color(0xFF4477B1),
            )
          ],
        ),
        leadingWidth: 120.w,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Container(
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
                      add_category_screen,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 21.h),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF4477B1).withOpacity(0.75),
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
                  child: Container(
                    width: 370,
                    child: Text(
                      "Your category",
                      style:
                          TextStyle(color: Color(0xFF4477B1), fontSize: 20.sp),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box<Category>(HiveBoxes.category).listenable(),
                    builder: (context, Box<Category> box, _) {
                      return box.isEmpty
                          ? Container(
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
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (140.w / 199.h),
      ),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        // Убедитесь, что индекс не выходит за границы
        if (index < friends.length) {
          return buildFriendCard(
            friends[index],
          );
        } else {
          return SizedBox.shrink(); // Безопасно возвращаем пустой вид
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
            Navigator.pop(context, category.name_category);
          } else {
            Navigator.of(
              context,
            ).pushNamed(collection_screen, arguments: category);
          }
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    image: DecorationImage(
                      image: MemoryImage(category.image_category),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                height: 29.h,
                alignment: Alignment.center,
                child: Text(
                  category.name_category,
                  style: TextStyle(color: Colors.white, fontSize: 21.sp),
                ),
              ),
            ],
          ),
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
