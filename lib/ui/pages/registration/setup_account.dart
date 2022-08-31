import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailor/ui/pages/shared/image_picker.dart';

class AccountRegistration extends StatefulWidget {
  const AccountRegistration({Key? key}) : super(key: key);

  @override
  _AccountRegistrationState createState() => _AccountRegistrationState();
}

class _AccountRegistrationState extends State<AccountRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          elevation: 0.0,
          title: Text('Setup your dating profile!'),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  ElevatedButton(onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => CameraWidget()));}, child: Text('Upload a photo!')),
                  SizedBox(height: 10,),
                ],
              )
            ],
        ),
      ),
    );
  }
}
