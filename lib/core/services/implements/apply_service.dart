import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/create_apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';
import 'package:twg/core/services/interfaces/iapply_service.dart';
import 'package:twg/core/utils/token_utils.dart';
import 'package:twg/global/locator.dart';
import 'package:twg/ui/utils/loading_dialog_utils.dart';

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
  Future<String> createApply(
    CreateApplyDto? value,
  ) async {
    String? token = await TokenUtils.getToken();
    LoadingDialogUtils.showLoading();
    var resText = '';
    try {
      print(value!.toJson());
      var result = await getRestClient().createApply(
        token.toString(),
        value,
      );
      print(result.message);
      if (result.success) {
        resText = 'Thành công';
      } else {
        resText = 'Thất bại';
      }
    } on Exception catch (e) {
      resText = 'Thất bại';
      print(e);
    }

    LoadingDialogUtils.hideLoading();
    return resText;
  }

  @override
  Future<String> updateApply(
    String? id,
    UpdateApplyDto? value,
  ) async {
    String? token = await TokenUtils.getToken();
    var resText = '';
    try {
      var result = await getRestClient().updateApply(
        id.toString(),
        token.toString(),
        value as UpdateApplyDto,
      );
      if (result.success) {
        resText = 'Thành công';
      } else {
        resText = 'Thất bại';
      }
    } on Exception catch (e) {
      resText = 'Thất bại';
      print(e);
    }
    return resText;
  }
}
