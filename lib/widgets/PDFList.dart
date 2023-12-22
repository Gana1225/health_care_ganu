import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:healthcare/widgets/username.dart';

Future<String> fetchDataUrlFromFirestore(String username, String filename) async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('pdfs')
        .doc(username)
        .collection(username)
        .where('name', isEqualTo: filename)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var fieldValue = snapshot.docs.first.data()['url'];
      print('Field Value: $fieldValue');
      return fieldValue;
    } else {
      return ''; // Return empty string or handle the case when no document is found
    }
  } catch (e) {
    print('Error fetching data from Firestore: $e');
    return ''; // Return empty string or handle error cases
  }
}


class PDFViewerScreen extends StatefulWidget {
  final String pdfUrl; // URL or path to the PDF file

  const PDFViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  PDFDocument? document;
  late String username;
  late String filename;

  @override
  void initState() {
    super.initState();
    username = widget.pdfUrl.split('/')[1];
    filename = widget.pdfUrl.split('/').last;// Extract username from pdfUrl
    initializePdf();
  }

  void initializePdf() async {
    String pdfUrl = await fetchDataUrlFromFirestore(username,filename);
    if (pdfUrl.isNotEmpty) {
      document = await PDFDocument.fromURL(pdfUrl);
      setState(() {});
    } else {
      // Handle the case when pdfUrl is empty or when data retrieval fails
      print('PDF URL is empty or retrieval failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: document == null
            ? CircularProgressIndicator()
            : PDFViewer(document: document!),
      ),
    );
  }
}
