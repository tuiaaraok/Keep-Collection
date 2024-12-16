import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geek_collectors/boxes.dart';
import 'package:geek_collectors/data/collection.dart';
import 'package:hive/hive.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:image_picker/image_picker.dart';

class RedactCollaction extends StatefulWidget {
  const RedactCollaction({super.key, required this.index});
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
    _image = contactsBox.getAt(widget.index)!.imageCollection;
    nameCollectionController.text =
        contactsBox.getAt(widget.index)!.nameCollection;
    yearOfProductionController.text =
        contactsBox.getAt(widget.index)!.yearOfProduction;
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
            contactsBox.getAt(widget.index)!.nameCategory,
            style: TextStyle(
                fontSize: 24.sp,
                color: const Color(0xFF4477B1),
                fontWeight: FontWeight.bold),
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
                    nameCategory: contactsBox.getAt(widget.index)!.nameCategory,
                    imageCollection: _image!,
                    nameCollection: nameCollectionController.text,
                    yearOfProduction: yearOfProductionController.text,
                    cost: costController.text,
                    description: descriptionController.text,
                  );
                  contactsBox.putAt(widget.index, addwishfriend);
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: const Color(0xFFD9D9D9),
                  child: const Center(
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
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  getLostData().whenComplete(() {
                    setState(() {});
                  });
                },
                child: SizedBox(
                  width: 390.w,
                  child: Stack(
                    children: [
                      Positioned(
                          right: 10.w,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialog(
                                        index: widget.index,
                                        nameCat: contactsBox
                                            .getAt(widget.index)!
                                            .nameCategory,
                                      ));
                            },
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundColor: const Color(0xFFD9D9D9),
                              child: Center(
                                child: Image(
                                  image: const AssetImage(
                                      "assets/icons/Delete.png"),
                                  color: const Color(0xFF4477B1),
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
                                color: const Color.fromRGBO(85, 69, 184, 0.5),
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
                                backgroundColor:
                                    const Color.fromRGBO(255, 255, 255, 0.12),
                                child: const Image(
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
              SizedBox(
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
                    color: const Color.fromRGBO(68, 119, 177, 0.2),
                    border: Border.all(color: const Color(0xFF4477B1))),
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
              SizedBox(
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
                    color: const Color.fromRGBO(68, 119, 177, 0.2),
                    border: Border.all(color: const Color(0xFF4477B1))),
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
              SizedBox(
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
                    color: const Color.fromRGBO(68, 119, 177, 0.2),
                    border: Border.all(color: const Color(0xFF4477B1))),
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
              SizedBox(
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
                    color: const Color.fromRGBO(68, 119, 177, 0.2),
                    border: Border.all(color: const Color(0xFF4477B1))),
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

// ignore: must_be_immutable
class CustomDialog extends StatelessWidget {
  CustomDialog({super.key, required this.index, required this.nameCat});
  int index;
  String nameCat;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Container(
        height: 300.h,
        width: 310.w,
        padding: const EdgeInsets.only(
          top: 18.0,
        ),
        margin: const EdgeInsets.only(top: 13.0, right: 8.0),
        decoration: BoxDecoration(
            color: const Color(0xFF4477B1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 0.0,
                offset: Offset(0.0, 0.0),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Delete?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('“$nameCat”',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25.sp,
                      color: const Color.fromRGBO(255, 255, 255, 0.5),
                      fontWeight: FontWeight.w600)),
            ),
            GestureDetector(
              onTap: () {
                final constain = Hive.box<Collection>(HiveBoxes.collection);
                constain.deleteAt(index).whenComplete(() {
                  Navigator.pop(
                    // ignore: use_build_context_synchronously
                    context,
                  );
                  Navigator.pop(
                    // ignore: use_build_context_synchronously
                    context,
                  );
                });
              },
              child: Container(
                height: 36.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: Colors.black),
                child: Center(
                    child: Text(
                  "Yes",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Container(
                  height: 36.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      color: Colors.black),
                  child: Center(
                      child: Text(
                    "No",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
