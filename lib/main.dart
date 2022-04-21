import 'dart:convert';
import 'package:demo/ReuseCard.dart';
import 'package:demo/Screens/add_Dealer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
        body: Center(
          child: Text(
            "Location Required",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String location = 'Null, Press Button';
  String Address = 'search';
  String dist = 'dist';
  String state = 'state';
  String country = 'country';
  String PinCode = 'pincode';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      Fluttertoast.showToast(msg: 'Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<dynamic> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street},\n${place.subAdministrativeArea},\n'
        '${place.administrativeArea}, ${place.postalCode}, ${place.country}';
    PinCode = '${place.postalCode}';
    setState(() {});
  }

  //Location end

  var data;
  var data1;

  getDealer() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';

    var a = position.longitude.toString();
    var b = position.latitude.toString();

    final response = await http.get(Uri.parse(
        "http://kabaditechno.herokuapp.com/api/getdealers/?lon=" +
            a +
            "&" +
            "lat=" +
            b));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      data1 = data['data']['dealers'];
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    _getGeoLocationPosition();
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => add_Dealer()),
              );
            },
          )
        ],
        title: Text("Location"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                          width: 300,
                          height: 100,
                          child: TextField(
                            expands: true,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            enabled: false,
                            // controller:
                            decoration: InputDecoration(
                              labelText: Address,
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon:
                                  Icon(Icons.location_on, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(70),
                              ),
                            ),
                          )),
                      // more widgets
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        Position position = await _getGeoLocationPosition();
                        location =
                            'Lat: ${position.latitude} , Long: ${position.longitude}';
                        print(position.longitude);
                        print(position.latitude);
                        GetAddressFromLatLong(position);
                      },
                      child: Text('Get Location'))
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getDealer(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    } else {
                      return ListView.builder(
                          itemCount: data1.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  ReuseCard(
                                      title: "ID",
                                      value: data1[index]['id'].toString()),
                                  ReuseCard(
                                      title: "Name",
                                      value: data1[index]['name']),
                                  ReuseCard(
                                      title: "Distance",
                                      value: data1[index]['distance']),
                                  ReuseCard(
                                      title: "Mobile",
                                      value: data1[index]['mobile'].toString()),
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
