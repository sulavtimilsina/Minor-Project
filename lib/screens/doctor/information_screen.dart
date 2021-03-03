import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helloflutter/components/rounded_button.dart';
import 'package:helloflutter/constants.dart';
import 'package:helloflutter/screens/doctor/tabs.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:helloflutter/models/speciality.dart';
import 'package:helloflutter/data/data.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {

  //Completer<GoogleMapController> _mapController = Completer();
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> genderOptions = ["Male" ,"Female" ,"Others"];
  List<String> bloodGroup  = ["AB+", "AB-" ,"O+", "O-" ,"A+" ,"A-" ,"B+" ,"B-"];
  List<Speciality> specialities;
  String dropdownValue = 'Speciality';
  ProgressDialog pr;
  File _image;
  String img ="https://image.freepik.com/free-vector/doctor-icon-avatar-white_136162-58.jpg";
  String _gender ,_bloodGroup ,_speciality;
  final _name = TextEditingController();
  final _date =TextEditingController();
  final _address =TextEditingController();
  final _about =TextEditingController();
  final _contact =TextEditingController();
  final _experience = TextEditingController();
  final _nmc = TextEditingController();
  final _eduction = TextEditingController();

  @override
  void initState() {
    super.initState();
    specialities=getSpeciality();
    //_getLocation();
  }

  @override
  Widget build(BuildContext context) {
    //============================================= loading dialoge
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);



    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profile'),
        actions: [Icon(FontAwesomeIcons.bell)],
      ),
      body: SafeArea(
        child:ListView(
          scrollDirection:Axis.vertical ,
          children: <Widget>[
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: _image == null
                              ? NetworkImage(
                              'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                              : FileImage(_image),
                        )),
                  ),
                  InkWell(
                    onTap: _onAlertPress,
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            color: Colors.black),
                        margin: EdgeInsets.only(left: 70, top: 70),
                        child: Icon(
                          Icons.photo_camera,
                          size: 25,
                          color: Colors.white,
                        ),
                    ),
                  ),

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height*7/8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),),
                color: Colors.white,
              ),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                      ),
                    ],
                  ),
                  FormBuilder(
                    key: _formKey,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        FormBuilderTextField(
                          autovalidateMode:AutovalidateMode.onUserInteraction ,
                          name: 'name',
                          controller: _name,
                          decoration: kTextFieldDecoration.copyWith(hintText: "Enter your name" ,labelText: "Full Name*"),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.max(context, 50),
                          ]),
                          keyboardType: TextInputType.text,
                        ),SizedBox(height: 10,),
                        FormBuilderTextField(
                          autovalidateMode:AutovalidateMode.onUserInteraction ,
                          name: 'contact',
                          controller: _contact,
                          decoration: kTextFieldDecoration.copyWith(hintText: "contact" ,labelText: "Contact*"),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 9999999999),
                          ]),
                          keyboardType: TextInputType.number,
                        ),SizedBox(height: 10,),
                        FormBuilderTextField(
                          autovalidateMode:AutovalidateMode.onUserInteraction ,

                          name: 'nmc',
                          controller: _nmc,
                          decoration: kTextFieldDecoration.copyWith(hintText: "nmc number" ,labelText: "nmc number*"),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 9999),
                          ]),
                          keyboardType: TextInputType.number,
                        ),SizedBox(height: 10,),
                        FormBuilderTextField(

                          autovalidateMode:AutovalidateMode.onUserInteraction ,
                          name: 'experience',
                          controller: _experience,
                          decoration: kTextFieldDecoration.copyWith(hintText: "Experience year" ,labelText: "Experience year*"),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 50),
                          ]),
                          keyboardType: TextInputType.number,
                        ),SizedBox(height: 10,),
                        FormBuilderTextField(
                          autovalidateMode:AutovalidateMode.onUserInteraction ,
                          name: 'eduction',
                          controller: _eduction,
                          decoration: kTextFieldDecoration.copyWith(hintText: "Enter your education" ,labelText: "Education*"),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.max(context, 50),
                          ]),
                          keyboardType: TextInputType.text,
                        ),SizedBox(height: 10,),
                        TextFormField(
                          readOnly: true,
                          validator: (value){
                            if(value.isEmpty) return "Cannot be empty";
                            return null;
                          },
                          controller: _date,
                          textAlign: TextAlign.left,
                          onTap: () async {
                            var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            _date.text = date.toString().substring(0, 10);
                          },
                          decoration:
                          kTextFieldDecoration.copyWith(hintText: "Select your DOB*" ,labelText: "DOB*"),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: FormBuilderDropdown(
                                name:"gender" ,
                                onChanged: (String value){setState(() {
                                  _gender=value;
                                });},
                                autovalidateMode:AutovalidateMode.onUserInteraction ,
                                decoration: kTextFieldDecoration.copyWith(labelText: "Sex*" ,hintText: "Select your sex",),
                                items: genderOptions
                                    .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text("$gender"),
                                )).toList(),
                                allowClear: true,
                                validator: FormBuilderValidators.required(context),
                              ),
                            ),SizedBox(width: 10,),
                            Expanded(
                              child: FormBuilderDropdown(
                                name:"blood" ,
                                onChanged: (String value){setState(() {
                                  _bloodGroup=value;
                                });},
                                autovalidateMode:AutovalidateMode.onUserInteraction ,
                                decoration: kTextFieldDecoration.copyWith(labelText: "Blood Group*" ,hintText: "Select your blood group",),
                                items: bloodGroup
                                    .map((blood) => DropdownMenuItem(
                                  value:blood,
                                  child: Text("$blood"),
                                )).toList(),
                                allowClear: true,
                                validator: FormBuilderValidators.required(context),
                              ),
                            ),
                          ],
                        ),SizedBox(height: 10,),
                        FormBuilderDropdown(
                          name:"speciality" ,
                          onChanged: (value){setState(() {
                            _speciality=value;
                            print(_speciality);
                          });},
                          autovalidateMode:AutovalidateMode.onUserInteraction ,
                          decoration: kTextFieldDecoration.copyWith(labelText: "Speciality*" ,hintText: "Select your speciality",),
                          items: specialities
                              .map((speciality) => DropdownMenuItem(
                            value: speciality.speciality,
                            child: Text("${speciality.speciality}"),
                          )).toList(),
                          allowClear: true,
                          validator: FormBuilderValidators.required(context),
                        ),SizedBox(height: 10,),
                        FormBuilderTextField(
                          autovalidateMode:AutovalidateMode.onUserInteraction ,
                          name: 'address',
                          readOnly: false,
                          controller: _address,
                          decoration: kTextFieldDecoration.copyWith(hintText: "Enter your address" ,labelText: "Address*"),
                          validator: FormBuilderValidators.required(context),
                          keyboardType: TextInputType.text,
                          // onTap: () async  {
                          //   Position position  = await _getLocation();
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) =>  Container(
                          //           height:MediaQuery.of(context).size.height,
                          //           width: MediaQuery.of(context).size.width,
                          //           child: GoogleMap(
                          //             mapType: MapType.normal,
                          //             myLocationEnabled: true,
                          //             initialCameraPosition:CameraPosition(target: LatLng(position.latitude, position.longitude) ,zoom:15 ),
                          //             onMapCreated: (GoogleMapController controller) {
                          //               _mapController.complete( controller);
                          //             },
                          //             markers: {
                          //               Marker(
                          //                   draggable: true,
                          //                   markerId: MarkerId('Marker'),
                          //                   position:   LatLng(position.latitude, position.longitude) ,
                          //                   onDragEnd: ((newPosition) async {
                          //                     final coordinates = new Coordinates(newPosition.latitude, newPosition.longitude);
                          //                     final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
                          //                     final first = addresses.first;
                          //                     print(first.addressLine);
                          //                     _address.text = first.addressLine.toString();
                          //                     Navigator.pop(context);
                          //                   }))
                          //
                          //
                          //             },
                          //
                          //           ),
                          //         ),
                          //       )
                          //   );
                          //
                          // },
                        ),SizedBox(height: 10,),
                        FormBuilderTextField(
                          autovalidateMode:AutovalidateMode.onUserInteraction ,
                          name: 'about',
                          maxLines: 6,
                          controller: _about,
                          decoration: kTextFieldDecoration.copyWith(hintText: "Enter about yourself" ,labelText: "About*"),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.max(context, 150),
                          ]),
                          keyboardType: TextInputType.text,
                        ),SizedBox(height: 10,),
                        Center(
                          child: RoundedButton(
                            onPressed:(){
                              _startUploading();
                            },
                            colour: Colors.green,
                            title: "Submit",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }

  //=======================Funcions Area

  //========================= Gallery / Camera AlerBox
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
                isDefaultAction: false,
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

  // ================================= Image from camera
  Future getCameraImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      Navigator.pop(context);
    });
  }

  //============================== Image from gallery
  Future getGalleryImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      Navigator.pop(context);
    });
  }

  //============================================================= API Area to upload image

  Future<Map<String, dynamic>> _uploadImage(File file) async {
    final storage = new FlutterSecureStorage();
    String value = await storage.read(key: "x-auth-token");
    var filename = file.path;
    var url = "http://10.0.2.2:3000/doctorRouter";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(http.MultipartFile('profileImage',
        File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
        filename: filename.split('/').last));
    request.fields['fullname'] = _name.text;
    request.fields['dob'] = _date.text;
    request.fields['sex'] = _gender;
    request.fields['blood'] = _bloodGroup;
    request.fields['speciality'] = _speciality;
    request.fields['address'] = _address.text;
    request.fields['about'] = _about.text;
    request.fields['nmc'] = _nmc.text;
    request.fields['experience'] = _experience.text;
    request.fields['contact'] = _contact.text;
    request.fields['eduction'] = _eduction.text;
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
    if (_name!=null || _image!=null) {
      final Map<String, dynamic> response = await _uploadImage(_image);
      print(response);


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
                        MaterialPageRoute(builder: (context) => DoctorTabsPage()));
                  });
                },
              ),
            ],
          );
        });
  }
}



// Future<Position> _getLocation() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Location permissions are permantly denied, we cannot request permissions.');
//   }

//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission != LocationPermission.whileInUse &&
//         permission != LocationPermission.always) {
//       return Future.error(
//           'Location permissions are denied (actual value: $permission).');
//     }
//   }

//   return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
// }



