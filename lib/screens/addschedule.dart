import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart'; // You might need this for username retrieval
import 'package:healthcare/screens/newschedule.dart';
import 'package:healthcare/screens/newup.dart';
import 'package:healthcare/widgets/username.dart';
class AppointmentForm extends StatelessWidget {
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  void _submitAppointment(BuildContext context) async {
    String username = Provider.of<UsernameProvider>(context, listen: false).username;
    String combinedDateTime = '${doctorNameController.text}_${dateController.text}';

    try {
      await FirebaseFirestore.instance.collection('appointments').doc(username).collection(username).doc(combinedDateTime).set({
        'doctorName': doctorNameController.text,
        'specialization': specializationController.text,
        'date': dateController.text,
        'time': timeController.text,
      });

      // Appointment successfully stored
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Appointment scheduled successfully')),
      );
    } catch (e) {
      // Handle any errors that occur during the operation
      print('Error creating appointment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error scheduling appointment')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String username = Provider.of<UsernameProvider>(context, listen: false).username;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                "images/doctors.png",
              ),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Appointment Form",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 24.0),
            TextFormField(
              controller: doctorNameController,
              decoration: InputDecoration(
                labelText: 'Doctor Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: specializationController,
              decoration: InputDecoration(
                labelText: "Doctor's Specialization",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    controller: timeController,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                _submitAppointment(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NScheduleScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF7165D6), // Set the button color
                minimumSize: Size(300, 48), // Set width and height
              ),
              child: Container(
                width: 300,
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

}
