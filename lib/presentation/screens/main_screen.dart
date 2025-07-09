import "package:flutter/material.dart";
import "package:tabemashou/core/constants/path.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("You have pushed the button this many times:"),
          Text("$_counter", style: Theme.of(context).textTheme.headlineMedium),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, MORE_PATH),
            child: const Text("More"),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: "Increment",
      child: const Icon(Icons.add),
    ),
  );
}
