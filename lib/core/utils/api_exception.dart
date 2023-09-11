class ApiException implements Exception {
  final String msg;
  // http response body content
  final String content;
  ApiException(this.msg, this.content);
  String toString() => 'ApiException: $msg';
}

class ErrorApi
{
  List<String> errors;
  bool isEmpty;

  ErrorApi({required this.errors,required this.isEmpty});

  factory ErrorApi.fromJson(Map<String, dynamic> json) {
    return ErrorApi(
      isEmpty: json['isEmpty'],
      errors: List<String>.from(json['errors'])
    );
  }
}