import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  final String startTime;
  final String endTime;
  final String patient;
  final Color boxColor;

  TaskContainer({
    this.startTime,
    this.endTime,
    this.boxColor,
    this.patient
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  startTime,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('-'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  endTime,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Text(patient,style: TextStyle(
              fontSize: 20.0,fontWeight: FontWeight.bold
            ),),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(30.0)),
    );
  }
}
