import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/create_apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';
import 'package:twg/core/dtos/message/message_dto.dart';
import 'package:twg/core/dtos/message/send_message_dto.dart';
import 'package:twg/core/services/interfaces/iapply_service.dart';
import 'package:twg/core/services/interfaces/imessage_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/locator.dart';

class ApplyService implements IApplyService {
  int _total = 0;
  @override
  int get total => _total;
  @override
  Future<List<ApplyDto>?> getApplys({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
    String? applyerId,
    String? bookingId,
  }) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().getApplys(
        token: token,
        page: page,
        pageSize: pageSize,
        applyerId: applyerId,
        bookingId: bookingId,
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

  @override
  Future<void> createApply(
    CreateApplyDto? value,
  ) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().createApply(
        token.toString(),
        value as CreateApplyDto,
      );

      if (result.success) {
        return;
      }
    } on Exception catch (e) {
      print(e);
    }
    return;
  }

  @override
  Future<void> updateApply(
    String? id,
    UpdateApplyDto? value,
  ) async {
    String? token = await TokenUtils.getToken();
    try {
      var result = await getRestClient().updateApply(
        id.toString(),
        token.toString(),
        value as UpdateApplyDto,
      );

      if (result.success) {
        return;
      }
    } on Exception catch (e) {
      print(e);
    }
    return;
  }
}
