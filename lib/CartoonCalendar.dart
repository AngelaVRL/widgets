import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

class CartoonCalendar extends StatefulWidget {
  @override
  _CartoonCalendarState createState() => _CartoonCalendarState();
}

class _CartoonCalendarState extends State<CartoonCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TextEditingController _eventController = TextEditingController();
  Map<DateTime, List<String>> _events = {
    DateTime.utc(2025, 4, 22): ['Evento especial 🌟'],
    DateTime.utc(2025, 4, 24): ['Reunión importante 💼', 'Cita médica 🏥'],
  };

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  void _deleteEvent(DateTime date, String event) {
    setState(() {
      _events[date]?.remove(event);
      if (_events[date]?.isEmpty ?? true) {
        _events.remove(date);  // Eliminar el día si no tiene eventos
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Calendario interactivo
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF2B2D42),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.4),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
              markersMaxCount: 3,
              todayDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            eventLoader: _getEventsForDay,
            headerStyle: HeaderStyle(
              titleTextStyle: GoogleFonts.poppins(
                color: Colors.yellowAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: Icon(Icons.arrow_back_ios, color: Colors.white),
              rightChevronIcon: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.pinkAccent),
              weekdayStyle: TextStyle(color: Colors.cyanAccent),
            ),
          ),
        ),
        SizedBox(height: 20),

        // Input para agregar nuevo evento
        Text(
          'Añadir nuevo evento:',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _eventController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Escribe tu evento',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Color(0xFF3A3A5A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            if (_eventController.text.isEmpty) return;

            final selectedDate = DateTime.utc(
              _selectedDay!.year,
              _selectedDay!.month,
              _selectedDay!.day,
            );

            setState(() {
              if (_events[selectedDate] != null) {
                _events[selectedDate]!.add(_eventController.text);
              } else {
                _events[selectedDate] = [_eventController.text];
              }
              _eventController.clear();
            });
          },
          child: Text(
            'Agregar evento',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),

        SizedBox(height: 20),

        // Mostrar eventos del día seleccionado
        Text(
          'Eventos del día:',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ..._getEventsForDay(_selectedDay ?? _focusedDay).map((event) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "🎯 $event",
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteEvent(
                        DateTime.utc(
                          _selectedDay!.year,
                          _selectedDay!.month,
                          _selectedDay!.day,
                        ),
                        event,
                      );
                    },
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
