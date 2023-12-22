import 'package:flutter/material.dart';


class ColdPrecautions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cold Precautions'),
          backgroundColor: Color(0xFF7165D6),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                "images/doctors.png", // Replace with your cold image asset
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: ColdScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Precautions for Cold:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 40),
        _buildPrecautionText('1. Rest and get plenty of sleep.'),
        _buildPrecautionText('2. Stay hydrated by drinking fluids.'),
        _buildPrecautionText('3. Use saline nasal sprays to relieve congestion.'),
        _buildPrecautionText('4. Use a humidifier to add moisture to the air.'),
        _buildPrecautionText('5. Gargle with warm salt water to soothe a sore throat.'),
        _buildPrecautionText('6. Take over-the-counter medications for relief.'),
        _buildPrecautionText('7. Wash your hands frequently to prevent spreading germs.'),
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
