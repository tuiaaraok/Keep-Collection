import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geek_collectors/boxes.dart';
import 'package:geek_collectors/data/collection.dart';
import 'package:geek_collectors/home_screen.dart';
import 'package:geek_collectors/navigation/navigation.dart';
import 'package:hive/hive.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';

class RedactCollaction extends StatefulWidget {
  RedactCollaction({required this.index});
  final int index;
  @override
  State<RedactCollaction> createState() => _RedactCollactionState();
}

class _RedactCollactionState extends State<RedactCollaction> {
  TextEditingController nameCollectionController = TextEditingController();
  TextEditingController yearOfProductionController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late Box<Collection> contactsBox;
  Uint8List? _image;
  Future getLostData() async {
    XFile? picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker == null) return;
    List<int> imageBytes = await picker.readAsBytes();
    _image = Uint8List.fromList(imageBytes);
  }

  @override
  void initState() {
    super.initState();
    contactsBox = Hive.box<Collection>(HiveBoxes.collection);
    _image = contactsBox.getAt(widget.index)!.image_collection;
    nameCollectionController.text =
        contactsBox.getAt(widget.index)!.name_collection;
    yearOfProductionController.text =
        contactsBox.getAt(widget.index)!.year_of_production;
    costController.text = contactsBox.getAt(widget.index)!.cost;
    descriptionController.text = contactsBox.getAt(widget.index)!.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Text(
            "Add the first category",
            style: TextStyle(color: Colors.white, fontSize: 24.sp),
          ),
        ),
        actions: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child: GestureDetector(
                onTap: () {
                  Collection addwishfriend = Collection(
                    name_category:
                        contactsBox.getAt(widget.index)!.name_category,
                    image_collection: _image!,
                    name_collection: nameCollectionController.text,
                    year_of_production: yearOfProductionController.text,
                    cost: costController.text,
                    description: descriptionController.text,
                  );
                  contactsBox.putAt(widget.index, addwishfriend);
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Color(0xFFD9D9D9),
                  child: Center(
                      child: Icon(
                    IconsaxPlusLinear.edit_2,
                    color: Color(0xFF4477B1),
                  )),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  getLostData().whenComplete(() {
                    setState(() {});
                  });
                },
                child: Container(
                  width: 390.w,
                  child: Stack(
                    children: [
                      Positioned(
                          right: 10.w,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              contactsBox.deleteAt(widget.index);
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Color(0xFFD9D9D9),
                              child: Center(
                                child: Image(
                                  image: AssetImage("assets/icons/Delete.png"),
                                  color: Color(0xFF4477B1),
                                  fit: BoxFit.fill,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                              ),
                            ),
                          )),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
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
                          Center(
                            child: Container(
                              height: 170.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                color: Color(0xFF5545B8).withOpacity(0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r)),
                                image: _image == null
                                    ? null
                                    : DecorationImage(
                                        image: MemoryImage(_image!),
                                        fit: BoxFit.cover),
                              ),
                              child: Center(
                                  child: CircleAvatar(
                                radius: 30.r,
                                backgroundColor: Colors.white.withOpacity(0.12),
                                child: Image(
                                    image:
                                        AssetImage("assets/icons/Image.png")),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 75.h,
              ),
              Container(
                width: 310.w,
                child: Text(
                  "Name of collection",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 55.h,
                width: 310.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: Color(0xFF4477B1).withOpacity(0.2),
                    border: Border.all(color: Color(0xFF4477B1))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Center(
                    child: TextField(
                      controller: nameCollectionController,
                      decoration: InputDecoration(
                          border: InputBorder.none, // Убираем обводку
                          focusedBorder:
                              InputBorder.none, // Убираем обводку при фокусе
                          hintText: 'Collection',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 18.sp)),
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.transparent,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                      onChanged: (text) {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Container(
                width: 310.w,
                child: Text(
                  "Year of production",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 55.h,
                width: 310.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: Color(0xFF4477B1).withOpacity(0.2),
                    border: Border.all(color: Color(0xFF4477B1))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Center(
                    child: TextField(
                      controller: yearOfProductionController,
                      decoration: InputDecoration(
                          border: InputBorder.none, // Убираем обводку
                          focusedBorder:
                              InputBorder.none, // Убираем обводку при фокусе
                          hintText: 'XX.XX.XXXX',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 18.sp)),
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.transparent,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                      onChanged: (text) {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Container(
                width: 310.w,
                child: Text(
                  "Cost",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 55.h,
                width: 310.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: Color(0xFF4477B1).withOpacity(0.2),
                    border: Border.all(color: Color(0xFF4477B1))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Center(
                    child: TextField(
                      controller: costController,
                      decoration: InputDecoration(
                          border: InputBorder.none, // Убираем обводку
                          focusedBorder:
                              InputBorder.none, // Убираем обводку при фокусе
                          hintText: '\$',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 18.sp)),
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.transparent,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                      onChanged: (text) {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Container(
                width: 310.w,
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 120.h,
                width: 310.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: Color(0xFF4477B1).withOpacity(0.2),
                    border: Border.all(color: Color(0xFF4477B1))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: TextField(
                    maxLines: 6,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        border: InputBorder.none, // Убираем обводку
                        focusedBorder:
                            InputBorder.none, // Убираем обводку при фокусе
                        hintText: 'Description',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 18.sp)),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.transparent,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp),
                    onChanged: (text) {},
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
