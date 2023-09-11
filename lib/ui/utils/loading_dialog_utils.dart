import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

// import '../../translation/strings.dart';

class LoadingDialogUtils {
  static SimpleFontelicoProgressDialog? _progressDialog;

  /// show loading and return the dialog
  static void showLoading({
    String message = '',
  }) {
    if (_progressDialog != null) return;
    _progressDialog = SimpleFontelicoProgressDialog(
        context: Get.overlayContext!, barrierDimisable: false);
    _progressDialog!.show(
      message: "",
      horizontal: true,
      width: 100,
      height: 75.0,
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  static void hideLoading() {
    try {
      _progressDialog!.hide();
      _progressDialog = null;
    } catch (e) {}
  }
}
