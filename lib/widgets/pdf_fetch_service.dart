import 'package:firebase_storage/firebase_storage.dart';

class PDFFetchService {
  Future<List<String>> fetchPDFFiles() async {
    List<String> pdfFileUrls = [];
    try {
      ListResult result = await FirebaseStorage.instance.ref().child('pdfs').listAll();
      pdfFileUrls = result.items.map((Reference ref) => ref.fullPath).toList();
    } catch (e) {
      print('Error fetching PDF files: $e');
    }
    return pdfFileUrls;
  }
}
