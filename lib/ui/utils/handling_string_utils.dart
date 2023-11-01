class HandlingStringUtils {
  static String handleLength(String str) {
    if (str.length > 25) return '${str.substring(0, 20)}...';
    return str;
  }
}
