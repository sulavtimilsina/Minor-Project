import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helloflutter/screens/patient/doctor_script.dart';
import 'package:http/http.dart' as http;

Future<String> shopSpeciality(List<int> list) async {
  String body = jsonEncode(list);
  //print(body);
  //var body = json.encode(items);
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "x-auth-token");
  final http.Response response =
      await http.post('http://10.0.2.2:3000/speciality',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: value
          },
          body: body);
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    final message = jsonDecode(response.body);
    print(message.message);
    throw Exception(message.message);
  }
}

class FindDoctor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChipDemoState();
}

class _ChipDemoState extends State<FindDoctor> {
  Future<String> speciality;
  GlobalKey<ScaffoldState> _key;
  List<CompanyWidget> _companies;
  List<int> _filters;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<ScaffoldState>();
    _filters = <int>[];
    _companies = <CompanyWidget>[
      CompanyWidget(' itching '),
      CompanyWidget(' skin_rash '),
      CompanyWidget(' nodal_skin_eruptions '),
      CompanyWidget(' continuous_sneezing '),
      CompanyWidget(' shivering '),
      CompanyWidget(' chills '),
      CompanyWidget(' joint_pain '),
      CompanyWidget(' stomach_pain '),
      CompanyWidget(' acidity '),
      CompanyWidget(' ulcers_on_tongue '),
      CompanyWidget(' muscle_wasting '),
      CompanyWidget(' vomiting '),
      CompanyWidget(' burning_micturition '),
      CompanyWidget(' spotting_ urination '),
      CompanyWidget(' fatigue '),
      CompanyWidget(' weight_gain '),
      CompanyWidget(' anxiety '),
      CompanyWidget(' cold_hands_and_feets '),
      CompanyWidget(' mood_swings '),
      CompanyWidget(' weight_loss '),
      CompanyWidget(' restlessness '),
      CompanyWidget(' lethargy '),
      CompanyWidget(' patches_in_throat '),
      CompanyWidget(' irregular_sugar_level '),
      CompanyWidget(' cough '),
      CompanyWidget(' high_fever '),
      CompanyWidget(' sunken_eyes '),
      CompanyWidget(' breathlessness '),
      CompanyWidget(' sweating '),
      CompanyWidget(' dehydration '),
      CompanyWidget(' indigestion '),
      CompanyWidget(' headache '),
      CompanyWidget(' yellowish_skin '),
      CompanyWidget(' dark_urine '),
      CompanyWidget(' nausea '),
      CompanyWidget(' loss_of_appetite '),
      CompanyWidget(' pain_behind_the_eyes '),
      CompanyWidget(' back_pain '),
      CompanyWidget(' constipation '),
      CompanyWidget(' abdominal_pain '),
      CompanyWidget(' diarrhoea '),
      CompanyWidget(' mild_fever '),
      CompanyWidget(' yellow_urine '),
      CompanyWidget(' yellowing_of_eyes '),
      CompanyWidget(' acute_liver_failure '),
      CompanyWidget(' fluid_overload '),
      CompanyWidget(' swelling_of_stomach '),
      CompanyWidget(' swelled_lymph_nodes '),
      CompanyWidget(' malaise '),
      CompanyWidget(' blurred_and_distorted_vision '),
      CompanyWidget(' phlegm '),
      CompanyWidget(' throat_irritation '),
      CompanyWidget(' redness_of_eyes '),
      CompanyWidget(' sinus_pressure '),
      CompanyWidget(' runny_nose '),
      CompanyWidget(' congestion '),
      CompanyWidget(' chest_pain '),
      CompanyWidget(' weakness_in_limbs '),
      CompanyWidget(' fast_heart_rate '),
      CompanyWidget(' pain_during_bowel_movements '),
      CompanyWidget(' pain_in_anal_region '),
      CompanyWidget(' bloody_stool '),
      CompanyWidget(' irritation_in_anus '),
      CompanyWidget(' neck_pain '),
      CompanyWidget(' dizziness '),
      CompanyWidget(' cramps '),
      CompanyWidget(' bruising '),
      CompanyWidget(' obesity '),
      CompanyWidget(' swollen_legs '),
      CompanyWidget(' swollen_blood_vessels '),
      CompanyWidget(' puffy_face_and_eyes '),
      CompanyWidget(' enlarged_thyroid '),
      CompanyWidget(' brittle_nails '),
      CompanyWidget(' swollen_extremeties '),
      CompanyWidget(' excessive_hunger '),
      CompanyWidget(' extra_marital_contacts '),
      CompanyWidget(' drying_and_tingling_lips '),
      CompanyWidget(' slurred_speech '),
      CompanyWidget(' knee_pain '),
      CompanyWidget(' hip_joint_pain '),
      CompanyWidget(' muscle_weakness '),
      CompanyWidget(' stiff_neck '),
      CompanyWidget(' swelling_joints '),
      CompanyWidget(' movement_stiffness '),
      CompanyWidget(' spinning_movements '),
      CompanyWidget(' loss_of_balance '),
      CompanyWidget(' unsteadiness '),
      CompanyWidget(' weakness_of_one_body_side '),
      CompanyWidget(' loss_of_smell '),
      CompanyWidget(' bladder_discomfort '),
      CompanyWidget(' foul_smell_of urine '),
      CompanyWidget(' continuous_feel_of_urine '),
      CompanyWidget(' passage_of_gases '),
      CompanyWidget(' internal_itching '),
      CompanyWidget(' toxic_look_(typhos) '),
      CompanyWidget(' depression '),
      CompanyWidget(' irritability '),
      CompanyWidget(' muscle_pain '),
      CompanyWidget(' altered_sensorium '),
      CompanyWidget(' red_spots_over_body '),
      CompanyWidget(' belly_pain '),
      CompanyWidget(' abnormal_menstruation '),
      CompanyWidget(' dischromic _patches '),
      CompanyWidget(' watering_from_eyes '),
      CompanyWidget(' increased_appetite '),
      CompanyWidget(' polyuria '),
      CompanyWidget(' family_history '),
      CompanyWidget(' mucoid_sputum '),
      CompanyWidget(' rusty_sputum '),
      CompanyWidget(' lack_of_concentration '),
      CompanyWidget(' visual_disturbances '),
      CompanyWidget(' receiving_blood_transfusion '),
      CompanyWidget(' receiving_unsterile_injections '),
      CompanyWidget(' coma '),
      CompanyWidget(' stomach_bleeding '),
      CompanyWidget(' distention_of_abdomen '),
      CompanyWidget(' history_of_alcohol_consumption '),
      CompanyWidget(' fluid_overload '),
      CompanyWidget(' blood_in_sputum '),
      CompanyWidget(' prominent_veins_on_calf '),
      CompanyWidget(' palpitations '),
      CompanyWidget(' painful_walking '),
      CompanyWidget(' pus_filled_pimples '),
      CompanyWidget(' blackheads '),
      CompanyWidget(' scurring '),
      CompanyWidget(' skin_peeling '),
      CompanyWidget(' silver_like_dusting '),
      CompanyWidget(' small_dents_in_nails '),
      CompanyWidget(' inflammatory_nails '),
      CompanyWidget(' blister '),
      CompanyWidget(' red_sore_around_nose '),
      CompanyWidget(' yellow_crust_ooze '),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Select Symptoms"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () {
          setState(() {
            speciality = shopSpeciality(_filters);
          });
        },
      ),
      body: (speciality == null)
          ? SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Wrap(
                      children: companyPosition.toList(),
                    ),
                  ],
                ),
              ),
            )
          : FutureBuilder<String>(
              future: speciality,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Future.delayed(Duration.zero, () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorScript(
                                  speciality: snapshot.data,
                                )));
                  });
                  return Text(snapshot.data);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return CircularProgressIndicator();
              },
            ),
    );
  }

  Iterable<Widget> get companyPosition sync* {
    for (CompanyWidget company in _companies) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: FilterChip(
          backgroundColor: Colors.tealAccent[200],
          avatar: CircleAvatar(
            backgroundColor: Colors.cyan,
            child: Text(
              company.name[0].toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          label: Text(company.name
              //_companies.indexOf(company).toString(),
              ),
          selected: _filters.contains(_companies.indexOf(company)),
          selectedColor: Colors.purpleAccent,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(_companies.indexOf(company));
              } else {
                _filters.removeWhere((int name) {
                  return name == _companies.indexOf(company);
                });
              }
            });
          },
        ),
      );
    }
  }
}

class CompanyWidget {
  const CompanyWidget(this.name);
  final String name;
}
