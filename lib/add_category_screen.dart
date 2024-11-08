import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geek_collectors/boxes.dart';
import 'package:geek_collectors/data/category.dart';
import 'package:geek_collectors/navigation/navigation.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddCategoryScreen extends StatefulWidget {
  AddCategoryScreen({super.key, this.isFistCategory = false});
  bool? isFistCategory;
  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController nameController = TextEditingController();

  Uint8List? _image;
  Future getLostData() async {
    XFile? picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker == null) return;
    List<int> imageBytes = await picker.readAsBytes();
    _image = Uint8List.fromList(imageBytes);
  }

  _updateFormCompletion() {
    bool isFilled = nameController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        _image != null;
    setState(() {});
    return isFilled;
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(_updateFormCompletion);
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
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                width: 310.w,
                child: Text(
                  "Pick an image",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 38.h,
              ),
              GestureDetector(
                onTap: () {
                  getLostData().whenComplete(() {
                    _updateFormCompletion();
                  });
                },
                child: Container(
                  height: 170.h,
                  width: 140.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4477B1).withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    image: _image == null
                        ? null
                        : DecorationImage(
                            image: MemoryImage(_image!), fit: BoxFit.cover),
                  ),
                  child: Center(
                      child: CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.white.withOpacity(0.12),
                    child: const Image(
                        image: AssetImage("assets/icons/Image.png")),
                  )),
                ),
              ),
              SizedBox(
                height: 75.h,
              ),
              SizedBox(
                width: 310.w,
                child: Text(
                  "Name of category",
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
                    color: const Color(0xFF4477B1).withOpacity(0.2),
                    border: Border.all(color: const Color(0xFF4477B1))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Center(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: InputBorder.none, // Убираем обводку
                          focusedBorder:
                              InputBorder.none, // Убираем обводку при фокусе
                          hintText: 'Category',
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
                height: 139.h,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                  GestureDetector(
                    onTap: () {
                      if (_updateFormCompletion()) {
                        Box<Category> contactsBox =
                            Hive.box<Category>(HiveBoxes.category);
                        Category addwishfriend = Category(
                          nameCategory: nameController.text,
                          imageCategory: _image!,
                        );
                        contactsBox.add(addwishfriend);
                        if (widget.isFistCategory == false) {
                          Navigator.of(
                            context,
                          ).pop();
                        } else {
                          Navigator.pushNamed(context, menuPage);
                        }
                      }
                    },
                    child: Container(
                      width: 320.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                          color: _updateFormCompletion()
                              ? const Color(0xFF4477B1)
                              : const Color(0xFF4477B1).withOpacity(0.5),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.r))),
                      child: Center(
                        child: Text(
                          'Complete',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
