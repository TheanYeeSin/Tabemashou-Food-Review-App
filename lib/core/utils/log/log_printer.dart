import "package:logger/logger.dart";

/// Log printer that formats the log entry in a single line
class SingleLinePrinter extends LogPrinter {
  @override
  List<String> log(final LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final message = event.message;
    final dateTimeString = DateTime.now().toIso8601String();

    return [color!("$dateTimeString: $emoji $message")];
  }
}
