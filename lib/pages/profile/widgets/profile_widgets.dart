import 'package:appstore/common/routes/names.dart';
import 'package:appstore/common/values/colors.dart';
import 'package:appstore/common/widgets/base_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar() {
  return AppBar(
    title: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 18.w,
            height: 12.h,
            child: Image.asset("assets/icons/menu.png"),
          ),
          reusableText("โปรไฟล์"),
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Image.asset("assets/icons/more-vertical.png"),
          ),
        ],
      ),
    ),
  );
}

//ไอคอนโปรไฟล์และปุ่มแก้ไข
Widget profileIconAndEditButton() {
  return Container(
    alignment: Alignment.bottomRight,
    padding: EdgeInsets.only(right: 1.w),
    width: 80.w,
    height: 80.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        image: const DecorationImage(
            image: AssetImage('assets/icons/headpic.png'))),
    child: Image(
      width: 35.w,
      height: 35.w,
      image: const AssetImage("assets/icons/edit_3.png"),
    ),
  );
}

//setting sections buttons
var imagesInfo = <String, String>{
  "การตั้งค่า": "settings.png",
  "รายละเอียดการจ่ายเงิน": "credit-card.png",
  "ความสำเร็จ": "award.png",
  "ชอบ": "heart(1).png",
  "การแจ้งเตือน": "cube.png",
};

Widget buildListView(BuildContext context) {
  return Column(
    children: [
      ...List.generate(
        imagesInfo.length,
        (index) => GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.SETTINGS),
          child: Container(
            margin: EdgeInsets.only(bottom: 15.h),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: AppColors.primaryElement),
                  child: Image.asset(
                      "assets/icons/${imagesInfo.values.elementAt(index)}"),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  imagesInfo.keys.elementAt(index),
                  style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}
