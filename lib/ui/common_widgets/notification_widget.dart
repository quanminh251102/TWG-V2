import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/view_models/interfaces/inotification_viewmodal.dart';
import 'package:twg/global/router.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<INotificationViewModel>(
      builder: (context, vm, child) {
        return Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Get.offNamed(MyRouter.notification);
              },
            ),
            if (vm.numUnWatched > 0)
              Positioned(
                right: 0,
                top: -4,
                child: CustomCard(
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      vm.numUnWatched.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: Colors.red,
                  borderRadius: 12,
                ),
              ),
          ],
        );
      },
    );
  }
}
