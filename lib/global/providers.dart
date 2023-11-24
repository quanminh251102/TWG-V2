import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:twg/core/view_models/implements/apply_viewmodel.dart';
import 'package:twg/core/view_models/implements/auth_viewmodel.dart';
import 'package:twg/core/view_models/implements/booking_viewmodel.dart';
import 'package:twg/core/view_models/implements/call_viewmodel.dart';
import 'package:twg/core/view_models/implements/home_viewmodel.dart';
import 'package:twg/core/view_models/implements/messasge_viewmodel.dart';
import 'package:twg/core/view_models/implements/profile_viewmodel.dart';
import 'package:twg/core/view_models/implements/splash_screen_view_model.dart';
import 'package:twg/core/view_models/implements/chat_room_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/iapply_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/iauth_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/icall_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ihome_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/iprofile_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/isplash_screen_view_model.dart';
import 'package:twg/core/view_models/interfaces/ichat_room_viewmodel.dart';

List<SingleChildWidget> viewModelProviders = [
  ChangeNotifierProvider<IAuthViewModel>(
    create: (_) => AuthViewModel(),
  ),
  ChangeNotifierProvider<IBookingViewModel>(
    create: (_) => BookingViewModel(),
  ),
  ChangeNotifierProvider<ISplashScreenViewModel>(
    create: (_) => SplashScreenViewModel(),
  ),
  ChangeNotifierProvider<IChatRoomViewModel>(
    create: (_) => ChatRoomViewModel(),
  ),
  ChangeNotifierProvider<IMessageViewModel>(
    create: (_) => MessageViewModel(),
  ),
  ChangeNotifierProvider<ICallViewModel>(
    create: (_) => CallViewModel(),
  ),
  ChangeNotifierProvider<IHomeViewModel>(
    create: (_) => HomeViewModel(),
  ),
  ChangeNotifierProvider<IProfileViewModel>(
    create: (_) => ProfileViewModel(),
  ),
  ChangeNotifierProvider<IApplyViewModel>(
    create: (_) => ApplyViewModel(),
  ),
  // ChangeNotifierProvider<INotificationViewModel>(
  //   create: (_) => NotificationViewModel(),
  // ),
  // ChangeNotifierProvider<IAuthViewModel>(
  //   create: (_) => AuthViewModel(),
  // ),
  // ChangeNotifierProvider<IDeviceViewModel>(
  //   create: (_) => DeviceViewModel(),
  // ),
  // ChangeNotifierProvider<IBasketViewModel>(
  //   create: (_) => BasketViewModel(),
  // ),
  // ChangeNotifierProvider<ITempBasketViewModel>(
  //     create: (_) => TempBasketViewModel()),
  // ChangeNotifierProvider<ICategoryViewModel>(
  //   create: (_) => CategoryViewModel(),
  // ),
  // // ChangeNotifierProvider<IPromotionViewModel>(
  // //   create: (_) => PromotionViewModel(),
  // // ),
  // ChangeNotifierProvider<ISearchingProductViewModel>(
  //   create: (_) => SearchingProductViewModel(),
  // ),
  // ChangeNotifierProvider<IProductDetailViewModel>(
  //   create: (_) => ProductDetailViewModel(),
  // ),
  // ChangeNotifierProvider<ICustomerManagementViewModel>(
  //   create: (_) => CustomerManagementViewModel(),
  // ),
  // ChangeNotifierProvider<ISalesPlanViewModel>(
  //   create: (_) => SalesPlanViewModel(),
  // ),
  // ChangeNotifierProvider<ITimeKeepingViewModel>(
  //   create: (_) => TimeKeepingViewModel(),
  // ),
  // ChangeNotifierProvider<IOrderViewModel>(
  //   create: (_) => OrderViewModel(),
  // ),
  // ChangeNotifierProvider<IAreaViewModel>(
  //   create: (_) => AreaViewModel(),
  // ),
  // ChangeNotifierProvider<ICategoryProductManagementViewModel>(
  //   create: (_) => CategoryProductManagementViewModel(),
  // ),
  // ChangeNotifierProvider<ICheckOutViewModel>(
  //   create: (_) => CheckOutViewModel(),
  // ),
  // ChangeNotifierProvider<ITempBasketViewModel>(
  //   create: (_) => TempBasketViewModel(),
  // ),
  // ChangeNotifierProvider<IPlaceViewModel>(
  //   create: (_) => PlaceViewModel(),
  // ),
  // ChangeNotifierProvider<IReviewViewModel>(
  //   create: (_) => ReviewViewModel(),
  // ),
  // ChangeNotifierProvider<ILocationViewModel>(
  //   create: (_) => LocationViewModel(),
  // ),
  // ChangeNotifierProvider<IPlaceViewModel>(
  //   create: (_) => PlaceViewModel(),
  // ),
  // ChangeNotifierProvider<IBannerViewModel>(
  //   create: (_) => BannerViewModel(),
  // ),
  // ChangeNotifierProvider<ISearchingCustomerViewModel>(
  //   create: (_) => SearchingCustomerViewModel(),
  // ),
];
