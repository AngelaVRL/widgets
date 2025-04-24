import 'package:flutter/material.dart';
import 'CartoonClock.dart';
import 'CartoonCalendar.dart'; // importa el calendario

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      appBar: AppBar(
        title: Text('Agenda Cartoon'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Reloj arriba
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CartoonClock(),
          ),

          // Separación
          SizedBox(height: 20),

          // Calendario ocupa el resto del espacio
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CartoonCalendar(),
            ),
          ),
        ],
      ),
    );
  }
}
