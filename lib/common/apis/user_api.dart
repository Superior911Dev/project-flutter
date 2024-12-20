import 'package:appstore/common/entities/entities.dart';
import 'package:appstore/common/utils/http_util.dart';

class UserApi {
  static login({LoginRequestEntity? params}) async {
    var response =
        await HttpUtil().post('api/login', queryParameters: params?.toJson());

    return UserLoginResponseEntity.fromJson(response);
  }
}
