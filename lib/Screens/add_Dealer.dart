import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: add_Dealer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class add_Dealer extends StatefulWidget {
  @override
  _add_DealerState createState() => _add_DealerState();
}

GlobalKey myFormKey = new GlobalKey();

class _add_DealerState extends State<add_Dealer> {
  TextEditingController _NameController = TextEditingController();
  TextEditingController _MobileController = TextEditingController();
  TextEditingController _MinQtyController = TextEditingController();
  TextEditingController _MaxQtyController = TextEditingController();
  TextEditingController _PincodeController = TextEditingController();

  // add new flailed radio btn  old dealer new dealer others

  @override
  void Namedispose() {
    _NameController.dispose();
    super.dispose();
  }

  @override
  void Mobiledispose() {
    _MobileController.dispose();
    super.dispose();
  }

  @override
  void MinQtydispose() {
    _MinQtyController.dispose();
    super.dispose();
  }

  @override
  void MaxQtydispose() {
    _MaxQtyController.dispose();
    super.dispose();
  }

  @override
  void Pincodedispose() {
    _PincodeController.dispose();
    super.dispose();
  }

  submit(String name, mobile, minQty, maxQty, pincode) async {
    try {
      Response responce = await post(
          Uri.parse("https://kabaditechno.herokuapp.com/api/dealeradd/"),
          body: {
            "name": name,
            "mobile": mobile,
            "old": false,
            "new": true,
            "other": false,
            "min_qty": minQty,
            "max_qty": maxQty,
            "pincode": pincode,
          });
      if (responce.statusCode == 200) {
        var data = jsonDecode(responce.body.toString());
        print(data);
        print('add successfully');
      } else {
        print('filed not match ');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var statusController;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dealer'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _NameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _MobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile',
                  prefixIcon: Icon(Icons.phone, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _MinQtyController,
                decoration: InputDecoration(
                  labelText: 'Minimum Qty',
                  prefixIcon: Icon(Icons.pin, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _MaxQtyController,
                decoration: InputDecoration(
                  labelText: 'Maximum Qty',
                  prefixIcon: Icon(Icons.pin, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //SizedBox(height: 20),
              TextField(
                controller: _PincodeController,
                decoration: InputDecoration(
                  labelText: 'PinCode',
                  prefixIcon: Icon(Icons.pin, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    submit(
                      _NameController.text.toString(),
                      _MobileController.text.toString(),
                      _MinQtyController.text.toString(),
                      _MaxQtyController.text.toString(),
                      _PincodeController.text.toString(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(70)),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









//
// Scaffold(
// backgroundColor: Colors.white,
// body: Column(
// children: [
// Container(
// height: 200,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.only(
// bottomRight: Radius.circular(50),
// ),
// color: Colors.blueGrey,
// ),
// child: Stack(
// children: [
// Positioned(
// top: 70,
// left: 0,
// child: Container(
// height: 80,
// width: 220,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.only(
// topRight: Radius.circular(50),
// bottomRight: Radius.circular(50),
// )),
// ),
// ),
// Positioned(
// top: 100,
// left: 50,
// child: Text(
// "SignUp",
// style: TextStyle(
// fontSize: 20,
// color: Colors.black,
// ),
// ),
// ),
// ],
// ),
// ),
// SizedBox(height: height * 0.02),
// Text("What Type of Customer Am I ?",
// style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// SizedBox(height: height * 0.02),
// Container(
// height: 520,
// child: Stack(
// children: [
// Positioned(
// child: Material(
// child: Material(
// child: Container(
// height: 500,
// width: width * 0.8,
// decoration: BoxDecoration(
// color: Colors.blueGrey,
// borderRadius: BorderRadius.circular(50.0),
// ),
// ),
// ),
// ),
// ),
// Stack(
// children: [
// Positioned(
// child: Column(
// children: [
// Container(
// padding: EdgeInsets.all(
// MediaQuery.of(context).size.width / 25),
// child: Card(
// elevation: 0,
// shadowColor: Colors.blue.shade50,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(40.0)),
// child: Column(children: [
// Container(
// height: 220,
// width: width * 0.7,
// child: Column(
// children: [
// SizedBox(height: height * 0.02),
// Text(
// "People selling from shop,\n"
// "Restaurant,office,marriage hall\n"
// "Etc(Who produce less scrap)",
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.black,
// fontSize: 15,
// fontWeight: FontWeight.w800)),
// DropdownButtonFormField<String>(
// decoration: const InputDecoration(
// contentPadding: EdgeInsets.only(
// top: 20, left: 50, right: 50),
// enabledBorder: InputBorder.none,
// ),
// value: _ratingController,
// items: [
// "Shop",
// "Restaurant",
// "Office",
// "Marriage Hall",
// "Others"
// ]
// .map((label) => DropdownMenuItem(
// child: Text(label.toString()),
// value: label,
// ))
// .toList(),
// hint: Text('Select'),
// validator: (value) => value == null
// ? 'field required'
// : null,
// onChanged: (value) {
// setState(() {
// var _ratingController = value;
// });
// }
// ),
// SizedBox(height: height * 0.02),
// ElevatedButton(
// onPressed: (){},
// child: Text("SignUp",
// ),
// ),
// ]
//
// ),
// ),
// ]
// )),
// ),
// ],
// ),
// ),
// ],
// ),
// Container(
// margin: EdgeInsets.only(
// top: MediaQuery.of(context).size.width / 1.5),
// child: Positioned(
// child: Container(
// padding: EdgeInsets.all(
// MediaQuery.of(context).size.width / 25),
// //color: Colors.black,
// child: Card(
// elevation: 0,
// shadowColor: Colors.grey.shade50,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(40.0)),
// child: Container(
// height: 220,
// width: width * 0.7,
// )),
// ),
// ),
// ),
// ],
// )),
// ],
// ),
// );






