import 'package:flutter/material.dart';

void main() {
  runApp(const CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendario 2024',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Calendario 2024"),
          backgroundColor: Colors.blueAccent,
        ),
        body: const CalendarYear(),
      ),
    );
  }
}

class CalendarYear extends StatelessWidget {
  const CalendarYear({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(12, (index) => _buildMonth(index + 1)),
      ),
    );
  }

  // Construir un mes
  Widget _buildMonth(int month) {
    String monthName = _getMonthName(month);
    List<Widget> dayWidgets = _buildDaysInMonth(month);
    Color monthColor = _getMonthColor(month); // Obtener color del mes

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Margen entre meses
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8.0),
        color: monthColor, // Color de fondo del mes
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            monthName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          _buildWeekdays(), // Agregar los días de la semana
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: dayWidgets,
          ),
        ],
      ),
    );
  }

  // Agregar los días de la semana
  Widget _buildWeekdays() {
    const weekdays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekdays.map((day) {
        return Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }

  // Generar los días del mes
  List<Widget> _buildDaysInMonth(int month) {
    int daysInMonth = DateTime(2024, month + 1, 0).day; // Días del mes
    List<Widget> dayWidgets = [];

    // Rellenar los días del mes
    for (int day = 1; day <= daysInMonth; day++) {
      dayWidgets.add(
        Container(
          margin: const EdgeInsets.all(1.0), // Espacio entre los días
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.blueGrey.shade100, // Color de fondo de los días
          ),
          child: Text(
            day.toString(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black), // Tamaño del texto
          ),
        ),
      );
    }

    return dayWidgets;
  }

  // Obtener el nombre del mes
  String _getMonthName(int monthIndex) {
    const monthNames = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];
    return monthNames[monthIndex - 1]; // Restar 1 porque los índices comienzan en 0
  }

  // Obtener color para cada mes
  Color _getMonthColor(int month) {
    switch (month) {
      case 1:
        return Colors.redAccent; // Enero
      case 2:
        return Colors.pinkAccent; // Febrero
      case 3:
        return Colors.greenAccent; // Marzo
      case 4:
        return Colors.lightBlueAccent; // Abril
      case 5:
        return Colors.amberAccent; // Mayo
      case 6:
        return Colors.tealAccent; // Junio
      case 7:
        return Colors.deepOrangeAccent; // Julio
      case 8:
        return Colors.blue; // Agosto
      case 9:
        return Colors.purpleAccent; // Septiembre
      case 10:
        return Colors.indigoAccent; // Octubre
      case 11:
        return Colors.limeAccent; // Noviembre
      case 12:
        return Colors.cyanAccent; // Diciembre
      default:
        return Colors.white; // Color por defecto
    }
  }
}
