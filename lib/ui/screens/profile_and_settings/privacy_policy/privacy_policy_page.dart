import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:twg/global/router.dart';

const privacy_policy_texts = [
  {
    "title": "Thu thập thông tin",
    "content":
        "Chính sách riêng tư cho ứng dụng di động cần xác định rõ ràng thông tin nào được thu thập từ người dùng, bao gồm cả thông tin cá nhân và phi cá nhân. Chính sách này nên cung cấp thông tin về cách thức thu thập thông tin, mục đích thu thập thông tin và các bên sẽ có quyền truy cập vào thông tin này.",
  },
  {
    "title": "Bảo mật thông tin",
    "content":
        "Chính sách riêng tư cho ứng dụng di động cần nêu rõ về việc chia sẻ thông tin người dùng với các bên thứ ba. Nếu thông tin được chia sẻ, chính sách này cần cung cấp thông tin về loại thông tin được chia sẻ và mục đích chia sẻ thông tin đó. Nếu có thể, chính sách này cần yêu cầu sự đồng ý của người dùng trước khi chia sẻ thông tin của họ.",
  },
  {
    "title": "Bảo mật thông tin",
    "content":
        "Chính sách riêng tư cho ứng dụng di động cần nêu rõ về việc chia sẻ thông tin người dùng với các bên thứ ba. Nếu thông tin được chia sẻ, chính sách này cần cung cấp thông tin về loại thông tin được chia sẻ và mục đích chia sẻ thông tin đó. Nếu có thể, chính sách này cần yêu cầu sự đồng ý của người dùng trước khi chia sẻ thông tin của họ.",
  },
  {
    "title": "Truy cập thông tin",
    "content":
        "Chính sách riêng tư cho ứng dụng di động cần xác định ai có quyền truy cập vào thông tin người dùng và mục đích của việc truy cập. Chính sách này nên yêu cầu các bên sử dụng thông tin người dùng đảm bảo rằng thông tin đó được bảo mật và không được sử dụng một cách sai trái.",
  },
  {
    "title": "Xóa thông tin",
    "content":
        "Chính sách riêng tư cho ứng dụng di động cần cung cấp cho người dùng quyền yêu cầu xóa thông tin của họ khỏi hệ thống. Chính sách này cần nêu rõ cách thức người dùng có thể yêu cầu xóa thông tin của họ và thời gian phản hồi của hệ thống.",
  },
];

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  List<String> title = [];
  Column content = const Column();

  onePart(oneContent, index) => [
        Text(
          '${index + 1}. ${oneContent["title"]}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 24),
        Text(
          oneContent["content"],
          style: const TextStyle(fontSize: 15),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 24)
      ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < privacy_policy_texts.length; i++)
          ...onePart(privacy_policy_texts[i], i)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chính sách quyền riêng tư',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: content,
        ),
      ),
    );
  }
}
