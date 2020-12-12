import '../models/speciality.dart';
import 'package:flutter/cupertino.dart';

List<Speciality> getSpeciality() {

  List<Speciality> specialities = new List<Speciality>();

  Speciality specialityModel = new Speciality();

  specialityModel.noOfDoctors = 10;
  specialityModel.speciality = "Cold and Cough";
  specialityModel.imgAssetPath = "assets/images/img1.png";
  specialityModel.backgroundColor = Color(0xffFBB97C);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 17;
  specialityModel.speciality = "Heart Specialists";
  specialityModel.imgAssetPath = "assets/images/img2.png";
  specialityModel.backgroundColor = Color(0xffF69383);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 15;
  specialityModel.speciality = "Diabetes Normd";
  specialityModel.imgAssetPath = "assets/images/img3.png";
  specialityModel.backgroundColor = Color(0xffEACBCB);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 10;
  specialityModel.speciality = "Cold and Corona";
  specialityModel.imgAssetPath = "assets/images/img1.png";
  specialityModel.backgroundColor = Color(0xffFBB97C);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 17;
  specialityModel.speciality = "Heart Surgen";
  specialityModel.imgAssetPath = "assets/images/img2.png";
  specialityModel.backgroundColor = Color(0xffF69383);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  specialityModel.noOfDoctors = 15;
  specialityModel.speciality = "Diabetes Cares";
  specialityModel.imgAssetPath = "assets/images/img3.png";
  specialityModel.backgroundColor = Color(0xffEACBCB);
  specialities.add(specialityModel);

  specialityModel = new Speciality();

  return specialities;
}
