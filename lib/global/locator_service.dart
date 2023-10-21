import 'package:get_it/get_it.dart';
import 'package:twg/core/services/implements/auth_service.dart';
import 'package:twg/core/services/implements/booking_service.dart';
import 'package:twg/core/services/implements/chat_room_service.dart';
import 'package:twg/core/services/implements/message_service.dart';
import 'package:twg/core/services/implements/socket_service.dart';

import 'package:twg/core/services/interfaces/iauth_service.dart';
import 'package:twg/core/services/interfaces/ibooking_service.dart';
import 'package:twg/core/services/interfaces/ichat_room_service.dart';
import 'package:twg/core/services/interfaces/imessage_service.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';

void registerServiceSingletons(GetIt locator) {
  locator.registerLazySingleton<IAuthService>(() => AuthService());
  locator.registerLazySingleton<IBookingService>(() => BookingService());
  locator.registerLazySingleton<IChatRoomService>(() => ChatRoomService());
  locator.registerLazySingleton<IMessageService>(() => MessageService());
  locator.registerLazySingleton<ISocketService>(() => SocketService());
  // locator.registerLazySingleton<ICategoryService>(() => CategoryService());
  // locator
  //     .registerLazySingleton<IManufactureService>(() => ManufactureService());
  // locator.registerLazySingleton<IProductClassificationService>(
  //     () => ProductClassificationService());
  // locator.registerLazySingleton<ICustomerManagementService>(
  //     () => CustomerManagementService());
  // locator.registerLazySingleton<ISalesPlanService>(() => SalesPlanService());
  // locator
  //     .registerLazySingleton<ISalesResultService>(() => SalesResultService());
  // locator.registerLazySingleton<IAreaService>(() => AreaService());
  // locator.registerLazySingleton<INotifyService>(() => NotifyService());
  // locator.registerLazySingleton<IShipmentService>(() => ShipmentService());
  // locator.registerLazySingleton<IReviewService>(() => ReviewService());
  // locator.registerLazySingleton<ILocationService>(() => LocationService());
  // locator.registerLazySingleton<IBannerService>(() => BannerService());
  // locator.registerLazySingleton<IPromotionService>(() => PromotionService());
  // locator.registerLazySingleton<IContractService>(() => ContractService());
  // locator.registerLazySingleton<IChannelService>(() => ChannelService());
}
