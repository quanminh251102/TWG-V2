import 'package:twg/core/dtos/apply/apply_dto.dart';
import 'package:twg/core/dtos/apply/create_apply_dto.dart';
import 'package:twg/core/dtos/apply/update_apply_dto.dart';

abstract class IApplyService {
  Future<List<ApplyDto>?> getApplys({
    String? token,
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
    String? applyerId,
    String? bookingId,
  });
  int get total;
  Future<String> createApply(CreateApplyDto value);
  Future<String> updateApply(String id, UpdateApplyDto value);
}
