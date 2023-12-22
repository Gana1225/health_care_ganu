import 'dart:io';
import 'package:healthcare/widgets/hightemp.dart';
import 'package:healthcare/widgets/snuggle.dart';
import 'package:healthcare/widgets/fever.dart';
import 'package:healthcare/widgets/cold.dart';
import 'package:healthcare/widgets/cough.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthcare/screens/addschedule.dart';
import 'package:healthcare/screens/newhome.dart';
import 'package:healthcare/screens/newschedule.dart';
import 'package:healthcare/screens/nsettings_screen.dart';
import 'package:healthcare/Symptoms/temp.dart';
import 'package:healthcare/widgets/hero.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:healthcare/widgets/username.dart';
// import 'package:healthcare/widgets/firebase_storage_service.dart';
import 'package:healthcare/widgets/firebase_storage_services.dart';
import 'package:healthcare/widgets/file_picker_service.dart';
import 'package:healthcare/widgets/pdf_fetch_service.dart';
import 'package:healthcare/widgets/PDFList.dart';
// import 'package:healthcare/screens/messages_screen.dart';
// import 'package:healthcare/widgets/navbar_roots.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:healthcare/widgets/phone.dart';
// import 'package:healthcare/screens/appointment_screen.dart';
// import 'package:healthcare/screens/schedule_screen.dart';

class newnewPage extends StatelessWidget {
  List symptoms = [
    "Temperature",
    "Snuffle",
    "Fever",
    "Cough",
    "Cold",
  ];

  List imgs = [
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];

  List names1=[
    "Dr. Kavya",
    "Dr. Lisa",
    "Dr. Mohan",
    "Dr. Hari",
  ];

  List specification=[
    "Cardiologist",
    "Therapist",
    "Neurologist",
    "Psychiatrist"
  ];

  Future<String?> getUsernameFromFirestore(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        return userSnapshot.data()?['username'];
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching username: $e");
      return null;
    }
  }

  final FilePickerService _filePickerService = FilePickerService();
  final FirebaseStorageService _firebaseStorageService = FirebaseStorageService();

  Future<void> _uploadFile(BuildContext context,String username) async {
    String? filePath = await _filePickerService.pickPDFFile();

    if (filePath != null) {
      File file = File(filePath);
      String fileName = filePath.split('/').last; // Extract the file name

      try {
        String downloadURL =
        await _firebaseStorageService.uploadPDF(file, username);

        // Handle the uploaded file URL as needed (e.g., save to database)
        print('File uploaded. URL: $downloadURL');
      } catch (e) {
        print('Error uploading file: $e');
        // Handle the error
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        fetchUsername(context),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty || snapshot.data!.contains(null)) {
          return Scaffold(
            body: Center(child: Text('No data available')),
          );
        } else {
          String username = snapshot.data![0];
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hello $username",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailScreen(),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'avatarTag',
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage("images/R.png"),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppointmentForm(),
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xFF7165D6),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xFF7165D6),
                                      size: 35,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    "Clinic Visit",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Make an appointment",
                                    style: TextStyle(
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),),
                        Material(
                          child: InkWell(
                            onTap: () {
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async{
                                      // print(await canLaunchUrl(phoneNumber));
                                    },
                                    child: Icon(
                                      Icons.home_filled,
                                      color: Color(0xFF7165D6),
                                      size: 35,
                                    ),
                                  ),

                                  SizedBox(height: 30),
                                  Text(
                                    "Home Visit",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Call the doctor home",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "What are your symptoms?",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: symptoms.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (symptoms[index] == "Temperature") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HighTemperaturePrecautions(),
                                  ),
                                );
                              }
                              else if(symptoms[index] == "Snuffle"){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SnufflePrecautions(),
                                  ),
                                );
                              }
                              else if(symptoms[index] == "Fever"){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FeverPrecautions(),
                                  ),
                                );
                              }
                              else if(symptoms[index] == "Cough"){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CoughPrecautions(),
                                  ),
                                );
                              }
                              else if(symptoms[index] == "Cold"){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ColdPrecautions(),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              decoration: BoxDecoration(
                                color: Color(0xFFF4F6FA),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  symptoms[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Your Documents",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7, // Example height
                      // child: ListView.builder(
                      //   itemCount: pdfFiles.length,
                      //   itemBuilder: (context, index) {
                      //     return ListTile(
                      //       title: Text(pdfFiles[index]),
                      //       onTap: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(builder: (context) => PDFList(pdfUrl: pdfFiles[index])),
                      //         );
                      //       },
                      //     );
                      //   },
                      // ),
                    ),

                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await _uploadFile(context, username);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Icon(Icons.add),
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
              currentIndex: 0,
              selectedItemColor: Colors.blue,
              onTap: (index) {
                // Handle navigation based on index

                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NScheduleScreen()),
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
      },
    );
  }

  Future<String?> fetchUsername(BuildContext context) async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      String? fetchedUsername = await getUsernameFromFirestore(userId);
      if (fetchedUsername != null) {
        Provider.of<UsernameProvider>(context, listen: false)
            .setUsername(fetchedUsername);
      }
      return fetchedUsername;
    }
    return null;
  }
}