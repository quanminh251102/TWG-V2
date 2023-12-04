import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twg/core/dtos/auth/account_dto.dart';
import 'package:twg/core/dtos/call/call_info_dto.dart';
import 'package:twg/core/dtos/chat_room/chat_room_dto.dart';
import 'package:twg/core/dtos/message/message_dto.dart';
import 'package:twg/core/dtos/message/send_message_dto.dart';
import 'package:twg/core/dtos/review/create_review_dto.dart';
import 'package:twg/core/dtos/review/review_dto.dart';
import 'package:twg/core/services/interfaces/imessage_service.dart';
import 'package:twg/core/services/interfaces/ireview_service.dart';
import 'package:twg/core/services/interfaces/isocket_service.dart';
import 'package:twg/core/view_models/interfaces/imessage_viewmodel.dart';
import 'package:twg/core/view_models/interfaces/ireview_viewmodel.dart';
import 'package:twg/global/global_data.dart';
import 'package:twg/global/locator.dart';

class ReviewViewModel with ChangeNotifier implements IReviewViewModel {
  List<ReviewDto> _reviews = [];

  List<ReviewDto> _reviewsAfterFilter = [];
  @override
  List<ReviewDto> get reviewsAfterFilter => _reviewsAfterFilter;
  int _totalCount = 0;
  bool _isLoading = false;
  int page = 1;
  String? _keyword;

  final IReviewService _iReviewService = locator<IReviewService>();

  @override
  List<ReviewDto> get reviews => _reviews;
  @override
  String? get keyword => _keyword;
  @override
  bool get isLoading => _isLoading;

  String _name = '';

  @override
  void setName(String value) {
    _name = value;
    filter();
    notifyListeners();
  }

  void _reset() {
    _keyword = null;
    page = 1;
    _reviews.clear();
  }

  void filter() {
    _reviewsAfterFilter = _reviews.where((review) {
      String name = review.creater!.firstName.toString().toLowerCase();
      String search_name = _name.toLowerCase();

      if (name.contains(search_name)) {
        return true;
      }
      return false;
    }).toList();
  }

  @override
  Future<void> init() async {
    _name = '';
    _reset();
    final paginationProducts = await _iReviewService.getReviews(
      page: 1,
      pageSize: 100,
    );
    _reviews = paginationProducts ?? [];
    _totalCount = _iReviewService.total;
    filter();
    notifyListeners();
  }

  @override
  Future<void> getMoreReviews() async {
    if (_totalCount == 0) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    final paginationMessages = await _iReviewService.getReviews(
      page: page,
      pageSize: page * 10,
    );

    _reviews.addAll(
      paginationMessages ?? [],
    );
    _totalCount = _iReviewService.total;
    page += 1;
    _isLoading = false;
    filter();
    notifyListeners();
  }

  @override
  Future<void> createReview(CreateReviewDto value) async {
    var result = await _iReviewService.createReview(value);
    if (result != 'Thất bại') {
      await EasyLoading.showSuccess(result);
    }
  }
}
