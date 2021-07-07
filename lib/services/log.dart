import 'package:logger/logger.dart';

class Log {
  Logger logger;
  Log() {
    logger = Logger(
      printer: PrettyPrinter(
          methodCount: 3, // number of method calls to be displayed
          errorMethodCount: 8,
          lineLength: 130, // width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          printTime: false),
    );
  }
  void i(String message) {
    logger.i(message);
  }

  void w(String message) {
    logger.w(message);
  }

  void e(String message) {
    logger.e(message);
  }

  void d(String message) {
    logger.d(message);
  }

  void v(String message) {
    logger.v(message);
  }
}
