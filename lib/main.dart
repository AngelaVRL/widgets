import 'package:flutter/material.dart';
import 'CartoonCalendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Estilo oscuro
      home: Scaffold(
        backgroundColor: Color(0xFF1A1A2E),
        appBar: AppBar(
          title: Text('Calendario Cartoon'),
          backgroundColor: Color(0xFF0F3460),
        ),
        body: Center(
          child: CartoonCalendar(),
        ),
      ),
    );
  }
}
