import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IotScreen extends StatefulWidget {
  @override
  _IotScreenState createState() => _IotScreenState();
}

class _IotScreenState extends State<IotScreen> {
  @override
  bool value = false; // buton1 kontrol biti
  bool value_1 = false; //buton2 kontrol biti
  bool value_2 = false; //buton3 kontrol biti
  bool value_3 = false; // buton4 kontrol biti

  final dbRef = FirebaseDatabase.instance.reference(); //database kontrol biti

  onUpdate(int a) {
    if(a==0){
      setState(() {
        value = !value;
      });
    }
    if(a==1){
      setState(() {
        value_1 = !value_1;
      });
    }
    if(a==2){
      setState(() {
        value_2 = !value_2;
      });
    }
    if(a==3){
      setState(() {
        value_3 = !value_3;
      });
    }

  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: dbRef.child("Data").onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data.snapshot.value != null) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.clear_all,
                            color: Colors.white,
                          ),
                          Text(
                            "My ROOM",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.settings),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Temperature",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data.snapshot.value["Temperature"]
                                        .toString() +
                                    "°C", //TODO:Sıcaklığı buraya çek!!!!!!!
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Humidity",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data.snapshot.value["Humidity"]
                                        .toString() +
                                    "%", // TODO: Nemi buraya çek!!!!!!!
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("role1"),
                        SizedBox(
                          height: 80,
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            onUpdate(0);
                            writeData();
                          },
                          label: value ? Text("ON") : Text("OFF"),
                          elevation: 20,
                          backgroundColor: value ? Colors.yellow : Colors.white,
                          icon: value
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ],
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("role2"),
                        SizedBox(
                          height: 80,
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            onUpdate(1);
                            writeData();
                          },
                          label: value_1 ? Text("ON") : Text("OFF"),
                          elevation: 20,
                          backgroundColor: value_1 ? Colors.yellow : Colors.white,
                          icon: value_1
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ],
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("role3"),
                        SizedBox(
                          height: 80,
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            onUpdate(2);
                            writeData();
                          },
                          label: value_2 ? Text("ON") : Text("OFF"),
                          elevation: 20,
                          backgroundColor: value_2 ? Colors.yellow : Colors.white,
                          icon: value_2
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ],
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("role3"),
                        SizedBox(
                          height: 80,
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            onUpdate(3);
                            writeData();
                          },
                          label: value_3 ? Text("ON") : Text("OFF"),
                          elevation: 20,
                          backgroundColor: value_3 ? Colors.yellow : Colors.white,
                          icon: value_3
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ],
                    ),
                  ],
                );
              } else
                return Container();
            }),
      ),
    );
  }

  Future<void> writeData() {
    dbRef.child("Data").set({
      "Humidity": 0,
      "Temperature": 0,
    });
    dbRef.child("LightState").set({
      "switch": !value,
      "switch_1": !value_1,
      "switch_2": !value_2,
      "switch_3": !value_3,
    }); //TODO: FİREBASE VALUE değerini kontrol eder
  }
}
