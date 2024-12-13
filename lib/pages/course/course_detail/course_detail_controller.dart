import 'package:appstore/common/apis/course_api.dart';
import 'package:appstore/common/apis/lesson_api.dart';
import 'package:appstore/common/entities/course.dart';
import 'package:appstore/common/entities/entities.dart';
import 'package:appstore/common/routes/names.dart';
import 'package:appstore/common/widgets/flutter_toast.dart';
import 'package:appstore/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:appstore/pages/course/course_detail/bloc/course_detail_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CourseDetailController {
  final BuildContext context;
  CourseDetailController({required this.context});

  void init() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadCourseData(args["id"]);
    asyncLoadLessonData(args["id"]);
  }

  asyncLoadCourseData(int? id) async {
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.courseDetail(params: courseRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context.read<CourseDetailBloc>().add(TriggerCourseDetail(result.data!));
      } else {
        print('-----------context is not available------------');
      }
    } else {
      toastInfo(msg: "Something went wrong and check the log in laravel");
    }
  }

  asyncLoadLessonData(int? id) async {
    LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
    lessonRequestEntity.id = id;
    var result = await LessonAPI.lessonList(params: lessonRequestEntity);
    if (result.code == 200) {
      if (context.mounted) {
        context.read<CourseDetailBloc>().add(TriggerLessonList(result.data!));
        print('my lesson data is ${result.data![0].thumbnail}');
      } else {
        print('-------context is not read --------');
      }
    } else {
      toastInfo(msg: "something went wrong check the log");
    }
  }

  Future<void> goBuy(int? id) async {
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    CourseRequestEntity courseRequestEntity = CourseRequestEntity();
    courseRequestEntity.id = id;
    var result = await CourseAPI.coursePay(params: courseRequestEntity);
    EasyLoading.dismiss();
    if (result.code == 200) {
      var url = Uri.decodeFull(result.data!);
      var res = await Navigator.of(context)
          .pushNamed(AppRoutes.PAY_WEB_VIEW, arguments: {"url": url});
      //print('-----my returned stripe url is $url-----');
      if (res == "success") {
        toastInfo(msg: result.msg!);
      }
    } else {
      toastInfo(msg: result.msg!);
    }
  }
}
