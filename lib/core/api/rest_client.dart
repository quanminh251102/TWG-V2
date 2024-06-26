import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/create_apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';
import 'package:twg/core/dtos/auth/access_token_dto.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/auth/google_token_dto.dart';
import 'package:twg/core/dtos/auth/login_dto.dart';
import 'package:twg/core/dtos/base_api_dto.dart';
import 'package:twg/core/dtos/booking/booking_dto.dart';
import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/core/dtos/chat_room/create_chat_room_dto.dart';
import 'package:twg/core/dtos/location/location_dto.dart';
import 'package:twg/core/dtos/message/message_dto.dart';
import 'package:twg/core/dtos/message/send_message_dto.dart';
import 'package:twg/core/dtos/notification/notification_dto.dart';
import 'package:twg/core/dtos/review/create_review_dto.dart';
import 'package:twg/core/dtos/review/review_dto.dart';

import '../dtos/auth/register_dto.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// login
  @POST("/api/auth/login")
  Future<BaseApiDto<AccessTokenDto>> getToken(
    @Body() LoginDto model,
  );

  @POST("/api/auth/login")
  Future<BaseApiDto<GoogleTokenDto>> getTokenGoogle(
    @Body() LoginDto model,
  );

  @POST("/api/auth/register")
  Future<BaseApiDto<AccountDto>> register(
    @Body() RegisterDto model,
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
    @Query('status') int? status,
    @Query('isFavorite') bool? isFavorite,
    @Query('isMine') bool? isMine,
    @Query('authorId') String? authorId,
    @Query('keyword') String? keyword,
    @Query('bookingType') String? bookingType,
    @Query('minPrice') int? minPrice,
    @Query('maxPrice') int? maxPrice,
    @Query('startAddress') String? startAddress,
    @Query('endAddress') String? endAddress,
    @Query('startTime') String? startTime,
    @Query('endTime') String? endTime,
  });
  @GET('/api/booking/saved')
  Future<BaseApiDto<List<BookingDto>>> getSaveBookings({
    @Header('api_key') String? token,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('sortCreatedAt') int? sortCreatedAt,
    @Query('sortUpdatedAt') int? sortUpdatedAt,
    @Query('status') int? status,
    @Query('authorId') String? authorId,
    @Query('keyword') String? keyword,
    @Query('bookingType') String? bookingType,
    @Query('minPrice') int? minPrice,
    @Query('maxPrice') int? maxPrice,
    @Query('startAddress') String? startAddress,
    @Query('endAddress') String? endAddress,
    @Query('startTime') String? startTime,
    @Query('endTime') String? endTime,
  });

  @GET('/api/booking/my-list')
  Future<BaseApiDto<List<BookingDto>>> getMyBookings({
    @Header('api_key') String? token,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('sortCreatedAt') int? sortCreatedAt,
    @Query('sortUpdatedAt') int? sortUpdatedAt,
  });

  @POST("/api/booking/saved/{id}")
  Future<BaseApiDto<dynamic>> saveBooking({
    @Path("id") String? id,
    @Header('api_key') String? token,
  });

  @GET('/api/booking/recommend')
  Future<BaseApiDto<List<BookingDto>>> getRecommendBooking({
    @Header('api_key') String? token,
    @Query('type') String? type,
    @Query('startPointLat') double? startPointLat,
    @Query('startPointLong') double? startPointLong,
    @Query('endPointLat') double? endPointLat,
    @Query('endPointLong') double? endPointLong,
  });
  //chat_room
  @POST("/api/chat_room")
  Future<BaseApiDto<ChatRoomDto>> createChatRoom(
    @Header('api_key') String token,
    @Body() CreateChatRoomDto model,
  );
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

  //message
  @GET('/api/message')
  Future<BaseApiDto<List<MessageDto>>> getMessages({
    @Header('api_key') String? token,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('sortCreatedAt') int? sortCreatedAt,
    @Query('sortUpdatedAt') int? sortUpdatedAt,
    @Query('chat_room_id') String? chat_room_id,
  });
  @POST('/api/message')
  Future<BaseApiDto<MessageDto>> sendMessage({
    @Header('api_key') String? token,
    @Body() required SendMessageDto model,
  });

  // profile
  @PATCH("/api/user/profile")
  Future<BaseApiDto<AccountDto>> updateProfile(
    @Header('api_key') String token,
    @Body() AccountDto model,
  );

  // apply
  @GET('/api/apply')
  Future<BaseApiDto<List<ApplyDto>>> getApplys({
    @Header('api_key') String? token,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('sortCreatedAt') int? sortCreatedAt,
    @Query('sortUpdatedAt') int? sortUpdatedAt,
    @Query('applyerId') String? applyerId,
    @Query('bookingId') String? bookingId,
  });
  @POST("/api/apply")
  Future<BaseApiDto<AccountDto>> createApply(
    @Header('api_key') String token,
    @Body() CreateApplyDto model,
  );
  @PATCH("/api/apply/{id}")
  Future<BaseApiDto<AccountDto>> updateApply(
    @Path("id") String id,
    @Header('api_key') String token,
    @Body() UpdateApplyDto model,
  );

  //review
  @POST("/api/review")
  Future<BaseApiDto<CreateReviewDto>> createReview(
    @Header('api_key') String token,
    @Body() CreateReviewDto model,
  );

  @GET('/api/review')
  Future<BaseApiDto<List<ReviewDto>>> getReviews({
    @Header('api_key') String? token,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('sortCreatedAt') int? sortCreatedAt,
    @Query('sortUpdatedAt') int? sortUpdatedAt,
  });

  @POST("/api/location-saved")
  Future<BaseApiDto<LocationDto>> saveLocation({
    @Header('api_key') required String token,
    @Body() required LocationDto model,
  });

  @GET("/api/location-saved")
  Future<BaseApiDto<List<LocationDto>>> getLocationByUser({
    @Header('api_key') String? token,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('sortCreatedAt') int? sortCreatedAt,
    @Query('sortUpdatedAt') int? sortUpdatedAt,
  });

  @POST("/api/booking")
  Future<BaseApiDto<dynamic>> createBooking({
    @Header('api_key') required String token,
    @Body() required BookingDto model,
  });

  //notification
  @GET('/api/notification')
  Future<BaseApiDto<List<NotificationDto>>> getNotifications({
    @Header('api_key') String? token,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('sortCreatedAt') int? sortCreatedAt,
    @Query('sortUpdatedAt') int? sortUpdatedAt,
  });

  // @GET("/api/booking/getMyCompleteBooking/{id}")
  // Future<BaseApiDto<AccountDto>> getMyCompleteBooking(
  //   @Path("id") String id,
  //   @Header('api_key') String token,
  //   @Body() UpdateApplyDto model,
  // );

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
