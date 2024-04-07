import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login_yandex/flutter_login_yandex.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _token = 'empty';
  final _flutterLoginYandexPlugin = FlutterLoginYandex();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Token: $_token\n', textAlign: TextAlign.center),
              InkWell(
                onTap: () async {
                  final response = await _flutterLoginYandexPlugin.signIn();
                  if (response != null) {
                    setState(() {
                      if (response['token'] != null) {
                        _token = response['token'] as String;
                      } else {
                        _token = response['error'] as String;
                      }
                    });
                  }
                },
                child: const Padding(
                    padding: EdgeInsets.all(15), child: Text('Press')),
              ),
              if (Platform.isIOS)
                InkWell(
                  onTap: () async {
                    final response = await _flutterLoginYandexPlugin.signOut();
                    setState(() {
                      _token = '';
                    });
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(15), child: Text('Sign Out')),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
