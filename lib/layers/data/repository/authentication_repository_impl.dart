import 'package:commons/commons.dart';
import 'package:either_dart/either.dart';
import 'package:finplus/core/extensions/extensions.dart';
import 'package:finplus/core/typedef/typedef.dart';
import 'package:finplus/layers/data/raw/doctor_data.dart';
import 'package:finplus/layers/data/raw/patient_data.dart';
import 'package:finplus/layers/data/raw/user_data.dart';
import 'package:finplus/layers/data/requests/login_request.dart';
import 'package:finplus/layers/data/source/api/api_client.dart';
import 'package:finplus/layers/domain/entities/user_model.dart';
import 'package:finplus/utils/app_logger.dart';
import 'package:finplus/utils/types.dart';

import '../../../core/exceptions/api_exception.dart';
import '../../domain/repository/authentication_repository.dart';

class TestException implements Exception {
  final String message;

  TestException(this.message);
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final ApiClient _client = ApiClientImpl();
  @override
  Future<ApiResponseData<UserModel?>> login(
      String username, String password) async {
    try {
      final res = await _client.login(LoginRequest(username, password));

      final loginInfo = res.getBody(UserData.fromJson);

      final userInfo = loginInfo?.toUserModel();

      if (userInfo != null) {
        if (userInfo.isDoctor) {
          final doctorInfo = await _client.getDoctorInfo(userInfo.id);

          userInfo.doctorInfo = doctorInfo.getBody(DoctorData.fromJson);
        } else {
          final patientInfo = await _client.getPatientInfo(userInfo.id);

          userInfo.patientInfo = patientInfo.getBody(PatientData.fromJson);
        }
      } else {
        throw TestException('khong co user info');
      }


      Storage.put(KEY.LOGIN_DATA, userInfo);

      return Right(userInfo);
    } on TestException catch (e) {
      logE(e);
      return Left(ApiException(message: e.message));
    }
  }
}
