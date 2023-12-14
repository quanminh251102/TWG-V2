import 'package:twg/core/dtos/notification/notification_dto.dart';

abstract class INotificationService {
  Future<List<NotificationDto>?> getNotifications({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
  });
  int get total;
}
