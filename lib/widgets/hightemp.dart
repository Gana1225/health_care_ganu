import 'package:flutter/material.dart';


class HighTemperaturePrecautions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Set to false to remove the debug tag
      home: Scaffold(
        appBar: AppBar(

          title: Text('High Temperature Precautions'),
            backgroundColor: Color(0xFF7165D6)
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                "images/doctors.png",
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: HighTemperatureScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HighTemperatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Precautions for High Temperature:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 40),
        _buildPrecautionText('1. Drink plenty of fluids to stay hydrated.'),
        _buildPrecautionText('2. Stay indoors in a cool or air-conditioned place.'),
        _buildPrecautionText('3. Wear lightweight and light-colored clothing.'),
        _buildPrecautionText('4. Avoid strenuous activities during peak heat hours.'),
        _buildPrecautionText('5. Take cool showers or baths to lower body temperature.'),
        _buildPrecautionText('6. Keep curtains and blinds closed during the hottest part of the day.'),
        _buildPrecautionText('7. Check on elderly neighbors and those at higher risk regularly.'),
        // Add more precautions as needed
      ],
    );
  }

  Widget _buildPrecautionText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}