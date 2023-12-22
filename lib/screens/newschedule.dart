import 'package:flutter/material.dart';
import 'package:healthcare/screens/newhome.dart';
import 'package:healthcare/screens/newup.dart';
import 'package:healthcare/screens/nsettings_screen.dart';
import 'package:provider/provider.dart';
import 'package:healthcare/widgets/username.dart';
import 'package:healthcare/widgets/firebase_storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NScheduleScreen extends StatefulWidget {
  @override
  _NScheduleScreenState createState() => _NScheduleScreenState();
}

class _NScheduleScreenState extends State<NScheduleScreen> {

  final FirebaseStorageService _firebaseStorageService = FirebaseStorageService();
  Future<void> _deletedoc(BuildContext context,String username,date, String time) async {
    try{
      await _firebaseStorageService.deleteAppointment(username,date,time);
      print('File deleted');
    } catch (e) {
      print('Error deleting file: $e');
      // Handle the error
    }
  }
  @override
  Widget build(BuildContext context) {
    final username = Provider.of<UsernameProvider>(context, listen: false).username;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Schedule",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('appointments')
                    .doc(username)
                    .collection(username)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text('No appointments found.'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.8, // Set a specific height
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var appointment = snapshot.data!.docs[index];
                          // You can customize how you display each appointment document here
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              appointment['doctorName'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(appointment['specialization']),
                                            trailing: CircleAvatar(
                                              radius: 25,
                                              backgroundImage: AssetImage("images/doctor1.jpg"),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Divider(
                                              // color: Colors.black,
                                              thickness: 1,
                                              height: 20,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.black54,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    appointment['date'],
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time_filled,
                                                    color: Colors.black54,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    appointment['time'],
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Confirmed",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _deletedoc(context, username, appointment['doctorName'],appointment['date']);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => NScheduleScreen(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 150,
                                                  padding: EdgeInsets.symmetric(vertical: 12),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF4F6FA),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _deletedoc(context, username, appointment['doctorName'],appointment['date']);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => NScheduleScreen(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 150,
                                                  padding: EdgeInsets.symmetric(vertical: 12),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF7165D6),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Mark Complete",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ]
                            ),
                          );
                        },
                      ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // Handle navigation based on index
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          }
          // Add more navigation based on index if needed
        },
      ),
    );
  }
}
