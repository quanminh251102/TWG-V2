import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:twg/core/dtos/auth/access_token_dto.dart';
import 'package:twg/core/dtos/auth/login_dto.dart';
import 'package:twg/core/dtos/base_api_dto.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// login
  @POST("/api/auth/login")
  Future<BaseApiDto<AccessTokenDto>> getToken(
    @Body() LoginDto model,
  );

  ///account
  // @GET("/api/account/profile")
  // Future<BaseApiDto<AccountDto>> getProfile({
  //   @Header('Authorization') required String token,
  // });

  // @PUT("/api/account/profile")
  // Future<BaseApiDto<AccountDto>> updateProfile({
  //   @Header('Authorization') required String token,
  //   @Body() required AccountUpdateDto model,
  // });

  // @DELETE("/api/chat/conversations/{id}/messages/{messageTd}")
  // Future<BaseApiDto<dynamic>> deleteMessage({
  //   @Header('Authorization') required String token,
  //   @Path("id") required int id,
  //   @Path("messageId") required int messageId,
  // });

  // @PATCH("/api/chat/conversations/{id}/messages/{messageId}/pin")
  // Future<BaseApiDto<dynamic>> pinMessage({
  //   @Header('Authorization') required String token,
  //   @Path("id") required String conversationId,
  //   @Path("messageId") required String messageId,
  // });
}
