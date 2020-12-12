import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:helloflutter/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoctorInfoAdd extends StatefulWidget {
  @override
  _DoctorInfoAddState createState() => _DoctorInfoAddState();
}

class _DoctorInfoAddState extends State<DoctorInfoAdd> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> genderOptions = ["Male" ,"Female" ,"Others"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:
                        GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(40.688841, -74.044015),
                            zoom: 11,
                          ),
                        ),
                            )
    );
    //                   ],
    //                 ),
    //             ),
    //           ],
    //         ),
    //       ),
    //   ),
    // );
  }
}
