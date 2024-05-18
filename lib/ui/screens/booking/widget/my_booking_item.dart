import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:twg/core/utils/color_utils.dart';

class MyBookingItem extends StatefulWidget {
  final dynamic booking;
  const MyBookingItem({super.key, required this.booking});

  @override
  State<MyBookingItem> createState() => _MyBookingItemState();
}

class _MyBookingItemState extends State<MyBookingItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Card(
        elevation: 3,
        shadowColor: Colors.grey,
        child: Container(
          color: Colors.white.withOpacity(0.85),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ApplyInBookingPage(
                      //       booking: widget.booking,
                      //     ),
                      //   ),
                      // );
                    },
                    child: const Text('Danh sách apply'),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: InkWell(
                    onTap: () {
                      //   appRouter.push(DetailPageRoute(
                      //       booking: Booking.toBooking(widget.booking)));
                    },
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  widget.booking["authorId"]["avatarUrl"])),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.booking["authorId"]["first_name"],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.booking["authorId"]["phoneNumber"],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.booking["bookingType"],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Spacer(),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: widget.booking["status"] == 'available'
                                  ? ColorUtils.primaryColor
                                  : widget.booking["status"] == 'complete'
                                      ? Colors.green
                                      : Colors.red),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.booking["status"].toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ))
                    ]),
                  ),
                ),
                ExpansionTile(
                  title: const Text('Chi tiết'),
                  children: [
                    Text(widget.booking["content"],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.2),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/distance.svg",
                                height: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.booking["distance"],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/clock.svg",
                                height: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.booking["duration"],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/wallet.svg",
                                height: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${widget.booking["price"]} VND',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8),
                      child: Row(
                        children: [
                          const Text(
                            'Thời gian: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          Text(
                            widget.booking["time"],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.2),
                        thickness: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location-svgrepo-com.svg',
                              height: 40,
                            ),
                            SvgPicture.asset(
                              'assets/icons/downarrow.svg',
                              height: 40,
                            ),
                            SvgPicture.asset(
                              'assets/icons/location.svg',
                              height: 40,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatString(widget
                                            .booking["startPointMainText"]),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(widget.booking["startPointAddress"]),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      formatString(
                                          widget.booking["endPointMainText"]),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.booking["endPointAddress"],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String formatString(String input) {
  if (input.length > 30) {
    return "${input.substring(0, 27)}...";
  } else {
    return input;
  }
}
