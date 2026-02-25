import "package:flutter/material.dart";

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Settings"), centerTitle: true),
    body: ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.tune_outlined),
          title: Text("General"),
          subtitle: Text("Manage general settings"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.palette_outlined),
          title: Text("Appearance"),
          subtitle: Text("Display UI, Theme"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.library_books_outlined),
          title: Text("Library"),
          subtitle: Text("Categories"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.backup_outlined),
          title: Text("Data & Storage"),
          subtitle: Text("Backup, Restore, Clear data"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.notification_important_outlined),
          title: Text("Notifications"),
          subtitle: Text("Manage reminders and notifications"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.code_outlined),
          title: Text("Advanced"),
          subtitle: Text("Optimization"),
          onTap: () {},
        ),
      ],
    ),
  );
}
