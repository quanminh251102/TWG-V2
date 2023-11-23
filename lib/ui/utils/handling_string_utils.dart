class HandlingStringUtils {
  static String handleLength(String str) {
    if (str.length > 25) return '${str.substring(0, 20)}...';
    return str;
  }

  static String validateForLongString(String str) {
    /*
       - INSTRUCTION
       double str = "string long long long long long long long long"
       String result = validateForLongString(str)
       => result = "string long long long ...."
    */
    String res = str;
    if (str.length > 20) res = '${str.substring(0, 17)} ...';
    return res;
  }

  static String validateForLongStringWithLim(String str, int lim) {
    /*
       - INSTRUCTION
       double str = "string long long long long long long long long"
       String result = validateForLongString(str)
       => result = "string long long long ...."
    */
    String res = str;
    if (str.length > lim) res = '${str.substring(0, lim - 3)} ...';
    return res;
  }

  static String priceWithValue(double price) {
    /*
       - INSTRUCTION
       double price = 6200000
       String result = priceWithValue(price)
       => result = 6tr200k
    */

    String res = '';
    int value = price.toInt();
    if (value >= 1000000) {
      res = '$res${(value ~/ 1000000).toString()}tr';
    }
    value = value % 1000000;
    if (value > 0) res = '$res${(value ~/ 1000).toString()}k';
    if (res == '') res = '0k';

    return res;
  }

  static String priceInPost_noType(String price) {
    /*
    - INSTRUCTION
      post = Post(
        id: 'p1',
        userId: 'user-1',
        description: ...
        emotion: ['tiêu cực'],
        attachmentsURL: ...
        price: 6200000,
        time: "15",
        content: "Tôi ế quá cần sớm có ny",
        isFullTime: false,
        isDate: false,
        isHour: false,
        isMonth: true,
        isYear: false,
      );
      String result = priceInPost(post);
      => res = '6tr200k/tháng'
    */
    String res = '';
    int value = int.parse(price);
    if (value >= 1000000) {
      res = res = '$res${(value ~/ 1000000).toString()}tr';
    }
    value = value % 1000000;
    if (value > 0) res = '$res${(value ~/ 1000).toString()}k';

    if (res == '') res = '0k';

    return res;
  }

  static String timeDistanceFromNow(DateTime dateTime) {
    /*
    - INSTRUCTION

    res = timeDistanceFromNow(post.time);
    => res = '1 năm trước' 
            or '300 ngày trước' 
            or '2 giờ trước'
            or '2 phút trước'
            or '2 guây trước'
    */
    DateTime now = DateTime.now();
    String res = 'error';
    Duration diff = now.difference(dateTime);
    if (diff.inDays > 0) {
      if (diff.inDays >= 365) {
        res = '${(diff.inDays ~/ 365).toInt().toString()} năm';
      } else {
        res = '${diff.inDays.toInt().toString()} ngày';
      }
    } else {
      if (diff.inHours > 0) {
        res = '${diff.inHours.toInt().toString()} giờ';
      } else {
        if (diff.inMinutes > 0) {
          res = '${diff.inMinutes.toInt().toString()} phút';
        } else {
          res = '${diff.inSeconds.toInt().toString()} giây';
        }
      }
    }
    res = '$res trước';
    return res;
  }
}
