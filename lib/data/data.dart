import '../models/speciality.dart';
import 'package:flutter/cupertino.dart';

List<Speciality> getSpeciality() {
  List<Speciality> specialities = new List<Speciality>();
  Speciality specialityModel = new Speciality();

  specialityModel.noOfDoctors = 10;
  specialityModel.speciality = "Gastroenterologist";
  specialityModel.imgAssetPath = "assets/images/img1.png";
  specialityModel.backgroundColor = Color(0xffFBB97C);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 17;
  specialityModel.speciality = "Endocrinologist";
  specialityModel.imgAssetPath = "assets/images/img2.png";
  specialityModel.backgroundColor = Color(0xffF69383);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 15;
  specialityModel.speciality = "Allergist";
  specialityModel.imgAssetPath = "assets/images/img3.png";
  specialityModel.backgroundColor = Color(0xffEACBCB);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 10;
  specialityModel.speciality = "Orthopedic";
  specialityModel.imgAssetPath = "assets/images/img1.png";
  specialityModel.backgroundColor = Color(0xffFBB97C);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 17;
  specialityModel.speciality = "Infectious Disease Specialist";
  specialityModel.imgAssetPath = "assets/images/img2.png";
  specialityModel.backgroundColor = Color(0xffF69383);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 15;
  specialityModel.speciality = "Dermatologist";
  specialityModel.imgAssetPath = "assets/images/img3.png";
  specialityModel.backgroundColor = Color(0xffEACBCB);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 15;
  specialityModel.speciality = "Neurologist";
  specialityModel.imgAssetPath = "assets/images/img3.png";
  specialityModel.backgroundColor = Color(0xffEACBCB);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 15;
  specialityModel.speciality = "Cardiologist";
  specialityModel.imgAssetPath = "assets/images/img3.png";
  specialityModel.backgroundColor = Color(0xffEACBCB);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 15;
  specialityModel.speciality = "ENT Specialist";
  specialityModel.imgAssetPath = "assets/images/img3.png";
  specialityModel.backgroundColor = Color(0xffEACBCB);
  specialities.add(specialityModel);

  specialityModel = new Speciality();
  specialityModel.noOfDoctors = 15;
  specialityModel.speciality = "Pulmonologist";
  specialityModel.imgAssetPath = "assets/images/img3.png";
  specialityModel.backgroundColor = Color(0xffEACBCB);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 15;
  specialityModel.speciality = "Urologist";
  specialityModel.imgAssetPath = "assets/images/img3.png";
  specialityModel.backgroundColor = Color(0xffEACBCB);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  return specialities;
}

// 'Dermatologist',
//                                 'Infectious Disease Specialist',
//                                 'Orthopedic',
//                                 'Allergist',
//                                 'Endocrinologist',
//                                 'Gastroenterologist',
//                                 'Cardiologist',
//                                 'Neurologist',
//                                 'Urologist',
//                                 'ENT Specialist',
//                                 'Pulmonologist'
