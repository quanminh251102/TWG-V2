// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// import '../../../../utils/constants/privacy_policy_text.dart';

// class PrivacyPolicyPage extends StatefulWidget {
//   const PrivacyPolicyPage({super.key});

//   @override
//   State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
// }

// class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
//   List<String> title = [];
//   Column content = Column();

//   onePart(oneContent, index) => [
//         Text(
//           '${index + 1}. ${oneContent["title"]}',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//         ),
//         SizedBox(height: 24),
//         Text(
//           oneContent["content"],
//           style: TextStyle(fontSize: 15),
//           textAlign: TextAlign.justify,
//         ),
//         SizedBox(height: 24)
//       ];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     this.content = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         for (int i = 0; i < privacy_policy_texts.length; i++)
//           ...onePart(privacy_policy_texts[i], i)
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chính sách quyên riêng tư'),
//         centerTitle: false,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
//           child: this.content,
//         ),
//       ),
//     );
//   }
// }
