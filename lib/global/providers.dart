import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:twg/core/view_models/implements/auth_viewmodel.dart';
import 'package:twg/core/view_models/implements/booking_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/iauth_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ibooking_viewmodel.dart';

List<SingleChildWidget> viewModelProviders = [
  ChangeNotifierProvider<IAuthViewModel>(
    create: (_) => AuthViewModel(),
  ),
  ChangeNotifierProvider<IBookingViewModel>(
    create: (_) => BookingViewModel(),
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
