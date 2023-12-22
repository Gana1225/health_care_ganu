import 'package:flutter/material.dart';


class CoughPrecautions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cough Precautions'),
          backgroundColor: Color(0xFF7165D6),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                "images/doctors.png", // Replace with your cough image asset
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CoughScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoughScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Precautions for Cough:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 40),
        _buildPrecautionText('1. Stay hydrated by drinking plenty of fluids.'),
        _buildPrecautionText('2. Use cough drops or lozenges to soothe throat irritation.'),
        _buildPrecautionText('3. Take steam inhalation to ease cough.'),
        _buildPrecautionText('4. Avoid exposure to smoke and allergens.'),
        _buildPrecautionText('5. Use a humidifier to add moisture to the air.'),
        _buildPrecautionText('6. Follow proper cough etiquette by covering your mouth and nose.'),
        _buildPrecautionText('7. Seek medical advice if the cough persists or worsens.'),
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
