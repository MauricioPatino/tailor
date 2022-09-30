import 'package:flutter/material.dart';
import 'package:tailor/ui/pages/authenticate/register.dart';
import 'package:tailor/ui/pages/register_screens/otp.dart';
import 'package:tailor/ui/pages/services/auth.dart';
import 'package:tailor/ui/pages/shared/constants.dart';
import 'package:tailor/ui/pages/shared/loading.dart';
import 'package:tailor/ui/pages/authenticate/login.dart';

import '../home.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);
  //
  // final Function toggleView;
  // SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  final _email = TextEditingController();
  final _password = TextEditingController();

  var error = '';
  var email = '';
  var password = '';

  bool signIn = true;

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.green,
              Colors.yellow,
            ],
          )
        ),
          //padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                  children: [
                       SizedBox(
                         height: MediaQuery.of(context).size.height*0.50,
                         child: Padding(
                           padding: const EdgeInsets.all(60.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.max,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.loose,
                              child: Icon(Icons.favorite, size: 60, color: Colors.yellowAccent,),
                                ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text('Tailor',
                                    style: TextStyle(
                                      fontSize: 48.0,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                         ),
                        ),

                Visibility(
                  visible: signIn,
                  child: ElevatedButton(onPressed: () {setState(() {
                    signIn = !signIn;
                  });}, style: ElevatedButton.styleFrom(
                    primary: Colors.yellowAccent, onPrimary: Colors.black, minimumSize: const Size(250,50), maximumSize: const Size(250,75),),
                    child: const Text('Sign in'),),
                ),
                    Visibility(
                      visible: !signIn,
                      child: Column(
                        children: [
                          //const SizedBox(height: 150,),
                          ElevatedButton.icon(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));}, style: ElevatedButton.styleFrom(
                            primary: Colors.white, onPrimary: Colors.black, minimumSize: const Size(250,50), maximumSize: const Size(250,75),
                          ), label: const Text('Sign in with Apple'), icon: const Icon(Icons.apple),),
                          const SizedBox(height: 10,),

                          ElevatedButton.icon(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));}, style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent, onPrimary: Colors.black, minimumSize: const Size(250,50), maximumSize: const Size(250,75),
                          ), label: const Text('Sign in with Facebook'), icon: const Icon(Icons.facebook),),
                              const SizedBox(height: 10,),

                          ElevatedButton.icon(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPScreen('2019999999')));}, style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreen, onPrimary: Colors.black, minimumSize: const Size(250,50), maximumSize: const Size(250,75),
                          ), label: const Text('Sign in with phone number'), icon: const Icon(Icons.phone),),

                          const SizedBox(height: 10,),
                          ElevatedButton(onPressed: () {setState(() {
                            signIn = !signIn;
                          });}, style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreen, onPrimary: Colors.black, minimumSize: const Size(250,50), maximumSize: const Size(250,75),),
                            child: const Text('Back'),),
                          const SizedBox(height: 10,),
                          ],
                        ),
                    ),
                    Text(error,style: const TextStyle(color: Colors.red,fontSize: 20.0),),
                    ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>  Register()));}, style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen, onPrimary: Colors.black, minimumSize: const Size(250,50), maximumSize: const Size(250,75),),
                      child: const Text('Register'),),
                  ], //widget.toggleView();
                ),
              ),
            ),
          ),
        );
      }
    }

// ElevatedButton(
//   style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.all(Colors.blueAccent[400]),
//       textStyle: MaterialStateProperty.all(
//           const TextStyle(color: Colors.white))),
//   onPressed: () async {
//     if(_formKey.currentState!.validate()){
//       setState(() {
//         loading = true;
//       });
//      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
//       if(result == null){
//         setState(() {
//           error = 'Invalid email or password';
//           loading = false;
//         });
//       }
//     }
//   },
//   child: const Text('Sign in'),
// ),
//const SizedBox(height: 10,),


// padding: EdgeInsets.only(top: 10.0),
// child: Center(
//   child: Text('Tailor',
//   style: TextStyle(
//     fontSize: 48.0,
//     fontStyle: FontStyle.italic,
//     fontWeight: FontWeight.bold,
//     color: Colors.white,
//   ),),
// ),
//

//const SizedBox(height: 20,),
// TextFormField(
//   decoration: const InputDecoration(
//     labelText: 'Email',
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(width: 3, color: Colors.lightBlueAccent),
//       //borderRadius: BorderRadius.circular(15),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(width: 3, color: Colors.lightBlueAccent),
//     ),
//   ),// textInputDecoration.copyWith(hintText: 'Email'),
//   validator: (val) => val!.isEmpty ? 'Enter your email' : null,
//   onChanged: (val){
//     setState(() {
//       email = val;
//     });
//   },
// ),
// const SizedBox(height: 20,),
// TextFormField(
//   decoration: const InputDecoration(
//     labelText: 'Password',
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(width: 3, color: Colors.lightBlueAccent),
//       //borderRadius: BorderRadius.circular(15),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(width: 3, color: Colors.lightBlueAccent),
//     ),
//   ), //textInputDecoration.copyWith(hintText: 'Password'),
//   validator: (val) => val!.length < 6 ? 'Enter a password 6 characters long' : null,
//   obscureText: true,
//   onChanged: (val){
//     setState(() {
//       password = val;
//     });
//   },
// ),
//const SizedBox(height: 250,),