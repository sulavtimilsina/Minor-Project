//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:helloflutter/screens/patient/patient_tabs.dart';

class PdfPage extends StatelessWidget {
  final String url;
  final String id;
  final String doctor;
  final String startTime;
  final String endTime;
  final String date;
  final String patient;
  PdfPage(
      {this.url,
      this.id,
      this.doctor,
      this.startTime,
      this.endTime,
      this.date,
      this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
        leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PatientTabsPage()));
            },
            child: Icon(Icons.backspace)),
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('schedule id : $id'),
                  Text('Doctor : $doctor'),
                  Text('Patient : $patient'),
                  Text('From : $startTime'),
                  Text('To : $endTime'),
                  Text('Date : $date'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Center(
//           child: _isLoading
//               ? Center(child: CircularProgressIndicator())
//               : PDFViewer(document: document))

//PDFDocument document;
//bool _isLoading = true;

// @override
// void initState() {
//   super.initState();
//   //loadDocument();
// }

// loadDocument() async {
//   print(widget.url);
//   document = await PDFDocument.fromURL(
//       'http://www.africau.edu/images/default/sample.pdf');

//   setState(() => _isLoading = false);
// }
