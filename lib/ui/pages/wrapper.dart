import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor/ui/pages/authenticate/authenticate.dart';
import 'package:tailor/ui/pages/models/myUser.dart';
import 'package:tailor/ui/pages/home.dart';

import 'authenticate/sign_in.dart';


//this class listens for auth changes
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);
    //final user = Provider.of<myUser?>(context);

    if(user == null){
      return SignIn();
    } else {
      return Home();
    }
  }
}
