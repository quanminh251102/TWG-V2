// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';

// enum BookingType { findDriver, findPassenger }

// class NewBookingView extends StatefulWidget {
//   const NewBookingView({super.key});

//   @override
//   State<NewBookingView> createState() => _NewBookingViewState();
// }

// String formatString(String input) {
//   if (input.length > 30) {
//     return input.substring(0, 27) + "...";
//   } else {
//     return input;
//   }
// }

// class _NewBookingViewState extends State<NewBookingView> {
//   TextEditingController textEditingController = TextEditingController();
//   late FocusNode startPlaceFocus;
//   late FocusNode endPlaceFocus;
//   late TextEditingController time;
//   late TextEditingController startPlace;
//   late TextEditingController endPlace;
//   late TextEditingController price;
//   late GlobalKey<FormState> _formKey;
//   DateTime _selectedDateTime = DateTime.now();
//   BookingType _bookingType = BookingType.findDriver;

//   bool isLoading = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     BlocProvider.of<SearchMapCubit>(context).initState();
//     startPlaceFocus = FocusNode();
//     endPlaceFocus = FocusNode();
//     startPlaceFocus.addListener(() {
//       setState(() {});
//     });
//     endPlaceFocus.addListener(() {
//       setState(() {});
//     });
//     _formKey = GlobalKey<FormState>();
//     startPlace = TextEditingController();
//     endPlace = TextEditingController();
//     time = TextEditingController();
//     price = TextEditingController();
//   }

//   Future<void> selectDateTime(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       initialEntryMode: DatePickerEntryMode.inputOnly,
//       context: context,
//       initialDate: _selectedDateTime,
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//       builder: (context, child) {
//         return Theme(
//           data: ThemeData.dark().copyWith(
//               colorScheme: const ColorScheme.dark(
//                 primary: Colors.black,
//                 surface: Colors.white,
//                 onSurface: Colors.black,
//               ),
//               dialogBackgroundColor: ColorUtils.primaryColor,
//               dialogTheme: const DialogTheme(
//                   backgroundColor: ColorUtils.primaryColor,
//                   titleTextStyle: TextStyle(color: Colors.white),
//                   contentTextStyle: TextStyle(color: Colors.black))),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null) {
//       final TimeOfDay? timePicked = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
//       );
//       if (timePicked != null) {
//         setState(() {
//           _selectedDateTime = DateTime(
//             picked.year,
//             picked.month,
//             picked.day,
//             timePicked.hour,
//             timePicked.minute,
//           );
//           final DateFormat formatter = DateFormat('HH:mm | dd/MM/yyyy');
//           time.text = formatter.format(_selectedDateTime).toString();
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//             leading: GestureDetector(
//               onTap: () => appRouter.pop(),
//               child: const Icon(
//                 Icons.arrow_back_ios_rounded,
//                 color: ColorUtils.textPrimaryColor,
//               ),
//             ),
//             title: const Text(
//               'ĐĂNG BÀI',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             centerTitle: true),
//         body: BlocConsumer<SearchMapCubit, SearchMapState>(
//           listener: (context, state) {
//             if (state is SearchMapError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Error in Search Map'),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is SearchMapLoading) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: screenSize.width * 0.05,
//                     vertical: screenSize.height * 0.03),
//                 child: Column(
//                   children: [
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Địa điểm',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.w600),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10.0),
//                             child: TextFormField(
//                               onChanged: (value) {
//                                 setState(() {
//                                   BlocProvider.of<SearchMapCubit>(context)
//                                       .getSearchPlace(value);
//                                 });
//                               },
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.w600),
//                               focusNode: startPlaceFocus,
//                               controller: startPlace,
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return "Vui lòng nhập điểm đi";
//                                 }
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                 filled: true, //<-- SEE HERE
//                                 fillColor: startPlaceFocus.hasFocus
//                                     ? ColorUtils.primaryColor.withOpacity(0.1)
//                                     : Colors.white,
//                                 focusedBorder: const OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: ColorUtils.primaryColor,
//                                         width: 2)),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Colors.grey.withOpacity(0.1),
//                                     width: 2.0,
//                                   ),
//                                 ),
//                                 hintText: 'Điểm đi',
//                                 prefixIcon: Icon(
//                                   Icons.start_outlined,
//                                   color: startPlaceFocus.hasFocus
//                                       ? ColorUtils.primaryColor
//                                       : Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             onChanged: (value) {
//                               setState(() {
//                                 BlocProvider.of<SearchMapCubit>(context)
//                                     .getSearchPlace(value);
//                               });
//                             },
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                             focusNode: endPlaceFocus,
//                             controller: endPlace,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Vui lòng nhập điểm đến";
//                               }
//                               return null;
//                             },
//                             decoration: InputDecoration(
//                               labelStyle:
//                                   const TextStyle(fontWeight: FontWeight.w600),
//                               focusColor: Colors.black,
//                               filled: true, //<-- SEE HERE
//                               fillColor: endPlaceFocus.hasFocus
//                                   ? ColorUtils.primaryColor.withOpacity(0.1)
//                                   : Colors.white,
//                               focusedBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: ColorUtils.primaryColor,
//                                       width: 2)),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.grey.withOpacity(0.1),
//                                   width: 2.0,
//                                 ),
//                               ),
//                               hintText: 'Điểm đến',
//                               prefixIcon: Icon(Icons.place_outlined,
//                                   color: endPlaceFocus.hasFocus
//                                       ? ColorUtils.primaryColor
//                                       : Colors.grey),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Expanded(
//                         child: Align(child: const CircularProgressIndicator()))
//                   ],
//                 ),
//               );
//             } else if (state is SearchMaping) {
//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: screenSize.width * 0.05,
//                       vertical: screenSize.height * 0.03),
//                   child: Column(
//                     children: [
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Địa điểm',
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.w600),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 10.0),
//                               child: TextFormField(
//                                 onChanged: (value) {
//                                   setState(() {
//                                     BlocProvider.of<SearchMapCubit>(context)
//                                         .getSearchPlace(value);
//                                   });
//                                 },
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.w600),
//                                 focusNode: startPlaceFocus,
//                                 controller: startPlace,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return "Vui lòng nhập điểm đi";
//                                   }
//                                   setState(() {});
//                                   return null;
//                                 },
//                                 decoration: InputDecoration(
//                                   filled: true, //<-- SEE HERE
//                                   fillColor: startPlaceFocus.hasFocus
//                                       ? ColorUtils.primaryColor.withOpacity(0.1)
//                                       : Colors.white,
//                                   focusedBorder: const OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: ColorUtils.primaryColor,
//                                           width: 2)),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.grey.withOpacity(0.1),
//                                       width: 2.0,
//                                     ),
//                                   ),
//                                   hintText: 'Điểm đi',
//                                   prefixIcon: Icon(
//                                     Icons.start_outlined,
//                                     color: startPlaceFocus.hasFocus
//                                         ? ColorUtils.primaryColor
//                                         : Colors.grey,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             TextFormField(
//                               onChanged: (value) {
//                                 setState(() {
//                                   BlocProvider.of<SearchMapCubit>(context)
//                                       .getSearchPlace(value);
//                                 });
//                               },
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.bold),
//                               focusNode: endPlaceFocus,
//                               controller: endPlace,
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return "Vui lòng nhập điểm đến";
//                                 }
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                 labelStyle: const TextStyle(
//                                     fontWeight: FontWeight.w600),
//                                 focusColor: Colors.black,
//                                 filled: true, //<-- SEE HERE
//                                 fillColor: endPlaceFocus.hasFocus
//                                     ? ColorUtils.primaryColor.withOpacity(0.1)
//                                     : Colors.white,
//                                 focusedBorder: const OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: ColorUtils.primaryColor,
//                                         width: 2)),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Colors.grey.withOpacity(0.1),
//                                     width: 2.0,
//                                   ),
//                                 ),
//                                 hintText: 'Điểm đến',
//                                 prefixIcon: Icon(Icons.place_outlined,
//                                     color: endPlaceFocus.hasFocus
//                                         ? ColorUtils.primaryColor
//                                         : Colors.grey),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10.0),
//                         child: Container(
//                           height: screenSize.height * 0.6,
//                           child: ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: state.placeSearchList.length,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 3.0),
//                                   child: Card(
//                                     color: Colors.white,
//                                     child: ListTile(
//                                       onTap: () {
//                                         if (startPlaceFocus.hasFocus) {
//                                           setState(() {
//                                             startPlace.text = state
//                                                 .placeSearchList[index]
//                                                 .mainText;
//                                             startPlaceFocus.unfocus();
//                                             PlaceSearch placeSearch =
//                                                 PlaceSearch(
//                                                     description: state
//                                                         .placeSearchList[index]
//                                                         .description,
//                                                     mainText: state
//                                                         .placeSearchList[index]
//                                                         .mainText,
//                                                     secondaryText: state
//                                                         .placeSearchList[index]
//                                                         .secondaryText,
//                                                     placeId: state
//                                                         .placeSearchList[index]
//                                                         .placeId);
//                                             BlocProvider.of<SearchMapCubit>(
//                                                     context)
//                                                 .doneStartSearch(placeSearch);
//                                             BlocProvider.of<SearchMapCubit>(
//                                                     context)
//                                                 .getLatLng(state
//                                                     .placeSearchList[index]
//                                                     .placeId);
//                                           });
//                                         } else {
//                                           setState(() {
//                                             endPlace.text = state
//                                                 .placeSearchList[index]
//                                                 .mainText;
//                                             endPlaceFocus.unfocus();
//                                             PlaceSearch placeSearch =
//                                                 PlaceSearch(
//                                                     description: state
//                                                         .placeSearchList[index]
//                                                         .description,
//                                                     mainText: state
//                                                         .placeSearchList[index]
//                                                         .mainText,
//                                                     secondaryText: state
//                                                         .placeSearchList[index]
//                                                         .secondaryText,
//                                                     placeId: state
//                                                         .placeSearchList[index]
//                                                         .placeId);
//                                             BlocProvider.of<SearchMapCubit>(
//                                                     context)
//                                                 .doneEndSearch(placeSearch);
//                                           });
//                                         }
//                                       },
//                                       contentPadding:
//                                           const EdgeInsets.symmetric(
//                                               horizontal: 20),
//                                       leading: SvgPicture.asset(
//                                         'assets/svg/location.svg',
//                                         height: 30,
//                                       ),
//                                       title: Text(
//                                         state.placeSearchList[index].mainText,
//                                         style: const TextStyle(
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16),
//                                       ),
//                                       subtitle: Text(
//                                         formatString(state
//                                             .placeSearchList[index]
//                                             .secondaryText),
//                                         style: const TextStyle(
//                                             color: Colors.black, fontSize: 14),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             } else if (state is SearchMapDoneSearch) {
//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: screenSize.width * 0.05,
//                       vertical: screenSize.height * 0.03),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Form(
//                           key: _formKey,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Địa điểm',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.w600),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: TextFormField(
//                                   onChanged: (value) {
//                                     setState(() {
//                                       BlocProvider.of<SearchMapCubit>(context)
//                                           .getSearchPlace(value);
//                                     });
//                                   },
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w600),
//                                   focusNode: startPlaceFocus,
//                                   controller: startPlace,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Vui lòng nhập điểm đi";
//                                     }
//                                     return null;
//                                   },
//                                   decoration: InputDecoration(
//                                     filled: true, //<-- SEE HERE
//                                     fillColor: startPlaceFocus.hasFocus
//                                         ? ColorUtils.primaryColor
//                                             .withOpacity(0.1)
//                                         : Colors.white,
//                                     focusedBorder: const OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: ColorUtils.primaryColor,
//                                             width: 2)),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Colors.grey.withOpacity(0.1),
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                     hintText: 'Điểm đi',
//                                     prefixIcon: Icon(
//                                       Icons.start_outlined,
//                                       color: startPlaceFocus.hasFocus
//                                           ? ColorUtils.primaryColor
//                                           : Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 onChanged: (value) {
//                                   setState(() {
//                                     BlocProvider.of<SearchMapCubit>(context)
//                                         .getSearchPlace(value);
//                                   });
//                                 },
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold),
//                                 focusNode: endPlaceFocus,
//                                 controller: endPlace,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return "Vui lòng nhập điểm đến";
//                                   }
//                                   return null;
//                                 },
//                                 decoration: InputDecoration(
//                                   labelStyle: const TextStyle(
//                                       fontWeight: FontWeight.w600),
//                                   focusColor: Colors.black,
//                                   filled: true, //<-- SEE HERE
//                                   fillColor: endPlaceFocus.hasFocus
//                                       ? ColorUtils.primaryColor.withOpacity(0.1)
//                                       : Colors.white,
//                                   focusedBorder: const OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: ColorUtils.primaryColor,
//                                           width: 2)),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.grey.withOpacity(0.1),
//                                       width: 2.0,
//                                     ),
//                                   ),
//                                   hintText: 'Điểm đến',
//                                   prefixIcon: Icon(Icons.place_outlined,
//                                       color: endPlaceFocus.hasFocus
//                                           ? ColorUtils.primaryColor
//                                           : Colors.grey),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: state.imageRoute),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               const Text(
//                                 'Thời gian',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.w600),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 10.0, bottom: 10),
//                                 child: TextFormField(
//                                   readOnly: true,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w600),
//                                   controller: time,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Vui lòng chọn thời gian";
//                                     }
//                                     return null;
//                                   },
//                                   decoration: InputDecoration(
//                                       filled: true, //<-- SEE HERE
//                                       fillColor: Colors.white,
//                                       focusedBorder: const OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: ColorUtils.primaryColor,
//                                               width: 2)),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: Colors.grey.withOpacity(0.1),
//                                           width: 2.0,
//                                         ),
//                                       ),
//                                       hintText: 'Thời gian',
//                                       prefixIcon: IconButton(
//                                         onPressed: () =>
//                                             selectDateTime(context),
//                                         icon: const Icon(
//                                           Icons.calendar_month_outlined,
//                                           color: Colors.grey,
//                                         ),
//                                       )),
//                                 ),
//                               ),
//                               const Text(
//                                 'Loại bài đăng',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.w600),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Colors.white),
//                                 width: screenSize.width * 0.9,
//                                 height: screenSize.height * 0.08,
//                                 child: Center(
//                                   child: RadioListTile(
//                                     controlAffinity:
//                                         ListTileControlAffinity.trailing,
//                                     title: Row(
//                                       children: [
//                                         SvgPicture.asset(
//                                           "assets/svg/driver.svg",
//                                           height: 40,
//                                         ),
//                                         const SizedBox(
//                                           width: 10,
//                                         ),
//                                         const Text(
//                                           'Tìm tài xế',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                     value: BookingType.findDriver,
//                                     groupValue: _bookingType,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _bookingType = value!;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: Container(
//                                   width: screenSize.width * 0.9,
//                                   height: screenSize.height * 0.08,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.white),
//                                   child: Center(
//                                     child: RadioListTile(
//                                       controlAffinity:
//                                           ListTileControlAffinity.trailing,
//                                       title: Row(
//                                         children: [
//                                           SvgPicture.asset(
//                                             "assets/svg/passenger.svg",
//                                             height: 40,
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           const Text(
//                                             'Tìm hành khách',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                       value: BookingType.findPassenger,
//                                       groupValue: _bookingType,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           _bookingType = value!;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               const Text(
//                                 'Giá tiền',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.w600),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 10.0, bottom: 10),
//                                 child: TextFormField(
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w600),
//                                   controller: price,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Vui lòng nhập giá tiền";
//                                     }
//                                     return null;
//                                   },
//                                   decoration: InputDecoration(
//                                       filled: true, //<-- SEE HERE
//                                       fillColor: Colors.white,
//                                       focusedBorder: const OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: ColorUtils.primaryColor,
//                                               width: 2)),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: Colors.grey.withOpacity(0.1),
//                                           width: 2.0,
//                                         ),
//                                       ),
//                                       hintText: 'Giá tiền',
//                                       prefixIcon: IconButton(
//                                         onPressed: () =>
//                                             selectDateTime(context),
//                                         icon: const Icon(
//                                           Icons.price_change_outlined,
//                                           color: Colors.grey,
//                                         ),
//                                       )),
//                                 ),
//                               ),
//                               const Text(
//                                 'Nội dung',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.w600),
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                 child: TextField(
//                                   controller: textEditingController,
//                                   keyboardType: TextInputType.multiline,
//                                   decoration: InputDecoration(
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         vertical: 20.0, horizontal: 20.0),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                           color: Color(0xffF2F2F3)),
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                           color: ColorUtils.borderColor),
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                     hintText:
//                                         "Mình cần tìm người đi cùng chiều nay...",
//                                     hintStyle: const TextStyle(
//                                         color: Color(0xff616161),
//                                         fontFamily: "AvertaStdCY-Regular"),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                   ),
//                                   style: const TextStyle(
//                                       fontSize: 14, color: Colors.black),
//                                   maxLines: 100,
//                                   minLines: 1,
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 20.0, bottom: 20),
//                                 child: isLoading
//                                     ? const Center(
//                                         child: CircularProgressIndicator())
//                                     : Align(
//                                         child: GestureDetector(
//                                           onTap: () async {
//                                             print('add booking');
//                                             setState(() {
//                                               isLoading = true;
//                                             });
//                                             // await Future.delayed(
//                                             //     Duration(seconds: 2));
//                                             if (_bookingType ==
//                                                 BookingType.findDriver) {
//                                               String booking = 'Tìm tài xế';
//                                               await BlocProvider.of<
//                                                       SearchMapCubit>(context)
//                                                   .addNewBooking(
//                                                       time.text,
//                                                       booking,
//                                                       price.text,
//                                                       textEditingController.text
//                                                           .trim());
//                                               print(textEditingController.text
//                                                   .trim());
//                                             } else {
//                                               String booking = 'Tìm hành khách';
//                                               await BlocProvider.of<
//                                                       SearchMapCubit>(context)
//                                                   .addNewBooking(
//                                                       time.text,
//                                                       booking,
//                                                       price.text,
//                                                       textEditingController
//                                                           .text);
//                                             }
//                                             setState(() {
//                                               isLoading = false;
//                                             });
//                                             appRouter.push(HomePageViewRoute(
//                                                 email: appUser.gmail,
//                                                 index: 1));
//                                           },
//                                           child: Container(
//                                               height: screenSize.height * 0.06,
//                                               width: screenSize.width * 0.8,
//                                               decoration: BoxDecoration(
//                                                   color:
//                                                       ColorUtils.primaryColor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           20)),
//                                               child: const Center(
//                                                 child: Text(
//                                                   'Thêm bài viết',
//                                                   style: TextStyle(
//                                                       color: Colors.black,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 14),
//                                                 ),
//                                               )),
//                                         ),
//                                       ),
//                               ),
//                               if (isLoading)
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 20.0, bottom: 20),
//                                   child: Align(
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         setState(() {
//                                           isLoading = false;
//                                         });
//                                       },
//                                       child: Container(
//                                           height: screenSize.height * 0.06,
//                                           width: screenSize.width * 0.8,
//                                           decoration: BoxDecoration(
//                                               color: Colors.grey,
//                                               borderRadius:
//                                                   BorderRadius.circular(20)),
//                                           child: const Center(
//                                             child: Text(
//                                               'Hủy',
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 14),
//                                             ),
//                                           )),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           )),
//                     ],
//                   ),
//                 ),
//               );
//             } else {
//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: screenSize.width * 0.05,
//                       vertical: screenSize.height * 0.03),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Form(
//                           key: _formKey,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'Địa điểm',
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.w600),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: TextFormField(
//                                   onChanged: (value) {
//                                     setState(() {
//                                       BlocProvider.of<SearchMapCubit>(context)
//                                           .getSearchPlace(value);
//                                     });
//                                   },
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w600),
//                                   focusNode: startPlaceFocus,
//                                   controller: startPlace,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Vui lòng nhập điểm đi";
//                                     }
//                                     return null;
//                                   },
//                                   decoration: InputDecoration(
//                                     filled: true, //<-- SEE HERE
//                                     fillColor: startPlaceFocus.hasFocus
//                                         ? ColorUtils.primaryColor
//                                             .withOpacity(0.1)
//                                         : Colors.white,
//                                     focusedBorder: const OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: ColorUtils.primaryColor,
//                                             width: 2)),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Colors.grey.withOpacity(0.1),
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                     hintText: 'Điểm đi',
//                                     prefixIcon: Icon(
//                                       Icons.start_outlined,
//                                       color: startPlaceFocus.hasFocus
//                                           ? ColorUtils.primaryColor
//                                           : Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               TextFormField(
//                                 onChanged: (value) {
//                                   setState(() {
//                                     BlocProvider.of<SearchMapCubit>(context)
//                                         .getSearchPlace(value);
//                                   });
//                                 },
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold),
//                                 focusNode: endPlaceFocus,
//                                 controller: endPlace,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return "Vui lòng nhập điểm đến";
//                                   }
//                                   return null;
//                                 },
//                                 decoration: InputDecoration(
//                                   labelStyle: const TextStyle(
//                                       fontWeight: FontWeight.w600),
//                                   focusColor: Colors.black,
//                                   filled: true, //<-- SEE HERE
//                                   fillColor: endPlaceFocus.hasFocus
//                                       ? ColorUtils.primaryColor.withOpacity(0.1)
//                                       : Colors.white,
//                                   focusedBorder: const OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: ColorUtils.primaryColor,
//                                           width: 2)),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.grey.withOpacity(0.1),
//                                       width: 2.0,
//                                     ),
//                                   ),
//                                   hintText: 'Điểm đến',
//                                   prefixIcon: Icon(Icons.place_outlined,
//                                       color: endPlaceFocus.hasFocus
//                                           ? ColorUtils.primaryColor
//                                           : Colors.grey),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Thời gian',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 10.0, bottom: 10),
//                                     child: TextFormField(
//                                       readOnly: true,
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w600),
//                                       controller: time,
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return "Vui lòng chọn thời gian";
//                                         }
//                                         return null;
//                                       },
//                                       decoration: InputDecoration(
//                                           filled: true, //<-- SEE HERE
//                                           fillColor: Colors.white,
//                                           focusedBorder:
//                                               const OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                       color: ColorUtils
//                                                           .primaryColor,
//                                                       width: 2)),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color:
//                                                   Colors.grey.withOpacity(0.1),
//                                               width: 2.0,
//                                             ),
//                                           ),
//                                           hintText: 'Thời gian',
//                                           prefixIcon: IconButton(
//                                             onPressed: () =>
//                                                 selectDateTime(context),
//                                             icon: const Icon(
//                                               Icons.calendar_month_outlined,
//                                               color: Colors.grey,
//                                             ),
//                                           )),
//                                     ),
//                                   ),
//                                   const Text(
//                                     'Loại bài đăng',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: Colors.white),
//                                     width: screenSize.width * 0.9,
//                                     height: screenSize.height * 0.08,
//                                     child: Center(
//                                       child: RadioListTile(
//                                         controlAffinity:
//                                             ListTileControlAffinity.trailing,
//                                         title: Row(
//                                           children: [
//                                             SvgPicture.asset(
//                                               "assets/svg/driver.svg",
//                                               height: 40,
//                                             ),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//                                             const Text(
//                                               'Tìm tài xế',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                         value: BookingType.findDriver,
//                                         groupValue: _bookingType,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             _bookingType = value!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 10.0),
//                                     child: Container(
//                                       width: screenSize.width * 0.9,
//                                       height: screenSize.height * 0.08,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           color: Colors.white),
//                                       child: Center(
//                                         child: RadioListTile(
//                                           controlAffinity:
//                                               ListTileControlAffinity.trailing,
//                                           title: Row(
//                                             children: [
//                                               SvgPicture.asset(
//                                                 "assets/svg/passenger.svg",
//                                                 height: 40,
//                                               ),
//                                               const SizedBox(
//                                                 width: 10,
//                                               ),
//                                               const Text(
//                                                 'Tìm hành khách',
//                                                 style: TextStyle(
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ],
//                                           ),
//                                           value: BookingType.findPassenger,
//                                           groupValue: _bookingType,
//                                           onChanged: (value) {
//                                             setState(() {
//                                               _bookingType = value!;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   const Text(
//                                     'Giá tiền',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 10.0, bottom: 10),
//                                     child: TextFormField(
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w600),
//                                       controller: price,
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return "Vui lòng nhập giá tiền";
//                                         }
//                                         return null;
//                                       },
//                                       decoration: InputDecoration(
//                                           filled: true, //<-- SEE HERE
//                                           fillColor: Colors.white,
//                                           focusedBorder:
//                                               const OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                       color: ColorUtils
//                                                           .primaryColor,
//                                                       width: 2)),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color:
//                                                   Colors.grey.withOpacity(0.1),
//                                               width: 2.0,
//                                             ),
//                                           ),
//                                           hintText: 'Giá tiền',
//                                           prefixIcon: IconButton(
//                                             onPressed: () =>
//                                                 selectDateTime(context),
//                                             icon: const Icon(
//                                               Icons.price_change_outlined,
//                                               color: Colors.grey,
//                                             ),
//                                           )),
//                                     ),
//                                   ),
//                                   const Text(
//                                     'Nội dung',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10),
//                                     child: TextField(
//                                       controller: textEditingController,
//                                       keyboardType: TextInputType.multiline,
//                                       decoration: InputDecoration(
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                                 vertical: 20.0,
//                                                 horizontal: 20.0),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: Color(0xffF2F2F3)),
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: const BorderSide(
//                                               color: ColorUtils.borderColor),
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                         ),
//                                         hintText:
//                                             "Mình cần tìm người đi cùng chiều nay...",
//                                         hintStyle: const TextStyle(
//                                             color: Color(0xff616161),
//                                             fontFamily: "AvertaStdCY-Regular"),
//                                         filled: true,
//                                         fillColor: Colors.white,
//                                       ),
//                                       style: const TextStyle(
//                                           fontSize: 14, color: Colors.black),
//                                       maxLines: 100,
//                                       minLines: 1,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 20.0, bottom: 20),
//                                     child: isLoading
//                                         ? const Center(
//                                             child: CircularProgressIndicator())
//                                         : Align(
//                                             child: GestureDetector(
//                                               onTap: () async {
//                                                 print('add booking');
//                                                 setState(() {
//                                                   isLoading = true;
//                                                 });
//                                                 // await Future.delayed(
//                                                 //     Duration(seconds: 2));
//                                                 if (_bookingType ==
//                                                     BookingType.findDriver) {
//                                                   String booking = 'Tìm tài xế';
//                                                   await BlocProvider.of<
//                                                               SearchMapCubit>(
//                                                           context)
//                                                       .addNewBooking(
//                                                           time.text,
//                                                           booking,
//                                                           price.text,
//                                                           textEditingController
//                                                               .text
//                                                               .trim());
//                                                   print(textEditingController
//                                                       .text
//                                                       .trim());
//                                                 } else {
//                                                   String booking =
//                                                       'Tìm hành khách';
//                                                   await BlocProvider.of<
//                                                               SearchMapCubit>(
//                                                           context)
//                                                       .addNewBooking(
//                                                           time.text,
//                                                           booking,
//                                                           price.text,
//                                                           textEditingController
//                                                               .text);
//                                                 }
//                                                 setState(() {
//                                                   isLoading = false;
//                                                 });
//                                                 appRouter.push(
//                                                     HomePageViewRoute(
//                                                         email: appUser.gmail,
//                                                         index: 1));
//                                               },
//                                               child: Container(
//                                                   height:
//                                                       screenSize.height * 0.06,
//                                                   width: screenSize.width * 0.8,
//                                                   decoration: BoxDecoration(
//                                                       color: ColorUtils
//                                                           .primaryColor,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               20)),
//                                                   child: const Center(
//                                                     child: Text(
//                                                       'Thêm bài viết',
//                                                       style: TextStyle(
//                                                           color: Colors.black,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 14),
//                                                     ),
//                                                   )),
//                                             ),
//                                           ),
//                                   ),
//                                   if (isLoading)
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 20.0, bottom: 20),
//                                       child: Align(
//                                         child: GestureDetector(
//                                           onTap: () async {
//                                             setState(() {
//                                               isLoading = false;
//                                             });
//                                           },
//                                           child: Container(
//                                               height: screenSize.height * 0.06,
//                                               width: screenSize.width * 0.8,
//                                               decoration: BoxDecoration(
//                                                   color: Colors.grey,
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           20)),
//                                               child: const Center(
//                                                 child: Text(
//                                                   'Hủy',
//                                                   style: TextStyle(
//                                                       color: Colors.black,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 14),
//                                                 ),
//                                               )),
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ],
//                           )),
//                     ],
//                   ),
//                 ),
//               );
//             }
//           },
//         ));
//   }
// }
