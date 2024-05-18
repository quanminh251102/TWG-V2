import 'dart:async';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';
import 'dart:io';

class RLogger {
  final String tag;
  final bool isWriteFile;
  late RLoggerData _dataController;

  static RLogger? instance;

  RLogger._(String filePath, String? fileName, this.tag, this.isWriteFile) {
    _writer = _RFileWriter(filePath, fileName);
  }

  late _RFileWriter _writer;

  ///[tag] is the name of the source of the log message
  ///[isWriteFile] is the log message write file ?
  ///[filePath] is the log message write file path.
  ///[fileName] is the log message write file name.
  static RLogger initLogger(
      {String tag = 'RLogger',
      bool isWriteFile = false,
      required String filePath,
      String? fileName}) {
    return instance = RLogger._(filePath, fileName, tag, isWriteFile);
  }

  /// log debug
  ///
  /// [message] s the log message
  /// [tag] is the name of the source of the log message
  /// [isWriteFile] is the log message write file ?
  void d(String message, {String? tag, bool? isWriteFile}) {
    _dataController = RLoggerData(tag ?? this.tag, RLoggerLevel.debug, message,
        dateTime: DateTime.now(), isWriteFile: isWriteFile ?? this.isWriteFile);
  }

  Future i(String message, {String? tag, bool? isWriteFile}) async {
    _dataController = RLoggerData(tag ?? this.tag, RLoggerLevel.info, message,
        dateTime: DateTime.now(), isWriteFile: isWriteFile ?? this.isWriteFile);
    _handlePrintMessage(_dataController);
    await _handleWriteFile(_dataController);
  }

  /// log json
  ///
  /// [message] s the log message
  /// [tag] is the name of the source of the log message
  /// [isWriteFile] is the log message write file ?
  void j(String json, {String? tag, bool? isWriteFile}) {
    _dataController = RLoggerData(
      tag ?? this.tag,
      RLoggerLevel.debug,
      _RJson.jsonFormat(json),
      dateTime: DateTime.now(),
      isWriteFile: isWriteFile ?? this.isWriteFile,
    );
  }

  /// log error
  ///
  /// [message] is the log message
  /// [error] an error object associated with this log event
  /// [tag] is the name of the source of the log message
  /// [isWriteFile] is the log message write file ?
  Future e(String message, Object error, StackTrace stackTrace,
      {String? tag, required bool isWriteFile}) async {
    _dataController = RLoggerData(tag ?? this.tag, RLoggerLevel.error, message,
        error: error,
        stackTrace: stackTrace,
        dateTime: DateTime.now(),
        isWriteFile: isWriteFile);
    _handlePrintMessage(_dataController);
    await _handleWriteFile(_dataController);
  }

  void _handlePrintMessage(RLoggerData event) {
    switch (event.level) {
      case RLoggerLevel.debug:
        developer.log(
          event.message,
          name: event.tag,
          time: event.dateTime,
        );
        break;
      case RLoggerLevel.info:
        print('(${event.tag}):${event.message}');
        break;
      case RLoggerLevel.error:
        developer.log(
          event.message,
          name: event.tag,
          time: event.dateTime,
          error: event.error,
          stackTrace: event.stackTrace,
        );
        break;
    }
  }

  Future _handleWriteFile(RLoggerData event) async {
    if (event.isWriteFile != true) return;
    switch (event.level) {
      case RLoggerLevel.debug:
        await _writer.writeLog(
            '\r\n (${event.tag})${DateFormat('yyyy-MM-dd HH:mm:ss').format(event.dateTime ?? DateTime.now())}:${event.message}\r\n');
        break;
      case RLoggerLevel.info:
        await _writer.writeLog(
            '\r\n(${event.tag})${DateFormat('yyyy-MM-dd HH:mm:ss').format(event.dateTime ?? DateTime.now())}:${event.message}\r\n');
        break;
      case RLoggerLevel.error:
        await _writer.writeLog(
            '\r\n(${event.tag})${DateFormat('yyyy-MM-dd HH:mm:ss').format(event.dateTime ?? DateTime.now())}:${event.message}\r\n--->Error:\r\n ${event.error}\r\n--->StackTrace:\r\n${event.stackTrace.toString()}\r\n');
        break;
    }
  }
}

/// log message file writer
class _RFileWriter {
  /// write file
  late File file;

  _RFileWriter(String filePath, String? fileName) {
    Directory rootPath = Directory(filePath);
    file = File(
        '${rootPath.path}${fileName ?? '${DateFormat('yyyy_MM_dd').format(DateTime.now())}_log.txt'}');
  }

  Future<void> writeLog(String message) async {
    if (!file.existsSync()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(message, mode: FileMode.append);
  }
}

class _RJson {
  /// json level ping
  ///
  /// [level] your level
  static String _getLevelStr(int level) {
    StringBuffer levelStr = StringBuffer();
    for (int levelI = 0; levelI < level; levelI++) {
      List<int> codeUnits = "\t".codeUnits;
      for (var i in codeUnits) {
        levelStr.writeCharCode(i);
      }
    }
    return levelStr.toString();
  }

  /// json format
  ///
  /// [s] your json
  static String jsonFormat(String s) {
    int level = 0;
    StringBuffer jsonForMatStr = StringBuffer();
    for (int index = 0; index < s.length; index++) {
      int c = s.codeUnitAt(index);
      if (level > 0 &&
          '\n'.codeUnitAt(0) ==
              jsonForMatStr.toString().codeUnitAt(jsonForMatStr.length - 1)) {
        jsonForMatStr.write(_getLevelStr(level));
      }
      if ('{'.codeUnitAt(0) == c || '['.codeUnitAt(0) == c) {
        jsonForMatStr.write("${String.fromCharCode(c)}\r\n");
        level++;
      } else if (','.codeUnitAt(0) == c) {
        jsonForMatStr.write("${String.fromCharCode(c)}\r\n");
      } else if ('}'.codeUnitAt(0) == c || ']'.codeUnitAt(0) == c) {
        jsonForMatStr.write("\r\n");
        level--;
        jsonForMatStr.write(_getLevelStr(level));
        jsonForMatStr.writeCharCode(c);
      } else {
        jsonForMatStr.writeCharCode(c);
      }
    }
    return jsonForMatStr.toString();
  }
}

enum RLoggerLevel {
  debug,
  info,
  error,
}

class RLoggerData {
  final String tag;
  final RLoggerLevel level;
  final String message;
  final Object? error;
  final StackTrace? stackTrace;
  final DateTime? dateTime;
  final bool? isWriteFile;

  RLoggerData(this.tag, this.level, this.message,
      {this.error, this.stackTrace, this.dateTime, this.isWriteFile});
}
