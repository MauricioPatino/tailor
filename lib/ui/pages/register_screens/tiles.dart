import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  //const MyTile({Key? key}) : super(key: key);

  int age;

  MyTile({required this.age});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Text(age.toString(),
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.black)
          ),
        ),
      ),
    );
  }
}
