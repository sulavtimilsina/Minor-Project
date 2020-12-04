import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/doctor_model.dart';

///THIS IS FOR INPUT FIELDS IN REGSTRATION AND SIGNUP SCREEN
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);


///I FORGOT WHY I CREATED THIS
const kHeadingTextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);


///THIS IS A TEST DATA FOR CHECKING THE UI
List<DoctorInfo> doctorInfo = [
  DoctorInfo(
    image:
    "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/10b3cb41-186f-499b-a824-e369f838b46b/d14pin8-a53f8ce9-49db-4d88-ba03-5813128779b5.jpg/v1/fill/w_719,h_1111,q_75,strp/dr__manhattan_watchmen_series_by_thuddleston.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvZi8xMGIzY2I0MS0xODZmLTQ5OWItYTgyNC1lMzY5ZjgzOGI0NmIvZDE0cGluOC1hNTNmOGNlOS00OWRiLTRkODgtYmEwMy01ODEzMTI4Nzc5YjUuanBnIiwid2lkdGgiOiI8PTcxOSIsImhlaWdodCI6Ijw9MTExMSJ9XV19.b_Qs8ta95vIP8QUOEXF9poRApWNBwji0LKHNMmVW7vE",
    about:
    "Jon gradually becomes a pawn of the U.S. government, which gives him the code name Doctor Manhattan—a reference to the Manhattan Project—and a costume which he begrudgingly accepts. Doctor Manhattan chooses as his emblem a representation of a hydrogen atom, whose simplicity he declares to be something that kindles his respect; accordingly, he painlessly burns the mark into his forehead. This preference for material mechanisms marks the beginning of his declining humanity, which is progressively mirrored by his gradual shedding of the uniform; by the end of the 1970s, he refuses to wear anything at all except during mandatory public appearances. ",
    certifications: "5",
    experience: "50",
    address: "Mars",
    name: "Dr Manhattan",
    speciality: "Everything",
    workingHours: "Sun - Fri 09:00 - 05:00",
    nmcNumber: "1013232",
    education: ["Bachelors from IOM Nepal" ,"Currently working at Bir Hospital Nepal"],
  ),
];