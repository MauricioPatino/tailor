import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tailor/ui/pages/models/myUser.dart';
import 'package:tailor/ui/pages/feedback.dart';
import 'package:tailor/ui/pages/explore.dart';
import 'package:tailor/ui/pages/settings.dart';

class Explore extends StatefulWidget {
  late myUser user;
  @override
  _HomePageState createState() => _HomePageState();
}
final List pics = [
  {"name": "Picture-1", "photo": "assets/images/pic-3.jpg"},
  {"name": "Picture-2", "photo": "assets/images/pic-2.jpg"},
  {"name": "Picture-3", "photo": "assets/images/pic-1.jpg"},
];
Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.red;
  }
  return Colors.blue;
}
bool isChecked_1 = false;
bool isChecked_2 = false;
class _HomePageState extends State<Explore> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        automaticallyImplyLeading: false,
      ),
      body:  ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Text("Olivia Wilde, 31",style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      height: 400,
                      width: 500,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: false,
                          autoPlayInterval: Duration(seconds: 2),
                          autoPlayAnimationDuration: Duration(milliseconds: 400),
                          height: 1000,

                        ),
                        items: pics.map((i) {
                          return GridTile(
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: AspectRatio(
                                      aspectRatio: 4/3,
                                      child: Container(
                                        margin: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(i["photo"]),
                                              fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                    )
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty.resolveWith(getColor),
                                        value: isChecked_1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked_1 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty.resolveWith(getColor),
                                        value: isChecked_2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked_2 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            // footer: Container(
                            //     padding: EdgeInsets.all(10),
                            //     color: Colors.transparent,
                            //     child: Text(
                            //       i["name"],
                            //       style: TextStyle(color: Colors.white, fontSize: 20),
                            //       textAlign: TextAlign.right,
                            //     )), THIS IS FOR TEXT FOR EACH ITEM
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],

            ),
            Divider(height: 20,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Biography", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: Text("Mauris a egestas mi. Aliquam nec velit eget elit tincidunt pharetra. Aenean vitae interdum metus. Donec at turpis vulputate nulla lobortis pharetra id in nulla.")),
                  ],
                )
              ],
            ),
            Divider(height: 20,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("One liner", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    Flexible(child: Text("Looking for the peanut butter to my jelly")),
                  ],
                )
              ],
            ),
            Divider(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                ElevatedButton(onPressed: () {}, child:const Text('Next'))
              ],
            ),
          ]
      ),
    );
  }
}