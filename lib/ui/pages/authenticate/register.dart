import 'package:flutter/material.dart';
import 'package:tailor/ui/pages/home.dart';
import 'package:tailor/ui/pages/register_screens/name.dart';
import 'package:tailor/ui/pages/services/auth.dart';
import 'package:tailor/ui/pages/shared/constants.dart';
import 'package:tailor/ui/pages/shared/loading.dart';
import 'package:tailor/ui/pages/registration/setup_account.dart';
import 'package:tailor/ui/pages/register_screens/add_photo.dart';

import 'login.dart';

class Register extends StatefulWidget {
  //const Register({Key? key}) : super(key: key);

  // final Function toggleView;
  // Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

   TextEditingController _email = TextEditingController();
   TextEditingController _password = TextEditingController();

  var email = '';
  var password = '';
  var error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0.0,
        title: Text('Sign Up for Date Ready'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Flexible(
                  child: TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Colors.lightBlueAccent),
                        //borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Colors.lightBlueAccent),
                      ),
                    ), //textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? 'Enter your email' : null,
                    onChanged: (val){
                      setState(() {
                        email = val;

                      });
                    },
                  ),
                ),
               SizedBox(height: 20,),
                Flexible(
                  child: TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Colors.lightBlueAccent),
                        //borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Colors.lightBlueAccent),
                      ),
                    ),
                    //textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) => val!.length < 6 ? 'Enter a password 6 characters long' : null,
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton(
                  child: Text('Continue'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blueAccent[400]),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white))),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Please enter a valid email';
                          loading = false;
                        });;
                      }
                    }
                  },
                ),
                SizedBox(height: 30,),
                Flexible(
                  child: ElevatedButton(
                    child: Text('NEXT PAGE TEST'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueAccent[400]),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white))),
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));},
                  ),
                ),
                SizedBox(height: 10,),
                Text(error,style: TextStyle(color: Colors.red,fontSize: 20.0),),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Login()));}, child: Text('Go Back')),
              ],
            ),
          )
      ),
    );
  }
}
