import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:helloflutter/screens/patient/patient_tabs.dart';

class PdfPage extends StatefulWidget {
  final String url;
  PdfPage({this.url});
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  PDFDocument document;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    print(widget.url);
    document = await PDFDocument.fromURL('http://www.africau.edu/images/default/sample.pdf');

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
        leading: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientTabsPage()));
          },
          child: Icon(Icons.backspace)),
      ),
      body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: document)),
    );
  }
}
