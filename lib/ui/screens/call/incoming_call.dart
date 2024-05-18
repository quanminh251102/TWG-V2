import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:twg/core/view_models/interfaces/icall_viewmodel.dart';
import 'package:twg/global/router.dart';

class InComingCallScreen extends StatefulWidget {
  const InComingCallScreen({super.key});

  @override
  State<InComingCallScreen> createState() => _InComingCallScreenState();
}

class _InComingCallScreenState extends State<InComingCallScreen> {
  late ICallViewModel _iCallViewModel;

  @override
  void initState() {
    super.initState();
    _iCallViewModel = context.read<ICallViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("TeleDoc"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: _iCallViewModel.callInfo.callerAvatar as String,
              imageBuilder: (context, imageProvider) => Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(
                          60.0) //                 <--- border radius here
                      ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            // const CircleAvatar(
            //   backgroundColor: ColorUtils.primaryColor,
            //   radius: 80,
            // ),
            const SizedBox(height: 20),
            const Text("Đang gọi đến"),
            const SizedBox(height: 20),
            Consumer<ICallViewModel>(
              builder: (context, vm, child) {
                return Text(
                  vm.callInfo.callerName as String,
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: () => _acceptCall(),
                  // label: const Text("Accept Call"),
                  heroTag: const Key('FABAcceptCall'),
                  elevation: 0,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.call_outlined),
                ),
                FloatingActionButton(
                  onPressed: () => _denyCall(),
                  // label: const Text("Deny Call"),
                  heroTag: const Key('FABDenyCall'),
                  elevation: 0,
                  backgroundColor: Colors.red[300],
                  child: const Icon(Icons.call_end_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } // build

  _acceptCall() {
    _printSpace();
    print("  <====================> Accepting call");
    _printSpace();
    _iCallViewModel.socket!.emit("accept-call", <String, dynamic>{
      "to": _iCallViewModel.callInfo.callerId,
    });

    _printSpace();
    print(
        "  <====================> Going to call page with data ${_iCallViewModel.callInfo.toJson()}");
    _printSpace();

    Get.offNamed(MyRouter.call);
  }

  _denyCall() {
    _printSpace();
    print("  <====================> Denying call");
    _printSpace();

    _iCallViewModel.socket!.emit("deny-call", <String, dynamic>{
      "to": _iCallViewModel.callInfo.callerId,
    });
  }

  _printSpace() {
    print("");
    print("");
    print("\t <==================================>");
    print("");
    print("");
  }
}
