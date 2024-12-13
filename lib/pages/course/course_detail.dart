import 'package:appstore/common/values/colors.dart';
import 'package:appstore/common/widgets/base_text_widget.dart';
import 'package:appstore/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:appstore/pages/course/course_detail/bloc/course_detail_states.dart';
import 'package:appstore/pages/course/course_detail/course_detail_controller.dart';
import 'package:appstore/pages/course/course_detail/widgets/course_detail_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  late CourseDetailController _courseDetailController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _courseDetailController = CourseDetailController(context: context);
    _courseDetailController.init();
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    print("-----------my build method ---------");
    return BlocBuilder<CourseDetailBloc, CourseDetailStates>(
        builder: (context, state) {
      return state.courseItem == null
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            )
          : Container(
              color: Colors.white,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: buildAppBar("Course detail"),
                  body: SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            thumbNail(state.courseItem!.thumbnail.toString()),
                            SizedBox(
                              height: 15.h,
                            ),
                            menuView(),
                            SizedBox(
                              height: 15.h,
                            ),
                            reusableText("คำอธิบายหลักสูตร"),
                            SizedBox(
                              height: 15.w,
                            ),
                            decriptionText(
                                state.courseItem!.description.toString()),
                            SizedBox(
                              height: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                _courseDetailController
                                    .goBuy(state.courseItem!.id);
                              },
                              child: goBuyButton(" ไปยังหน้าซื้อ "),
                            ),
                            SizedBox(
                              height: 15.w,
                            ),
                            courseSummaryTitle(),
                            courseSummaryView(context, state),
                            SizedBox(
                              height: 15.h,
                            ),
                            reusableText("รายการบทเรียน"),
                            SizedBox(
                              height: 15.h,
                            ),
                            courseLessonList(state),
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              ));
    });
  }
}
