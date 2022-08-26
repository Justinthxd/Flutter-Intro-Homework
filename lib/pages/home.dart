import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ref = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent.withOpacity(0.3),
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreenAccent.withOpacity(0.8),
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          // naviagtion
          Navigator.pushNamed(context, '/create');
        },
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black38,
            ],
          ),
        ),
        child: StreamBuilder(
          stream: ref.child('data').child('data').onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.lightGreenAccent,
                ),
              );
            }
            final data = snapshot.data.snapshot.value;
            try {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(
                  height: 10,
                ),
                itemCount: data.length ?? 0,
                itemBuilder: (context, index) {
                  final item = data.values.toList()[index];
                  return Dismissible(
                    key: Key(item['name']),
                    onDismissed: (direction) {
                      ref
                          .child('data')
                          .child('data')
                          .child(data.keys.toList()[index])
                          .remove();
                    },
                    background: Container(
                      color: Colors.red.withOpacity(0.3),
                      child: const ListTile(
                        leading: Icon(
                          Icons.delete_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red.withOpacity(0.3),
                      child: const ListTile(
                        trailing: Icon(
                          Icons.delete_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        // Navigator.pushNamed(
                        //   context,
                        //   '/sub',
                        //   arguments: item,
                        // );
                      },
                      onLongPress: () {
                        Navigator.pushNamed(context, '/edit', arguments: item);
                      },
                      title: Container(
                        height: 180,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 45, 45, 45),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Color.fromARGB(255, 55, 55, 55),
                              offset: Offset(-5, -5),
                            ),
                            BoxShadow(
                              blurRadius: 5,
                              color: Color.fromARGB(255, 35, 35, 35),
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Text(
                                  '${item['name']} ${item['lastname']}',
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 15),
                                Text(
                                  '${item['position']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white30,
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${item['email']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white38,
                                    ),
                                  ),
                                  Text(
                                    '${item['salary']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${item['address']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Vacation: ${item['vacation']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } catch (e) {
              return const Center(
                child: Text(
                  'No employees',
                  style: TextStyle(
                    color: Colors.white10,
                    fontSize: 25,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
