import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthcare/widgets/username.dart';
class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String username = Provider.of<UsernameProvider>(context, listen: false).username;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centering vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Centering horizontally
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Hero(
                tag: 'avatarTag',
                child: Image.asset(
                  'images/R.png',
                  height: 200, // Adjust the height as needed
                  width: 200, // Adjust the width as needed
                ),
              ),
            ),
            SizedBox(height: 20), // Adding space between image and text
            Text(
              "$username",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
