import 'package:flutter/material.dart';
import 'dart:async';
import 'package:developer_mode_finder/developer_mode_finder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDeveloperModeEnabled = false;

  @override
  void initState() {
    super.initState();
    checkDeveloperMode();
  }

  Future<void> checkDeveloperMode() async {
    bool isEnabled = false;
    try {
      isEnabled = await DeveloperModeFinder().isDeveloperModeEnabled();
    } catch (e) {
      print('Error checking developer mode: $e');
    }

    setState(() {
      _isDeveloperModeEnabled = isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Developer Mode Finder')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Developer Mode Status:', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text(
                _isDeveloperModeEnabled ? 'ENABLED' : 'DISABLED',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _isDeveloperModeEnabled ? Colors.red : Colors.green,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: checkDeveloperMode,
                child: Text('Check Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
