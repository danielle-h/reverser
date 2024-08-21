import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String toReverse = '';
  final TextEditingController _controller = TextEditingController();

  //animation parameters
  final Duration duration = Duration(milliseconds: 300);
  Curve curve = Curves.easeInOut;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.title_text),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.inversePrimary,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _controller,
                maxLines: 5,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  toReverse = _controller.text;
                  setState(() {
                    toReverse = toReverse
                        .split('\n')
                        .map((line) => line.split('').reversed.join(''))
                        .join('\n');
                  });
                },
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.surface,
                  filled: true,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  hintText: AppLocalizations.of(context)!.input_hint,
                ),
              ).animate().scale(
                  duration: duration,
                  curve: curve,
                  begin: Offset(0.8, 0.8),
                  end: Offset(1, 1)),
              const SizedBox(height: 16.0),
              Expanded(
                child: Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Text(
                        textAlign: TextAlign.center,
                        toReverse,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ).animate().scale(
                  duration: duration,
                  delay: const Duration(milliseconds: 100),
                  curve: curve,
                  begin: Offset(0.8, 0.8),
                  end: Offset(1, 1)),
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                icon: const Icon(Icons.copy),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                onPressed: () {
                  setState(() {
                    Clipboard.setData(ClipboardData(text: toReverse));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              AppLocalizations.of(context)!.copied_message)),
                    );
                  });
                },
                label: Text(AppLocalizations.of(context)!.copy_label),
              ).animate().scale(
                  duration: duration,
                  delay: const Duration(milliseconds: 200),
                  curve: curve,
                  begin: Offset(0.5, 0.5),
                  end: Offset(1, 1)),
            ],
          ),
        ),
      ),
    );
  }
}
