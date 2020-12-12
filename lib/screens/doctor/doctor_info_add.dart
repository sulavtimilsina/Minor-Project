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
          body:Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                FormBuilder(

                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FormBuilderTextField(
                          autovalidateMode:AutovalidateMode.onUserInteraction ,
                          key: _formKey,
                          name: 'name*',
                          decoration: kTextFieldDecoration.copyWith(hintText: "Enter your name" ,labelText: "Full Name*"),
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.max(context, 50),
                          ]),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 10,),
                        FormBuilderDropdown(
                            name:"gender" ,
                            autovalidateMode:AutovalidateMode.onUserInteraction ,
                            decoration: kTextFieldDecoration.copyWith(labelText: "Gender*" ,hintText: "Select your gender",),
                            items: genderOptions
                                .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text("$gender"),
                            )).toList(),
                          allowClear: true,
                          validator: FormBuilderValidators.required(context),
                        ),
                        // GoogleMap(
                        //   mapType: MapType.hybrid,
                        //   initialCameraPosition: CameraPosition(
                        //     target: LatLng(40.688841, -74.044015),
                        //     zoom: 11,
                        //   ),
                        // )
                      ],
                    ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
