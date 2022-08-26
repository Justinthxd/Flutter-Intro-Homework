import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_intro_software/pages/home.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Sub extends StatefulWidget {
  Sub({Key? key}) : super(key: key);

  @override
  State<Sub> createState() => _SubState();
}

class _SubState extends State<Sub> {
  TextEditingController controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aux = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent.withOpacity(0.3),
        title: Text(
          aux['name'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(15),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Text(
              aux['name'] + ' ' + aux['lastname'],
              style: const TextStyle(
                fontSize: 31,
              ),
            ),
            SizedBox(height: 10),
            Text(
              aux['email'],
              style: TextStyle(
                fontSize: 20,
                color: Colors.white54,
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Position: ' + aux['position'],
              style: TextStyle(
                fontSize: 22,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: ' + aux['phone'],
              style: TextStyle(
                fontSize: 22,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Salary: ' + aux['salary'],
              style: TextStyle(
                fontSize: 22,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Address: ' + aux['address'],
              style: TextStyle(
                fontSize: 22,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Vacaciones:',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 10),
            Text(
              aux['vacation'],
              style: TextStyle(
                fontSize: 22,
                color: Colors.white70,
              ),
            ),
            // SizedBox(height: 10),
            // Divider(),
            // SizedBox(height: 10),
            // TextField(
            //   controller: controller,
            //   maxLines: 15,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
