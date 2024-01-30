import 'package:dio/dio.dart';
import 'package:finplus/base/app_config/app_config.dart';
import 'package:finplus/core/response/base_response.dart';
import 'package:retrofit/retrofit.dart' hide Headers;

import '../../requests/login_request.dart';
import '../../requests/send_message_request.dart';
import 'interceptor.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST('/api/v1/login')
  Future<BaseResponse> login(@Body() LoginRequest params);

  @GET('/api/v1/doctors')
  Future<BaseResponse> getDoctorInfo(@Query('userId') int userId);

  @GET('/api/v1/patients')
  Future<BaseResponse> getPatientInfo(@Query('userId') int userId);

  @GET('/api/v1/chatRoomDoctor')
  Future<BaseResponse> getDoctorRooms(@Query('doctorId') int doctorId);

  @GET('/api/v1/chatRoom')
  Future<BaseResponse> getPatientRooms(@Query('patientId') int patientId);

  @POST('/api/v1/chatRoom')
  Future<BaseResponse> createRoom(
    @Body() dynamic params,
  );

  @GET('/api/v1/chatDetail')
  Future<BaseResponse> getMessages(@Query('roomId') int roomId);

  @GET('/api/posts/by-user/{id}?ref_type=message&order=1')
  Future<BaseResponse> getMessagesFromLastMessage(
    @Path() final String id,
    @Query('time') String time,
  );

  @POST('/api/posts')
  Future<BaseResponse> sendMessage(@Body() SendMessageRequest request);
}

class ApiClientImpl implements ApiClient {
  static final ApiClientImpl _instance = ApiClientImpl._();

  late final ApiClient _client;

  late final Dio _dio;

  factory ApiClientImpl() {
    return _instance;
  }

  ApiClientImpl._() {
    _dio = Dio(BaseOptions(contentType: Headers.jsonContentType));

    _dio.interceptors.add(HeaderIntercepter(getAccessToken: () => ''));

    _client =
        ApiClient(_dio, baseUrl: Uri.https(AppConfig.info.baseUrl).toString());
  }

  @override
  Future<BaseResponse> getMessages(int roomId) => _client.getMessages(roomId);

  @override
  Future<BaseResponse> createRoom(dynamic params) => _client.createRoom(params);

  @override
  Future<BaseResponse> sendMessage(SendMessageRequest request) =>
      _client.sendMessage(request);

  @override
  Future<BaseResponse> getMessagesFromLastMessage(String id, String time) =>
      _client.getMessagesFromLastMessage(id, time);

  @override
  Future<BaseResponse> login(LoginRequest params) => _client.login(params);

  @override
  Future<BaseResponse> getDoctorInfo(int userId) =>
      _client.getDoctorInfo(userId);

  @override
  Future<BaseResponse> getPatientInfo(int userId) =>
      _client.getPatientInfo(userId);

  @override
  Future<BaseResponse> getDoctorRooms(int doctorId) =>
      _client.getDoctorRooms(doctorId);

  @override
  Future<BaseResponse> getPatientRooms(int patientId) =>
      _client.getPatientRooms(patientId);
}
