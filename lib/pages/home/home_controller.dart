import 'package:appstore/common/apis/course_api.dart';
import 'package:appstore/common/entities/user.dart';
import 'package:appstore/global.dart';
import 'package:appstore/pages/home/bloc/home_page_blocs.dart';
import 'package:appstore/pages/home/bloc/home_page_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeController {
  late BuildContext context;
  UserItem? get userProfile => Global.storageService.getUserProfile();
  static final HomeController _singleton = HomeController._external();

  HomeController._external();

  factory HomeController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }

  Future<void> init() async {
    if (Global.storageService.getUserToken().isNotEmpty) {
      var result = await CourseAPI.courseList();
      if (result.code == 200) {
        if (context.mounted) {
          context.read<HomePageBlocs>().add(HomePageCourseItem(result.data!));
          return;
        }
      } else {
        print(result.code);
        return;
      }
    } else {
      print("User logged out");
    }
    return;
  }
}
