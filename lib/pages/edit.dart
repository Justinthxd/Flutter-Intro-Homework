import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_intro_software/pages/home.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'create_employee.dart';

class Edit extends StatefulWidget {
  Edit({Key? key}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  List<TextEditingController> controllers = [
    for (int i = 0; i < 9; i++) TextEditingController(text: ''),
  ];

  final ref = FirebaseDatabase.instance.ref();

  int x = 0;
  String date = '';

  add() async {
    final data;

    data = await ref.child('data').child('data').get();

    data.value.forEach((k, v) {
      if (v['email'] == controllers[2].text) {
        ref.child('data').child('data').child(k).update({
          'name': controllers[0].text.trim(),
          'lastname': controllers[1].text.trim(),
          'email': controllers[2].text.trim(),
          'address': controllers[3].text.trim(),
          'phone': controllers[4].text.trim(),
          'salary': controllers[5].text.trim(),
          'birthday': controllers[6].text.trim(),
          'position': controllers[7].text.trim(),
          'vacation': date,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aux = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    if (x == 0) {
      controllers[0].text = aux['name'];
      controllers[1].text = aux['lastname'];
      controllers[2].text = aux['email'];
      controllers[3].text = aux['address'];
      controllers[4].text = aux['phone'];
      controllers[5].text = aux['salary'];
      controllers[6].text = aux['birthday'];
      controllers[7].text = aux['position'];
      controllers[8].text = aux['vacation'];
      x = 1;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.yellow.withOpacity(0.4),
        title: Text(
          "Edit",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.done_rounded,
            ),
            onPressed: () {
              add();
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(5),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: size.height * 0.02),
            myField(size, "Name", Icons.person, controllers[0]),
            SizedBox(height: size.height * 0.005),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: const Divider(),
            ),
            SizedBox(height: size.height * 0.005),
            myField(size, "Last Name", Icons.person_outline_rounded,
                controllers[1]),
            SizedBox(height: size.height * 0.005),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: const Divider(),
            ),
            SizedBox(height: size.height * 0.005),
            myField(size, "Email", Icons.email, controllers[2]),
            SizedBox(height: size.height * 0.005),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: const Divider(),
            ),
            SizedBox(height: size.height * 0.005),
            myField(
                size, "Address", Icons.location_city_rounded, controllers[3]),
            SizedBox(height: size.height * 0.005),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: const Divider(),
            ),
            SizedBox(height: size.height * 0.005),
            myField(size, "Phone", Icons.phone_rounded, controllers[4]),
            SizedBox(height: size.height * 0.005),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: const Divider(),
            ),
            SizedBox(height: size.height * 0.005),
            myField(size, "Salary", Icons.attach_money_rounded, controllers[5]),
            SizedBox(height: size.height * 0.005),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: const Divider(),
            ),
            SizedBox(height: size.height * 0.005),
            myField(size, "Birthday", Icons.cake_rounded, controllers[6]),
            SizedBox(height: size.height * 0.005),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: const Divider(),
            ),
            SizedBox(height: size.height * 0.005),
            myField(size, "Position", Icons.work_rounded, controllers[7]),
            SizedBox(height: size.height * 0.005),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: const Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SfDateRangePicker(
                onSelectionChanged:
                    (DateRangePickerSelectionChangedArgs dates) {
                  final start =
                      DateTime.tryParse(dates.value.startDate.toString());
                  final end = DateTime.tryParse(dates.value.endDate.toString());

                  date =
                      'De ${end?.day}/${end?.month}/${end?.year} hasta ${start?.day}/${start?.month}/${start?.year}';
                },
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: PickerDateRange(
                  DateTime.now().subtract(const Duration(days: 4)),
                  DateTime.now().add(
                    const Duration(days: 3),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow.withOpacity(0.7),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  add();
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
