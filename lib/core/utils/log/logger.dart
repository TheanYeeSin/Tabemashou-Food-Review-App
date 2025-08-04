import "dart:collection";
import "dart:io";
import "package:intl/intl.dart";
import "package:logger/logger.dart";
import "package:path_provider/path_provider.dart";
import "package:tabemashou/core/utils/log/log_printer.dart";

/// LoggerService: Handles runtime logging to file and console
class LoggerService {
  // ───── Logger instance setup ─────
  static final Logger _logger = Logger(
    level: Level.debug,
    printer: SingleLinePrinter(),
  );
  static Logger get logger => _logger;

  // ───── Internal state ─────
  static File? _logFile;
  static final Queue<_LogEntry> _logQueue = Queue<_LogEntry>();
  static bool _isProcessing = false;

  // ───── Initialization ─────
  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final String logPath = "${directory.path}/logs";

    final now = DateTime.now();
    final year = DateFormat("yyyy").format(now);
    final month = DateFormat("MM").format(now);
    final day = DateFormat("dd").format(now);

    final String path = "$logPath/$year/$month/$day";

    final logDir = Directory(path);
    if (!logDir.existsSync()) {
      logDir.createSync(recursive: true);
    }

    _logFile = File("$path/log.txt");
    if (!_logFile!.existsSync()) {
      _logFile!.createSync();
    }

    _logFile = File("$path/log.txt");
  }

  // ───── Public logging methods ─────
  static void logDebug(final String message) =>
      _enqueueLog(Level.debug, message);

  static void logInfo(final String message) => _enqueueLog(Level.info, message);

  static void logError(
    final String message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) => _enqueueLog(Level.error, message, error, stackTrace);

  static void logWarning(final String message) =>
      _enqueueLog(Level.warning, message);

  // ───── Internal log queueing ─────
  static void _enqueueLog(
    final Level level,
    final String message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    _logQueue.add(_LogEntry(level, message, error, stackTrace));
    if (!_isProcessing) {
      _processLogQueue();
    }
  }

  static Future<void> _processLogQueue() async {
    if (_isProcessing) {
      return;
    }
    _isProcessing = true;

    while (_logQueue.isNotEmpty) {
      final entry = _logQueue.removeFirst();
      switch (entry.level) {
        case Level.debug:
          _logger.d(entry.message);
          await _writeToFile("[DEBUG]: ${entry.message}");
        case Level.info:
          _logger.i(entry.message);
          await _writeToFile("[INFO]: ${entry.message}");
        case Level.warning:
          _logger.w(entry.message);
          await _writeToFile("[WARNING]: ${entry.message}");
        case Level.error:
          _logger.e(
            entry.message,
            error: entry.error,
            stackTrace: entry.stackTrace,
          );
          await _writeToFile(
            "[ERROR]: ${entry.message} \nError: ${entry.error} \nStackTrace: ${entry.stackTrace}",
          );
        default:
          _logger.d(entry.message);
          await _writeToFile("[DEBUG]: ${entry.message}");
      }

      // Add a small delay to ensure logs are written separately
      await Future.delayed(const Duration(milliseconds: 10));
    }

    _isProcessing = false;
  }

  // ───── File I/O ─────
  static Future<void> _writeToFile(final String message) async {
    if (_logFile != null) {
      await _logFile!.writeAsString(
        "${DateTime.now()} - $message\n",
        mode: FileMode.append,
        flush: true,
      );
    }
  }
}

/// _LogEntry: Internal structure for log messages
class _LogEntry {
  final Level level;
  final String message;
  final dynamic error;
  final StackTrace? stackTrace;

  _LogEntry(this.level, this.message, [this.error, this.stackTrace]);
}
