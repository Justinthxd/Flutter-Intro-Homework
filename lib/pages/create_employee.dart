import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Crear extends StatefulWidget {
  const Crear({Key? key}) : super(key: key);

  @override
  State<Crear> createState() => _CrearState();
}

class _CrearState extends State<Crear> {
  final ref = FirebaseDatabase.instance.ref();

  List<TextEditingController> controllers = [
    for (int i = 0; i < 8; i++) TextEditingController(text: ''),
  ];

  String date = '';

  add() {
    ref.child('data').child('data').push().set({
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
    for (int i = 0; i < 8; i++) {
      controllers[i].text = '';
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.4),
        title: const Text(
          'Add Employee',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_rounded),
            onPressed: () {
              add();
            },
          ),
        ],
      ),
      body: ListView(
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
          myField(
              size, "Last Name", Icons.person_outline_rounded, controllers[1]),
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
          myField(size, "Address", Icons.location_city_rounded, controllers[3]),
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
          SizedBox(height: size.height * 0.005),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs dates) {
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
                primary: Colors.green.withOpacity(0.5),
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
              },
            ),
          ),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}

Widget myField(
    Size size, String hint, IconData icon, TextEditingController controller) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: size.width * 0.01,
      vertical: size.height * 0.01,
    ),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(245, 245, 245, 0.1),
      borderRadius: BorderRadius.circular(9),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: TextField(
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(
        fontSize: 19,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 19,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );
}
