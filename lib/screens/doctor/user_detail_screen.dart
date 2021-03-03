import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/models/data_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future<List<Data>> getDatas(String patientId) async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final response = await http.get(
      'http://10.0.2.2:3000/userdata/showdata/$patientId',
      headers: <String, String>{
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

class UserDetails extends StatefulWidget {
  final String id;
  final String name;
  UserDetails({this.id, this.name});
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  Future<List<Data>> userData;
  File _image;
  Future<List<Data>> datas;
  @override
  void initState() {
    super.initState();
    userData = getDatas(widget.id);
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
    var url = "http://10.0.2.2:3000/prescription";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(http.MultipartFile('dataImage',
        File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
        filename: filename.split('/').last));
    request.fields['patientId'] = widget.id;
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
                  Navigator.pop(context);
                  // Future.delayed(Duration.zero, () {
                  //   Navigator.pushReplacement(context,
                  //       MaterialPageRoute(builder: (context) => MyData()));
                  // });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidht = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              _onAlertPress();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Prescribe',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                        "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE",

                        ///pass decoded json data picture
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: FutureBuilder<List<Data>>(
                future: userData,
                builder: (context, snapshot) {
                  return GridView.count(
                      childAspectRatio: itemHeight / itemWidht,
                      crossAxisCount: 2,
                      children: List.generate(
                        snapshot.data.length,
                        (index) {
                          //print(snapshot.data[index].imageUrl);
                          return Container(
                              //height: MediaQuery.of(context).size.height * 0.1,
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
          ],
        ),
      ),
    );
  }
}
