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
    String imageUrl = _getMonthImage(month); // Obtener la imagen de fondo

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Margen entre meses
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(imageUrl), // Cargar imagen desde URL
          fit: BoxFit.cover, // Ajustar la imagen al tamaño del contenedor
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3), // Darle un efecto oscurecido para resaltar el texto
            BlendMode.darken,
          ),
        ),
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

  // Obtener la imagen para cada mes
  String _getMonthImage(int month) {
    const monthImages = [
      'https://img.freepik.com/free-photo/anime-moon-landscape_23-2151645914.jpg?size=626&ext=jpg&ga=GA1.1.1607071139.1716267537&semt=ais_hybrid',   // Imagen para Enero
      'https://img.freepik.com/free-photo/anime-moon-landscape_23-2151645909.jpg?t=st=1727321882~exp=1727325482~hmac=f366880494b2f2353bfd22237bd8c2d05a3ace59477f7457f33da709ba0222f6&w=1380',  // Imagen para Febrero
      'https://img.freepik.com/free-photo/illustration-anime-city_23-2151779628.jpg?size=626&ext=jpg&ga=GA1.1.1607071139.1716267537&semt=ais_hybrid',     // Imagen para Marzo
      'https://img.freepik.com/free-photo/anime-car-city_23-2151710993.jpg?size=626&ext=jpg&ga=GA1.2.1607071139.1716267537&semt=ais_hybrid',     // Imagen para Abril
      'https://img.freepik.com/free-photo/8-bit-graphics-pixels-scene-with-person-bench-sunset_23-2151120903.jpg?size=626&ext=jpg&ga=GA1.1.1607071139.1716267537&semt=ais_hybrid',       // Imagen para Mayo
      'https://img.freepik.com/free-photo/anime-style-cozy-home-interior-with-furnishings_23-2151176392.jpg?size=626&ext=jpg&ga=GA1.1.1607071139.1716267537&semt=ais_hybrid',      // Imagen para Junio
      'https://img.freepik.com/free-photo/digital-art-style-scene-with-people-playing-chess_23-2151499402.jpg?size=626&ext=jpg&ga=GA1.1.1607071139.1716267537&semt=ais_hybrid',      // Imagen para Julio
      'https://img.freepik.com/free-photo/illustration-anime-city_23-2151779607.jpg?size=626&ext=jpg&ga=GA1.1.1607071139.1716267537&semt=ais_hybrid',    // Imagen para Agosto
      'https://img.freepik.com/free-vector/gradient-lo-fi-illustrations_52683-82981.jpg?size=626&ext=jpg&ga=GA1.1.1607071139.1716267537&semt=ais_hybrid', // Imagen para Septiembre
      'https://img.freepik.com/free-photo/illustration-rain-futuristic-city_23-2151406603.jpg?size=626&ext=jpg&ga=GA1.1.1607071139.1716267537&semt=ais_hybrid',   // Imagen para Octubre
      'https://img.freepik.com/free-photo/illustration-anime-city_23-2151779742.jpg?size=626&ext=jpg&ga=GA1.1.1607071139.1716267537&semt=ais_hybrid',  // Imagen para Noviembre
      'https://img.freepik.com/free-photo/aesthetic-anime-character-gaming_23-2151560681.jpg?size=626&ext=jpg&ga=GA1.2.1607071139.1716267537&semt=ais_hybrid',  // Imagen para Diciembre
    ];
    return monthImages[month - 1]; // Restar 1 porque los índices comienzan en 0
  }
}
