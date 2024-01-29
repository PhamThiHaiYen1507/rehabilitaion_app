import 'package:finplus/core/typedef/typedef.dart';

import '../entities/user_model.dart';

abstract class AuthenticationRepository {
  Future<ApiResponseData<UserModel?>> login(String username, String password);
}
