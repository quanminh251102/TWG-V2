import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:twg/core/dtos/auth/access_token_dto.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/auth/login_dto.dart';
import 'package:twg/core/dtos/base_api_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/core/dtos/pagination/pagination_dto.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// login
  @POST("/api/auth/login")
  Future<BaseApiDto<AccessTokenDto>> getToken(
    @Body() LoginDto model,
  );
  @GET("/api/user/profile")
  Future<BaseApiDto<AccountDto>> getProfile({
    @Header('api_key') required String token,
  });

  //booking
  @GET('/api/booking')
  Future<BaseApiDto<List<BookingDto>>> getBookings({
    @Header('api_key') String? token,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('sortCreatedAt') int? sortCreatedAt,
    @Query('sortUpdatedAt') int? sortUpdatedAt,
    @Query('status') String? status,
    @Query('authorId') String? authorId,
  });

  //booking
  @GET('/api/chat_room')
  Future<BaseApiDto<List<ChatRoomDto>>> getChatRooms({
    @Header('api_key') String? token,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('sortCreatedAt') int? sortCreatedAt,
    @Query('sortUpdatedAt') int? sortUpdatedAt,
    @Query('userId1') String? userId1,
    @Query('userId2') String? userId2,
  });

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
