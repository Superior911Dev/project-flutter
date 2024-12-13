import 'package:appstore/common/entities/base.dart';
import 'package:appstore/common/entities/course.dart';
import 'package:appstore/common/utils/http_util.dart';

class CourseAPI {
  static Future<CourseListResponseEntity> courseList() async {
    var response = await HttpUtil().post('api/courseList');
    print(response.toString());
    return CourseListResponseEntity.fromJson(response);
  }

  static Future<CourseDetailResponseEntity> courseDetail(
      {CourseRequestEntity? params}) async {
    var response = await HttpUtil()
        .post('api/courseDetail', queryParameters: params?.toJson());
    //print(response.toString());
    return CourseDetailResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> coursePay(
      {CourseRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/checkout',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }
}
