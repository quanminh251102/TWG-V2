import 'package:flutter/material.dart';

extension StringExtension on String {
  bool isNullOrEmpty() {
    return this == '';
  }

  List<String> divideAndWrapText(int width) {
    var remain = trimLeft();
    var result = <String>[];
    while (remain != '') {
      var numOfCharToTake = _findNumOfCharToTakeForWrapping(remain, width);
      result.add(remain.substring(0, numOfCharToTake));
      remain = remain.substring(numOfCharToTake);
      remain = remain.trimLeft();
    }
    return result;
  }

  int _findNumOfCharToTakeForWrapping(String str, int maxWidth) {
    if (str.length <= maxWidth) {
      return str.length;
    }
    var nextSpaceIndex = str.indexOf(' ');
    if (nextSpaceIndex == -1 || nextSpaceIndex >= maxWidth) {
      // no more space or space position is farther than width limit
      return maxWidth;
    } // max size
    // find appropriate space = farthest position that < maxWidth
    var subStr = str.substring(0, maxWidth); // str.length now > maxWidth
    return subStr.lastIndexOf(' ');
  }

  double toTimeOfDayAsDouble() {
    TimeOfDay _time = TimeOfDay(
        hour: int.parse(this.split(":")[0]),
        minute: int.parse(this.split(":")[1]));
    return _time.hour + _time.minute / 60.0;
  }

  // List<TextSpan> detectLink() {
  //   List<TextSpan> textSpan = [];

  //   final urlRegExp = RegExp(
  //       r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  //   getLink(String linkString) {
  //     textSpan.add(
  //       TextSpan(
  //         text: linkString,
  //         style: TextStyleUtils.newsDescription.copyWith(
  //           color: Colors.blue,
  //         ),
  //         recognizer: TapGestureRecognizer()
  //           ..onTap = () async {
  //             var url = Uri.parse(linkString);
  //             if (await canLaunchUrl(url)) {
  //               await launch(linkString,
  //                   forceSafariVC: false, forceWebView: false);
  //             } else {
  //               throw 'Could not launch $linkString';
  //             }
  //           },
  //       ),
  //     );
  //     return linkString;
  //   }

  //   getNormalText(String normalText) {
  //     textSpan.add(
  //       TextSpan(
  //         text: normalText,
  //       ),
  //     );
  //     return normalText;
  //   }

  //   this.splitMapJoin(
  //     urlRegExp,
  //     onMatch: (m) => getLink("${m.group(0)}"),
  //     onNonMatch: (n) => getNormalText(n.substring(0)),
  //   );

  //   return textSpan;
  // }
}
