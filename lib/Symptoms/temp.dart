import 'package:flutter/material.dart';

class TemperaturePrecautionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Precautions'),
      ),
      body: PrecautionsList(),
    );
  }
}

class PrecautionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Precautions:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _precautionItem(
            'Rest and Hydrate:',
            'Drink plenty of fluids and get adequate rest.',
          ),
          _precautionItem(
            'Monitor Temperature:',
            'Regularly check your body temperature.',
          ),
          _precautionItem(
            'Medication:',
            'Take prescribed medications as directed by the doctor.',
          ),
          _precautionItem(
            'Seek Medical Help:',
            'If the temperature persists or worsens, consult a doctor.',
          ),
        ],
      ),
    );
  }

  Widget _precautionItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
