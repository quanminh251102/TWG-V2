// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_custom_cards/flutter_custom_cards.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// import '../../../../utils/constants/colors.dart';
// import '../../../cubits/app_user.dart';
// import '../../../services/review.dart';

// class MyReViewsPage extends StatefulWidget {
//   const MyReViewsPage({super.key});

//   @override
//   State<MyReViewsPage> createState() => _MyReViewsPageState();
// }

// class _MyReViewsPageState extends State<MyReViewsPage> {
//   bool isLoading = false;
//   List<dynamic> reviews = [];
//   List<dynamic> reviews_selected = [];
//   TextEditingController _name = TextEditingController();
//   late FocusNode nameFocus;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     nameFocus = FocusNode();

//     init();
//   }

//   void init() async {
//     setState(() {
//       isLoading = true;
//     });

//     String result = "pass";

//     try {
//       reviews = await ReviewService.getReviewWithUserId(appUser.id);
//       reviews_selected = reviews;
//     } catch (e) {
//       result = "error";
//     }

//     if (result == "error") {
//       const snackBar = SnackBar(
//         content: Text('Bị lổi'),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     } else {
//       const snackBar = SnackBar(
//         content: Text('Thành công'),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }

//   void do_filter() {
//     setState(() {
//       print("do filter");
//       print(_name.text.trim().toLowerCase());
//       reviews_selected = reviews.where((review) {
//         String name = review["creater"]["first_name"].toString().toLowerCase();
//         String search_name = _name.text.trim().toLowerCase();

//         if (name.contains(search_name)) {
//           return true;
//         }
//         return false;
//       }).toList();
//       print(reviews_selected);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     search_bar() {
//       return [
//         Text('Search theo tên : '),
//         TextFormField(
//           style: const TextStyle(fontWeight: FontWeight.w600),
//           focusNode: nameFocus,
//           controller: _name,
//           validator: (value) {
//             return null;
//           },
//           decoration: InputDecoration(
//             filled: true, //<-- SEE HERE
//             fillColor: nameFocus.hasFocus
//                 ? AppColors.primaryColor.withOpacity(0.1)
//                 : Colors.grey.withOpacity(0.1),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: AppColors.primaryColor),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: Colors.grey.withOpacity(0.1),
//                 width: 2.0,
//               ),
//             ),
//             hintText: 'Tìm kiếm',
//             // prefixIcon: Icon(
//             //   Icons.email_outlined,
//             //   color: nameFocus.hasFocus ? AppColors.primaryColor : Colors.black,
//             // ),
//           ),
//           onChanged: (text) {
//             do_filter();
//           },
//         ),
//       ];
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Đánh giá đến tôi'),
//         centerTitle: true,
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ...search_bar(),
//                     const SizedBox(height: 20),
//                     if (reviews_selected.length == 0)
//                       const Text('Danh sách rỗng'),
//                     if (reviews_selected.length > 0)
//                       for (var review in reviews_selected) ...[
//                         CustomCard(
//                           childPadding: 12,
//                           width: double.infinity,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 30.0,
//                                     backgroundImage: NetworkImage(
//                                         review["creater"]["avatarUrl"]),
//                                     backgroundColor: Colors.transparent,
//                                   ),
//                                   const SizedBox(width: 20),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       RatingBar.builder(
//                                         initialRating:
//                                             review["review_star"].toDouble(),
//                                         minRating: 1,
//                                         direction: Axis.horizontal,
//                                         allowHalfRating: true,
//                                         itemCount: 5,
//                                         itemPadding: EdgeInsets.symmetric(
//                                             horizontal: 4.0),
//                                         itemBuilder: (context, _) => Icon(
//                                           Icons.star,
//                                           color: Colors.amber,
//                                         ),
//                                         onRatingUpdate: (rating) {
//                                           print(rating);
//                                         },
//                                       ),
//                                       Text('02/06/2023'),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 '${review["creater"]["first_name"]}',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                               const SizedBox(height: 10),
//                               Text('${review["review_note"]}')
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                       ],
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
