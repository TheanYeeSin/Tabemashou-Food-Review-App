import "dart:collection";
import "dart:io";
import "package:intl/intl.dart";
import "package:logger/logger.dart";
import "package:path_provider/path_provider.dart";
import "package:tabemashou/core/utils/log/log_printer.dart";

/// Logger service that handles log entries
class LoggerService {
  static final Logger _logger = Logger(
    level: Level.debug,
    printer: SingleLinePrinter(),
  );

  static Logger get logger => _logger;

  static File? _logFile;
  static final Queue<_LogEntry> _logQueue = Queue<_LogEntry>();
  static bool _isProcessing = false;

  /// Initializes the logger service
  static Future<void> init() async {
    // Create log directory
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

  /// Writes a debug message to the log file
  static void logDebug(final String message) =>
      _enqueueLog(Level.debug, message);

  /// Writes an info message to the log file
  static void logInfo(final String message) => _enqueueLog(Level.info, message);

  /// Writes an error message to the log file
  static void logError(
    final String message, [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) => _enqueueLog(Level.error, message, error, stackTrace);

  /// Writes a warning message to the log file
  static void logWarning(final String message) =>
      _enqueueLog(Level.warning, message);

  /// Writes the log entry to the log file
  static Future<void> _writeToFile(final String message) async {
    if (_logFile != null) {
      await _logFile!.writeAsString(
        "${DateTime.now()} - $message\n",
        mode: FileMode.append,
        flush: true,
      );
    }
  }

  /// Enqueues a log entry
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

  /// Processes the log queue
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
}

/// Represents a log entry
class _LogEntry {
  final Level level;
  final String message;
  final dynamic error;
  final StackTrace? stackTrace;

  _LogEntry(this.level, this.message, [this.error, this.stackTrace]);
}
