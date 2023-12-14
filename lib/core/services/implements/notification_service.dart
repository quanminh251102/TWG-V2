import 'package:twg/core/dtos/notification/notification_dto.dart';
import 'package:twg/core/services/interfaces/inotification_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/locator.dart';

class NotificationService implements INotificationService {
  int _total = 0;
  @override
  int get total => _total;
  @override
  Future<List<NotificationDto>?> getNotifications({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
    String? chatRoomId,
  }) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().getNotifications(
        token: token,
        page: page,
        pageSize: pageSize,
        sortCreatedAt: -1,
      );

      if (result.success) {
        _total = result.total ?? 0;
        return result.data;
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
