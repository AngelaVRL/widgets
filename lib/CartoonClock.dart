import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartoonClock extends StatefulWidget {
  @override
  _CartoonClockState createState() => _CartoonClockState();
}

class _CartoonClockState extends State<CartoonClock> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hour = _currentTime.hour % 12;
    final minute = _currentTime.minute;
    final second = _currentTime.second;

    return Container(
      width: 300,
      height: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF2B2D42),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.5),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.deepPurpleAccent, width: 4),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Números del reloj
          for (int i = 1; i <= 12; i++)
            Transform.translate(
              offset: Offset(
                100 * cos((i * 30 - 90) * pi / 180),
                100 * sin((i * 30 - 90) * pi / 180),
              ),
              child: Text(
                '$i',
                style: GoogleFonts.poppins(
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

          // Aguja de la hora
          Transform.rotate(
            angle: (pi / 6) * hour + (pi / 360) * minute,
            child: Container(
              width: 6,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          // Aguja del minuto
          Transform.rotate(
            angle: (pi / 30) * minute + (pi / 1800) * second,
            child: Container(
              width: 4,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          // Aguja del segundo
          Transform.rotate(
            angle: (pi / 30) * second,
            child: Container(
              width: 2,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Punto central
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.deepPurple, width: 3),
            ),
          ),

          // Hora digital (abajo)
          Positioned(
            bottom: 10,
            child: Text(
              "${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
