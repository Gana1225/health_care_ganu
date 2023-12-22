import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  Future<String> uploadPDFFile(File file, String fileName) async {
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('pdfs/$fileName');

    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
  Future<List<String>> fetchPDFFiles() async {
    ListResult result = await FirebaseStorage.instance.ref().child('pdfs').listAll();

    List<String> pdfFileUrls = result.items.map((Reference ref) {
      return ref.fullPath;
    }).toList();

    return pdfFileUrls;
  }
}
