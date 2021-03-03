import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/models/data_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

Future<List<Data>> getDatas() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http
      .get('http://10.0.2.2:3000/userdata/mydata', headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    HttpHeaders.authorizationHeader: value
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var tagObjsJson = jsonDecode(response.body) as List;
    List<Data> tagObjs =
        tagObjsJson.map((tagJson) => Data.fromJson(tagJson)).toList();

    return tagObjs;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class MyData extends StatefulWidget {
  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  // ignore: unused_field
  File _image;
  Future<List<Data>> datas;

  void initState() {
    super.initState();
    datas = getDatas();
  }

  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    // Image.asset(
                    //   'assets/images/gallery.png',
                    //   width: 50,
                    // ),
                    Text('Gallery'),
                  ],
                ),
                onPressed: getGalleryImage,
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    // Image.asset(
                    //   'assets/images/take_picture.png',
                    //   width: 50,
                    // ),
                    Text('Take Photo'),
                  ],
                ),
                onPressed: getCameraImage,
              ),
            ],
          );
        });
  }

  Future getCameraImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      print("This is image");
      //print(_image);
      Navigator.pop(context);
      _startUploading();
    });
  }

  Future getGalleryImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      Navigator.pop(context);
      _startUploading();
    });
  }

  Future<Map<String, dynamic>> _uploadImage(File file) async {
    final storage = new FlutterSecureStorage();
    String value = await storage.read(key: "x-auth-token");
    var filename = file.path;
    var url = "http://10.0.2.2:3000/userdata/mydata";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(http.MultipartFile('dataImage',
        File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
        filename: filename.split('/').last));
    request.headers["x-auth-token"] = value;

    try {
      final res = await request.send();
      final response = await http.Response.fromStream(res);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } catch (error) {
      print(error);
      return null;
    }
  }

  void _startUploading() async {
    if (_image != null) {
      final Map<String, dynamic> response = await _uploadImage(_image);
      print(response);

      // Check if any error occured
      if (response == null) {
        messageAllert('User details updated successfully', 'Success');
      }
    } else {
      messageAllert('Please Select a profile photo', 'Profile Photo');
    }
  }

  messageAllert(String msg, String ttl) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: Text(ttl),
            content: Text(msg),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Okay'),
                  ],
                ),
                onPressed: () {
                  Future.delayed(Duration.zero, () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyData()));
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5;
    final double itemWidht = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Data'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onAlertPress();
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: FutureBuilder<List<Data>>(
          future: datas,
          builder: (context, snapshot) {
            return GridView.count(
                childAspectRatio: itemHeight / itemWidht,
                crossAxisCount: 2,
                children: List.generate(
                  snapshot.data.length,
                  (index) {
                    print(snapshot.data[index].imageUrl);
                    return Container(
                        margin: EdgeInsets.all(10.0),
                        color: Colors.amber,
                        child: Image.network(
                          snapshot.data[index].imageUrl,
                          //'http://10.0.2.2:3000/images/${snapshot.data[index].imageUrl}',
                          fit: BoxFit.fill,
                        ));
                  },
                ));
          },
        ),
      ),
    );
  }
}
