import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reverser',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String toReverse = '';
  final TextEditingController _controller = TextEditingController();

  void _reverse() {
    setState(() {
      toReverse = toReverse.split('').reversed.join();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Reverse esreveR"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _controller,
              maxLines: 10,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your text here',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              icon: const Icon(Icons.swap_horiz),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                setState(() {
                  toReverse = _controller.text;
                  toReverse = toReverse
                      .split('\n')
                      .map((line) => line.split('').reversed.join(''))
                      .join('\n');
                });
              },
              label: Text('Reverse'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Text(
                      textAlign: TextAlign.center,
                      toReverse,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              icon: const Icon(Icons.copy),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                setState(() {
                  Clipboard.setData(ClipboardData(text: toReverse));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                });
              },
              label: Text('Copy'),
            ),
          ],
        ),
      ),
    );
  }
}
