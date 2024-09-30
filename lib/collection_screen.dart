import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geek_collectors/boxes.dart';
import 'package:geek_collectors/data/collection.dart';
import 'package:geek_collectors/navigation/navigation.dart';
import 'data/category.dart' as cat;

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'data/category.dart' as cat;

class CollectionScreen extends StatefulWidget {
  CollectionScreen({super.key, this.category});
  cat.Category? category;

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  late Box<Collection> contactsBox;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<Collection>(HiveBoxes.collection).listenable(),
        builder: (context, Box<Collection> box, _) {
          List<int> indexCollection = [];
          int i = 0;
          List<Collection> friends = [];

          if (widget.category == null) {
            friends = box.values.toList();
          } else {
            friends = box.values.toList().where(
              (element) {
                if (element.name_category == widget.category!.name_category) {
                  indexCollection.add(i);
                }
                i++;
                return element.name_category == widget.category!.name_category;
              },
            ).toList();
          }
          return Scaffold(
            appBar: AppBar(
                leading: Text(
                  widget.category == null
                      ? "Full collection"
                      : friends.isEmpty
                          ? ""
                          : widget.category!.name_category,
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: Color(0xFF4477B1),
                      fontWeight: FontWeight.bold),
                ),
                leadingWidth:
                    widget.category != null && friends.isEmpty ? 0 : 340.w,
                title: widget.category != null && friends.isEmpty
                    ? Text(
                        "Collection",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp),
                      )
                    : SizedBox.shrink()),
            body: SingleChildScrollView(
              child: Container(
                width: 390.w,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: widget.category == null
                          ? SizedBox.shrink()
                          : SizedBox(
                              width: 340.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.arrow_back_ios,
                                      color: Colors.white, size: 14.w),
                                  Text(
                                    "Back",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    widget.category != null && friends.isEmpty
                        ? SizedBox(
                            width: 340.w,
                            child: Text(
                              widget.category!.name_category,
                              style: TextStyle(
                                  fontSize: 20.sp, color: Color(0xFF4477B1)),
                            ),
                          )
                        : SizedBox.shrink(),
                    widget.category == null
                        ? SizedBox.shrink()
                        : friends.isEmpty
                            ? Container(
                                width: 340.w,
                                decoration: BoxDecoration(
                                    color: Color(0xFF4477B1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(24.r))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Container(
                                    width: 280.h,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 280.w,
                                          height: 280.h,
                                          child: Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(
                                                    context,
                                                  ).pushNamed(
                                                      add_collection_page,
                                                      arguments: widget.category
                                                          ?.name_category);
                                                },
                                                child: Center(
                                                  child: Container(
                                                    width: 180.w,
                                                    height: 210.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.r)),
                                                        image: DecorationImage(
                                                            image: MemoryImage(
                                                              widget.category!
                                                                  .image_category,
                                                            ),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: 0.h,
                                                  left: 170.w,
                                                  child: Center(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(
                                                          context,
                                                        ).pushNamed(
                                                            add_collection_page,
                                                            arguments: widget
                                                                .category
                                                                ?.name_category);
                                                      },
                                                      child: Container(
                                                        width: 88.w,
                                                        height: 93.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              const DecorationImage(
                                                            image: AssetImage(
                                                                "assets/images/add_collection.png"),
                                                            fit: BoxFit
                                                                .fitHeight,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: 280.w,
                                            child: Text(
                                              "Empty",
                                              style: TextStyle(
                                                  fontSize: 28.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF000000)
                                                      .withOpacity(0.5)),
                                            )),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16.h),
                                          child: SizedBox(
                                              width: 280.w,
                                              child: Text(
                                                "You don't have any\ncategory yet",
                                                style: TextStyle(
                                                    fontSize: 24.sp,
                                                    height: 1.h,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushNamed(add_collection_page,
                            arguments: widget.category?.name_category);
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
                      "Add a new collection",
                      style: kSubtitleStyle,
                    ),
                    widget.category == null
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: 20.h,
                                bottom: 20.h,
                                left: 24.w,
                                right: 24.w),
                            child: Container(
                              width: 370,
                              child: Text(
                                "Your collection",
                                style: TextStyle(
                                    color: Color(0xFF4477B1),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: widget.category == null && friends.isEmpty
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
                                    "Your collection",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          : buildGrid(indexCollection, friends
                              //  widget.category
                              ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  GridView buildGrid(List<int> indexCollection, List<Collection> friends
      // cat.Category? category,
      ) {
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
        final currentIndex = friends.length - index - 1;
        if (index < friends.length) {
          return buildFriendCard(
              friends[currentIndex],
              indexCollection.isEmpty
                  ? currentIndex
                  : indexCollection[currentIndex]);
        } else {
          return SizedBox.shrink(); // Безопасно возвращаем пустой вид
        }
      },
    );
  }

  Padding buildFriendCard(Collection collection, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(redact_collection, arguments: index);
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    image: DecorationImage(
                      image: MemoryImage(collection.image_collection),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  collection.name_collection,
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
