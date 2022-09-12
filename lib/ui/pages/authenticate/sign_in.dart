import 'package:flutter/material.dart';
import 'package:tailor/ui/pages/services/auth.dart';
import 'package:tailor/ui/pages/shared/constants.dart';
import 'package:tailor/ui/pages/shared/loading.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);

  final Function toggleView;
  SignIn({required this.toggleView});

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

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //
      //   backgroundColor: Colors.lightBlue,
      //   elevation: 0.0,
      //   title: Text('Sign In for Date Ready'),
      // ),
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
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Text('Tailor',
                    style: TextStyle(
                      fontSize: 48.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.lightBlueAccent),
                    //borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.lightBlueAccent),
                  ),
                ),// textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter your email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.lightBlueAccent),
                    //borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.lightBlueAccent),
                  ),
                ), //textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val!.length < 6 ? 'Enter a password 6 characters long' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                child: Text('Sign in'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueAccent[400]),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.white))),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      loading = true;
                    });
                   dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Invalid email or password';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 10,),
              Text(error,style: TextStyle(color: Colors.red,fontSize: 20.0),),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: () {widget.toggleView();}, child: Text('Register')),
            ],
          ),
        )
      ),
    );
  }
}
