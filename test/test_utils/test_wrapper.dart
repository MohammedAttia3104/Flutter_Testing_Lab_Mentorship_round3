import 'package:flutter/material.dart';

class TestWrapper extends StatelessWidget {
  final Widget child;
  const TestWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(body: Center(child: child)),
    );
  }
}
