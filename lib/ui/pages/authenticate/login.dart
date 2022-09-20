import 'package:flutter/material.dart';
import 'package:tailor/ui/pages/authenticate/sign_in.dart';
import 'package:tailor/ui/pages/home.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      body: Center(
        child: ElevatedButton(onPressed: () {Navigator.pop(context);}, child: const Text('Go Back')),
      ),
    );
  }
}
