import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ref = FirebaseDatabase.instance.ref();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Colors.transparent,
              Colors.black54,
            ],
          ),
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 100),
            // Text(
            //   'Employer',
            //   style: TextStyle(
            //     fontSize: 70,
            //     fontWeight: FontWeight.bold,
            //     shadows: [
            //       BoxShadow(
            //         blurRadius: 10,
            //         color: Colors.lightGreenAccent.withOpacity(0.2),
            //         offset: const Offset(5, 5),
            //       ),
            //       BoxShadow(
            //         blurRadius: 10,
            //         color: Colors.black38,
            //         offset: const Offset(-5, -5),
            //       ),
            //     ],
            //   ),
            // ),

            Container(
              height: 200,
              child: Image.asset(
                'assets/logo.png',
                color: Colors.white.withOpacity(1),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
            SizedBox(height: 100),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: c1,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: c2,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreenAccent.withOpacity(0.7),
                ),
                onPressed: () {
                  ref.child('data').child('users').once().then((value) {
                    final data = value.snapshot.value;

                    final res = jsonDecode(jsonEncode(data));

                    res.forEach((key, value) {
                      if (c1.text.trim() == value['email'] &&
                          c2.text.trim() == value['password']) {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    });

                    c1.text = '';
                    c2.text = '';
                  });
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              child: const Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreenAccent.withOpacity(0.4),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  ref.child('data').child('users').push().set({
                    'email': c1.text,
                    'password': c2.text,
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
