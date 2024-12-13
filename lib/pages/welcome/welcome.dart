import 'package:appstore/common/values/colors.dart';
import 'package:appstore/common/values/constant.dart';
import 'package:appstore/pages/welcome/bloc/welcome_bloc.dart';
import 'package:appstore/pages/welcome/bloc/welcome_event.dart';
import 'package:appstore/pages/welcome/bloc/welcome_states.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../global.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WelcomeBloc, WelcomeState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(top: 34.h),
            width: 375.w,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    state.page = index;
                    BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                  },
                  children: [
                    _page(
                        1,
                        context,
                        "ถัดไป",
                        "ดูการเรียนรู้ก่อน",
                        "ลืมการเรียนแบบกระดาษความรู้และมาเรียนทั้งหมดในการเรียนรู้เดียว!",
                        "assets/images/reading.png"),
                    _page(
                        2,
                        context,
                        "ถัดไป",
                        "เชื่อมต่อกับทุกคน",
                        "ติดต่อกับครูสอนพิเศษและเพื่อนของคุณอยู่เสมอ มาสร้างความสัมพันธ์กัน!",
                        "assets/images/boy.png"),
                    _page(
                        3,
                        context,
                        "เริ่มต้นการเรียนรู้",
                        "การเรียนรู้ที่น่าตื่นตาตื่นใจเสมอ",
                        "ทุกที่ทุกเวลา เวลาขึ้นอยู่กับดุลยพินิจของคุณ ดังนั้นเรียนได้ทุกที่ที่คุณต้องการ",
                        "assets/images/man.png"),
                  ],
                ),
                Positioned(
                    bottom: 80.h,
                    child: DotsIndicator(
                      position: state.page
                          .toDouble()
                          .round(), // Convert double to int and round
                      dotsCount: 3,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                        color: AppColors.primaryThirdElementText,
                        activeColor: AppColors.primaryElement,
                        size: const Size.square(8.0),
                        activeSize: const Size(18.0, 8.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String subTitle, String imagePath) {
    return Column(
      children: [
        SizedBox(
          width: 345.w,
          height: 345.w,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          title,
          style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 24.sp,
              fontWeight: FontWeight.normal),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 45.w, right: 30.w),
          child: Text(
            subTitle,
            style: TextStyle(
                color: AppColors.primarySecondaryElementText,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        GestureDetector(
          onTap: () {
            //ภายในดัชนี 0-2
            if (index < 3) {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            } else {
              print('-1');
              //ให้ไปหน้าใหม่
              Global.storageService
                  .setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
              print('0');
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/sign_in", (route) => false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 80.h, left: 25.w, right: 25.w),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.all(Radius.circular(15.w)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1))
                ]),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
