import 'package:flutter/material.dart';

import 'paginas/principal.dart';

void main() {
  runApp(const TempoApp());
}

class TempoApp extends StatefulWidget {
  const TempoApp({super.key});

  @override
  State<TempoApp> createState() => _TempoState();
}

class _TempoState extends State<TempoApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Principal(),
    );
  }
}
