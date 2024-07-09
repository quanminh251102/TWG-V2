part of '../account_screen.dart';

class _Header extends StatefulWidget {
  const _Header();

  @override
  State<_Header> createState() => __HeaderState();
}

class __HeaderState extends State<_Header> {
  final bool _isLoadingForUpdateProfilePage = false;
  bool _isLoadingImage = false;
  late IProfileViewModel _iProfileViewModel;
  @override
  void initState() {
    _iProfileViewModel = context.read<IProfileViewModel>();
    super.initState();
  }

  void uploadImage(XFile file) async {
    setState(() {
      _isLoadingImage = true;
    });

    var result = await _iProfileViewModel.uploadFile(file);

    if (result != 'error') {
      AccountDto value = _iProfileViewModel.accountDto;

      value.avatarUrl = result;
      //  this._birthday.toString(),
      await _iProfileViewModel.updateProfile(value);

      await EasyLoading.showSuccess('Cập nhật avatar thành công');
    }

    setState(() {
      _isLoadingImage = false;
    });
  }

  void openMediaDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Chọn nguồn',
              style: TextStyle(fontSize: 14),
            ),
            content: Container(
              margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.camera);
                      if (image != null) {
                        print("get successfully");
                        uploadImage(image);
                        Future.delayed(Duration.zero, () {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        Text('Máy ảnh')
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        uploadImage(image);
                        Future.delayed(Duration.zero, () {
                          Navigator.pop(context);
                        });
                        // image.path
                      }
                    },
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.image,
                          size: 30,
                        ),
                        Text('Thư viện')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IProfileViewModel>(
      builder: (context, vm, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: ColorUtils.primaryColor,
              borderRadius: BorderRadius.circular(
                20.r,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        openMediaDialog();
                      },
                      child: CachedNetworkImage(
                        imageUrl: vm.accountDto.avatarUrl.toString(),
                        imageBuilder: (context, imageProvider) => Container(
                          width: 80.r,
                          height: 80.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(60
                                    .r) //                 <--- border radius here
                                ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => SizedBox(
                          width: 50.w,
                          height: 50.w,
                          child: lottie.Lottie.asset(
                            "assets/lottie/loading_image.json",
                            repeat: true,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vm.accountDto.firstName ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      vm.accountDto.phoneNumber ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
