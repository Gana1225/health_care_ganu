import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/screens/login_screen.dart';
import 'package:healthcare/widgets/reusable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passToggle = true;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();

  final userCollection = FirebaseFirestore.instance.collection('users');
  Future<void> _addUserToFirestore(User? user) async {
    // Reference to Firestore collection
    final userCollection = FirebaseFirestore.instance.collection('users');
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    // Adding user details to Firestore
    await userCollection.doc(user?.uid).set({
      'username': _userNameTextController.text,
      'email': _emailTextController.text,
      'phone': _phoneTextController.text,
      // Add other user details as needed
    });
    await _firebaseFirestore.collection('pdfs').doc(_userNameTextController.text).collection(_userNameTextController.text).add({
      "name": _userNameTextController.text,
      "url": _userNameTextController.text,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  "images/doctors.png",
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: reusableTextField("Enter User Name", Icons.person, false,
                    _userNameTextController),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: reusablemailTextField("Enter Email", Icons.email, false,
                    _emailTextController),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: reusableTextField("Enter phone Number", Icons.phone, false,
                    _phoneTextController),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: reusable_passTextField("Enter Password", Icons.lock, false,
                    _passwordTextController),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(12),
                child: firebaseUIButton(context, "Sign Up", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                      .then((value) {
                    print("Created New Account");
                    _addUserToFirestore(value.user);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => loginScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => loginScreen(),
                          ));
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7165D6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}