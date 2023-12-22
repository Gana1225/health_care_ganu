import 'package:flutter/material.dart';

class SnufflePrecautions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Snuffle Precautions'),
          backgroundColor: Color(0xFF7165D6),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                "images/doctors.png", // Replace with your snuffle image asset
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SnuffleScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SnuffleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Precautions for Snuffle:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 40),
        _buildPrecautionText('1. Rest and get plenty of sleep.'),
        _buildPrecautionText('2. Stay hydrated by drinking fluids.'),
        _buildPrecautionText('3. Use a humidifier to moisten the air.'),
        _buildPrecautionText('4. Gargle with warm salt water to soothe a sore throat.'),
        _buildPrecautionText('5. Use over-the-counter medications as directed.'),
        _buildPrecautionText('6. Avoid smoke and other irritants.'),
        _buildPrecautionText('7. Practice good hand hygiene to prevent the spread of germs.'),
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
