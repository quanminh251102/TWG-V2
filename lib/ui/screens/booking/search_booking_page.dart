// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class SearchBookingPage extends StatefulWidget {
//   const SearchBookingPage({super.key});

//   @override
//   State<SearchBookingPage> createState() => _SearchBookingPageState();
// }

// class _SearchBookingPageState extends State<SearchBookingPage> {
//   TextEditingController _startPoint = TextEditingController();
//   TextEditingController _endPoint = TextEditingController();
//   late FocusNode startPointFocus;
//   late FocusNode endPointFocus;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     startPointFocus = FocusNode();
//     endPointFocus = FocusNode();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tìm kiếm booking'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             const SizedBox(height: 12),
//             const Text('Điểm đi : '),
//             const SizedBox(height: 12),
//             TextFormField(
//               style: const TextStyle(fontWeight: FontWeight.w600),
//               focusNode: startPointFocus,
//               controller: _startPoint,
//               validator: (value) {
//                 return null;
//               },
//               decoration: InputDecoration(
//                 filled: true, //<-- SEE HERE
//                 fillColor: startPointFocus.hasFocus
//                     ? ColorUtils.primaryColor.withOpacity(0.1)
//                     : Colors.grey.withOpacity(0.1),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(color: ColorUtils.primaryColor),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(
//                     color: Colors.grey.withOpacity(0.1),
//                     width: 2.0,
//                   ),
//                 ),
//                 hintText: 'Điểm đi',
//                 prefixIcon: Icon(
//                   Icons.location_on,
//                   color: startPointFocus.hasFocus
//                       ? ColorUtils.primaryColor
//                       : Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text('Điểm đến : '),
//             const SizedBox(height: 12),
//             TextFormField(
//               style: const TextStyle(fontWeight: FontWeight.w600),
//               focusNode: endPointFocus,
//               controller: _endPoint,
//               validator: (value) {
//                 return null;
//               },
//               decoration: InputDecoration(
//                 filled: true, //<-- SEE HERE
//                 fillColor: endPointFocus.hasFocus
//                     ? ColorUtils.primaryColor.withOpacity(0.1)
//                     : Colors.grey.withOpacity(0.1),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(color: ColorUtils.primaryColor),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(
//                     color: Colors.grey.withOpacity(0.1),
//                     width: 2.0,
//                   ),
//                 ),
//                 hintText: 'Điểm đến',
//                 prefixIcon: Icon(
//                   Icons.location_on,
//                   color: endPointFocus.hasFocus
//                       ? ColorUtils.primaryColor
//                       : Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             Center(
//                 child: ActionButton(
//               onTap: () {
//                 BlocProvider.of<BookingCubit>(context).do_filter(
//                     _startPoint.text.trim().toLowerCase(),
//                     _endPoint.text.trim().toLowerCase());
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: ColorUtils.primaryColor,
//                     borderRadius: BorderRadius.circular(25)),
//                 height: MediaQuery.of(context).size.height * 0.06,
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 child: const Center(
//                   child: Text(
//                     'Tiếp',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             )),
//           ]),
//         ),
//       ),
//     );
//   }
// }
