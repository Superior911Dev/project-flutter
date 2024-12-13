import 'package:appstore/global.dart';
import 'package:appstore/common/routes/names.dart';
import 'package:appstore/pages/Sign_in/bloc/sign_in_bloc.dart';
import 'package:appstore/pages/Sign_in/sign_in.dart';
import 'package:appstore/pages/application/application_page.dart';
import 'package:appstore/pages/application/bloc/app_blocs.dart';
import 'package:appstore/pages/course/course_detail.dart';
import 'package:appstore/pages/course/course_detail/bloc/course_detail_blocs.dart';
import 'package:appstore/pages/course/lesson/bloc/lesson_blocs.dart';
import 'package:appstore/pages/course/lesson/lesson_detail.dart';
import 'package:appstore/pages/course/paywebview/bloc/payview_blocs.dart';
import 'package:appstore/pages/course/paywebview/paywebview.dart';
import 'package:appstore/pages/home/bloc/home_page_blocs.dart';
import 'package:appstore/pages/home/home_page.dart';
import 'package:appstore/pages/profile/settings/bloc/setting_blocs.dart';
import 'package:appstore/pages/profile/settings/settings_page.dart';
import 'package:appstore/pages/register/bloc/register_blocs.dart';
import 'package:appstore/pages/register/register.dart';
import 'package:appstore/pages/welcome/bloc/welcome_bloc.dart';
import 'package:appstore/pages/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
          route: AppRoutes.INITIAL,
          page: const Welcome(),
          bloc: BlocProvider(
            create: (_) => WelcomeBloc(),
          )),
      PageEntity(
          route: AppRoutes.SING_IN,
          page: const SignIn(),
          bloc: BlocProvider(
            create: (_) => SignInBloc(),
          )),
      PageEntity(
          route: AppRoutes.REGISTER,
          page: const Register(),
          bloc: BlocProvider(
            create: (_) => RegisterBlocs(),
          )),
      PageEntity(
          route: AppRoutes.APPLICATION,
          page: const ApplicationPage(),
          bloc: BlocProvider(
            create: (_) => AppBlocs(),
          )),
      PageEntity(
          route: AppRoutes.HOME_PAGE,
          page: const HomePage(),
          bloc: BlocProvider(
            create: (_) => HomePageBlocs(),
          )),
      PageEntity(
          route: AppRoutes.SETTINGS,
          page: const SettingsPage(),
          bloc: BlocProvider(
            create: (_) => SettingsBlocs(),
          )),
      PageEntity(
          route: AppRoutes.COURSE_DETAIL,
          page: const CourseDetail(),
          bloc: BlocProvider(
            create: (_) => CourseDetailBloc(),
          )),
      PageEntity(
          route: AppRoutes.LESSON_DETAIL,
          page: const LessonDetail(),
          bloc: BlocProvider(
            create: (_) => LessonBlocs(),
          )),
      PageEntity(
          route: AppRoutes.PAY_WEB_VIEW,
          page: const PayWebView(),
          bloc: BlocProvider(
            create: (_) => PayWebViewBlocs(),
          )),
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if (result.first.route == AppRoutes.INITIAL && deviceFirstOpen) {
          bool isLoggedin = Global.storageService.getIsLoggedIn();
          if (isLoggedin) {
            return MaterialPageRoute(
                builder: (_) => const ApplicationPage(), settings: settings);
          }

          return MaterialPageRoute(
              builder: (_) => const SignIn(), settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    print("invalid route name ${settings.name}");
    return MaterialPageRoute(
        builder: (_) => const SignIn(), settings: settings);
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, required this.bloc});
}
