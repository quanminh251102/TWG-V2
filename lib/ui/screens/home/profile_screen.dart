import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/utils/enum.dart';
import 'package:twg/core/view_models/interfaces/iprofile_viewmodel.dart';
import 'package:twg/ui/common_widgets/custom_booking_floating_button.dart';
import 'package:twg/ui/common_widgets/custom_bottom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late IProfileViewModel _iProfileViewModel;

  @override
  void initState() {
    _iProfileViewModel = context.read<IProfileViewModel>();
    Future.delayed(Duration.zero, () async {
      await _iProfileViewModel.getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: CustomHomeAppBar(),
        floatingActionButton: const CustomFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomNavigationBar(
          value: CustomNavigationBar.account,
        ),
        body: Column(
          children: [
            // Text('Email : ${locator<GlobalData>().currentUser?.email}'),
            // Text('${locator<GlobalData>().currentUser?.firstName}'),
            // Text(TokenUtils.currentEmail),
            Text('profile'),
            Consumer<IProfileViewModel>(
              builder: (context, vm, child) {
                return Column(
                  children: [
                    Text(
                      vm.accountDto.avatarUrl.toString(),
                    ),
                    Text(
                      vm.accountDto.firstName.toString(),
                    ),
                    Text(
                      vm.accountDto.email.toString(),
                    ),
                  ],
                );
              },
            ),
          ],
        ));
  }
}
