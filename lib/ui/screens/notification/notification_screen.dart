import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/view_models/interfaces/inotification_viewmodal.dart';
import 'package:twg/ui/screens/notification/widget/list_notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late INotificationViewModel _iNotificationViewModel;

  @override
  void initState() {
    _iNotificationViewModel = context.read<INotificationViewModel>();

    Future.delayed(Duration.zero, () async {
      await _iNotificationViewModel.init('');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Thông báo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<INotificationViewModel>(
                builder: (context, vm, child) {
                  return ListNotification(
                    notifications: vm.notifications,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
