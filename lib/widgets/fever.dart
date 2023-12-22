import 'package:flutter/material.dart';


class FeverPrecautions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fever Precautions'),
          backgroundColor: Color(0xFF7165D6),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                "images/doctors.png", // Replace with your fever image asset
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: FeverScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Precautions for Fever:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 40),
        _buildPrecautionText('1. Rest and stay hydrated.'),
        _buildPrecautionText('2. Keep yourself cool by sponging with lukewarm water.'),
        _buildPrecautionText('3. Wear lightweight clothing.'),
        _buildPrecautionText('4. Take over-the-counter fever reducers as directed.'),
        _buildPrecautionText('5. Monitor fever regularly.'),
        _buildPrecautionText('6. Get medical attention if the fever persists or worsens.'),
        _buildPrecautionText('7. Isolate yourself to prevent spreading illness.'),
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
