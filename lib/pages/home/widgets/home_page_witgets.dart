import 'package:appstore/common/entities/course.dart';
import 'package:appstore/common/values/colors.dart';
import 'package:appstore/common/values/constant.dart';
import 'package:appstore/common/widgets/base_text_widget.dart';
import 'package:appstore/pages/home/bloc/home_page_blocs.dart';
import 'package:appstore/pages/home/bloc/home_page_events.dart';
import 'package:appstore/pages/home/bloc/home_page_states.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar(String avatar) {
  return AppBar(
    title: Container(
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15.w,
            height: 12.h,
            child: Image.asset("assets/icons/menu.png"),
          ),
          GestureDetector(
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(avatar))),
            ),
          )
        ],
      ),
    ),
  );
}

// widget homepagetext ใช้สร้างหน้า homepage
Widget homePageText(String text,
    {Color color = AppColors.primaryText, int top = 20}) {
  return Container(
    margin: EdgeInsets.only(top: top.h),
    child: Text(
      text,
      style:
          TextStyle(color: color, fontSize: 24.sp, fontWeight: FontWeight.bold),
    ),
  );
}

Widget searchView() {
  return Row(
    children: [
      Container(
        width: 280.w,
        height: 40.h,
        decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(15.h),
            border: Border.all(color: AppColors.primaryFourthElementText)),
        child: Row(children: [
          Container(
            margin: EdgeInsets.only(left: 17.w),
            width: 16.w,
            height: 16.w,
            child: Image.asset("assets/icons/search.png"),
          ),
          Container(
            width: 240.w,
            height: 50.h,
            child: TextField(
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                hintText: 'ค้นหาหลักสูตรของคุณ',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle:
                    TextStyle(color: AppColors.primarySecondaryElementText),
              ),
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Prompt-Regular",
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp),
              autocorrect: false,
              obscureText: false,
            ),
          )
        ]),
      ),
      GestureDetector(
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppColors.primaryElement,
            borderRadius: BorderRadius.all(Radius.circular(13.w)),
            border: Border.all(color: AppColors.primaryElement),
          ),
          child: Image.asset("assets/icons/options.png"),
        ),
      )
    ],
  );
}

//for sliders
Widget slidersView(BuildContext context, HomePageStates state) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 20.h),
        width: 325.w,
        height: 160.h,
        child: PageView(
          onPageChanged: (value) {
            print(value.toString());
            context.read<HomePageBlocs>().add(HomePageDots(value));
          },
          children: [
            _slidersContainer(path: "assets/icons/Art.png"),
            _slidersContainer(path: "assets/icons/Image_1.png"),
            _slidersContainer(path: "assets/icons/Image_2.png"),
          ],
        ),
      ),
      Container(
        child: DotsIndicator(
          dotsCount: 3,
          position: state.index,
          decorator: DotsDecorator(
              color: AppColors.primaryThirdElementText,
              activeColor: AppColors.primaryElement,
              size: const Size.square(5.0),
              activeSize: const Size(17.0, 5.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
        ),
      )
    ],
  );
}

Widget _slidersContainer({String path = "assets/icons/Art.png"}) {
  return Container(
    width: 300.w,
    height: 160.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.h)),
        image: DecorationImage(fit: BoxFit.fill, image: AssetImage(path))),
  );
}

Widget menuView() {
  return Column(children: [
    Container(
        width: 325.w,
        margin: EdgeInsets.only(top: 15.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              reusableText("เลือกหลักสูตรของคุณ"),
              GestureDetector(
                  child: reusableText("ดูทั้งหมด",
                      color: AppColors.primaryThirdElementText, fontSize: 12))
            ])),
    Container(
      margin: EdgeInsets.only(top: 20.w),
      child: Row(
        children: [
          _reusableMenuText("ทั้งหมด"),
          _reusableMenuText("เป็นที่นิยม",
              textColor: AppColors.primaryThirdElementText,
              baclGroundColor: Colors.white),
          _reusableMenuText("ใหม่ล่าสุด",
              textColor: AppColors.primaryThirdElementText,
              baclGroundColor: Colors.white),
        ],
      ),
    )
  ]);
}

Widget _reusableMenuText(String menutext,
    {Color textColor = AppColors.primaryElementText,
    Color baclGroundColor = AppColors.primaryElement}) {
  return Container(
    margin: EdgeInsets.only(right: 20.w),
    decoration: BoxDecoration(
        color: baclGroundColor,
        borderRadius: BorderRadius.circular(7.w),
        border: Border.all(color: baclGroundColor)),
    padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h, bottom: 5.h),
    child: reusableText(menutext,
        color: textColor, fontWeight: FontWeight.normal, fontSize: 11),
  );
}

Widget courseGrid(CourseItem item) {
  return Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        image: DecorationImage(
            fit: BoxFit.fill,
            image:
                NetworkImage(AppConstants.SERVER_UPLOADS + item.thumbnail!))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name ?? "",
          maxLines: 1,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.left,
          softWrap: false,
          style: TextStyle(
              color: AppColors.primaryElementText,
              fontWeight: FontWeight.bold,
              fontSize: 11.sp),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          item.description ?? "",
          maxLines: 1,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.left,
          softWrap: false,
          style: TextStyle(
              color: AppColors.primaryFourthElementText,
              fontWeight: FontWeight.normal,
              fontSize: 8.sp),
        ),
      ],
    ),
  );
}
// Widget _reusableMenuText(String menuText,
//     {Color textColor = AppColors.primaryElementText,
//     Color backGroundColor = AppColors.primaryElement}) {
//   return Container(
//     margin: EdgeInsets.only(right: 20.w),
//     decoration: BoxDecoration(
//         color: backGroundColor,
//         borderRadius: BorderRadius.circular(7.w),
//         border: Border.all(color: backGroundColor)),
//     padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h, bottom: 5.h),
//     child: reusableText(menuText,
//         color: textColor, fontWeight: FontWeight.normal, fontSize: 11),
//   );
// }

// Widget menuView() {
//   return Column(
//     children: [
//       Container(
//           width: 325.w,
//           margin: EdgeInsets.only(top: 15.h),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               reusableText("Choose your course"),
//               GestureDetector(
//                   child: reusableText("See all",
//                       color: AppColors.primaryThirdElementText, fontSize: 10)),
//             ],
//           )),
//       Container(
//         margin: EdgeInsets.only(top: 20.w),
//         child: Row(
//           children: [
//             _reusableMenuText("All"),
//             _reusableMenuText("Popular",
//                 textColor: AppColors.primaryThirdElementText,
//                 backGroundColor: Colors.white),
//             _reusableMenuText("Newest",
//                 textColor: AppColors.primaryThirdElementText,
//                 backGroundColor: Colors.white),
//           ],
//         ),
//       )
//     ],
//   );
// }
