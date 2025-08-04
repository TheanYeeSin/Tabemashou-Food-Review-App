import "package:logger/logger.dart";

/// SingleLinePrinter: Custom log printer that outputs logs in a single-line format with color and emoji
class SingleLinePrinter extends LogPrinter {
  @override
  List<String> log(final LogEvent event) {
    final levelColor = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level] ?? "";
    final timestamp = DateTime.now().toIso8601String();
    final message = event.message.toString();

    return [
      if (levelColor != null)
        levelColor("$timestamp: $emoji $message")
      else
        "$timestamp: $emoji $message",
    ];
  }
}
