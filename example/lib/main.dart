import 'package:brick/brick.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [FlutterSmartDialog.observer],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TapMaterial(
              onTap: () {
                showLoadingWithBlock(
                  forceCallback: true,
                  onSuccess: (value) {
                    debugPrint('showLoadingWithBlock onSuccess $value');
                  },
                  onFailure: (e) {
                    debugPrint('showLoadingWithBlock onFailure $e');
                  },
                  onLoading: () async {
                    await Future.delayed(Duration(seconds: 3));
                    // throw Exception('this is a http exception');
                  },
                );
              },
              child: Text('Running on: $_platformVersion\n')),
        ),
      ),
      builder: FlutterSmartDialog.init(),
    );
  }
}
