import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStorageService {
  Future<String> uploadPDF(File file, String userId) async {
    String fileName = file.path.split('/').last;
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('pdfs/$userId/$fileName');

    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<List<String>> fetchUserPDFs(String userId) async {
    try {
      List<String> pdfFiles = [];
      // Get a reference to the folder specific to the user
      var listResult = await FirebaseStorage.instance.ref('pdfs/$userId').listAll();

      // Iterate through the files in the user's folder
      listResult.items.forEach((Reference ref) {
        pdfFiles.add(ref.fullPath);
        // You might modify this to get only file names or relevant details
      });

      return pdfFiles;
    } catch (e) {
      print('Error fetching user PDFs: $e');
      return [];
    }
  }
  Future<void> deleteAppointment(String username, String doctor, String date) async {
    String combined=doctor+'_'+date;
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(username)
          .collection(username)
          .doc(combined)
          .delete();
    } catch (e) {
      throw ('Error deleting appointment: $e');
    }
  }

}
