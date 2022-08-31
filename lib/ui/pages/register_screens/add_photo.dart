import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tailor/ui/pages/authenticate/register.dart';
import 'package:tailor/ui/pages/register_screens/name.dart';
import 'package:tailor/ui/pages/services/auth.dart';
import 'package:tailor/ui/pages/shared/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tailor/ui/pages/api/firebase_api.dart';
import 'dart:io';
import 'package:flutter/services.dart';
 
class AddPhoto extends StatefulWidget {
  const AddPhoto({Key? key}) : super(key: key);

  // final Function photoView;
  // AddPhoto({required this.photoView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<AddPhoto> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  final _email = TextEditingController();
  final _password = TextEditingController();

  var email = '';
  var password = '';
  var error = '';


  //FOR PHOTOS
  File? image;
  File? file;
  UploadTask? task;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      //final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() {
        this.image = imagePermanent;
      });

    } on PlatformException catch(e){
      print('Failed to pick your image: $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if(result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async {
    if(file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {

    });

    if(task == null) return;
    final snapshot = await task!.whenComplete(() => null);
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot){
      if(snapshot.hasData){
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );

  Future<void> _showChoiceDialog(BuildContext context)
  {
    return showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Choose option",style: TextStyle(color: Colors.blue),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  pickImage(ImageSource.gallery);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.account_box,color: Colors.blue,),
              ),

              Divider(height: 1,color: Colors.blue,),
              ListTile(
                onTap: (){
                  pickImage(ImageSource.camera);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera,color: Colors.blue,),
              ),
            ],
          ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No file selected';

    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                // TextFormField(
                //   decoration: const InputDecoration(
                //     labelText: 'Email',
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(width: 3, color: Colors.lightBlueAccent),
                //       //borderRadius: BorderRadius.circular(15),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(width: 3, color: Colors.lightBlueAccent),
                //     ),
                //   ), //textInputDecoration.copyWith(hintText: 'Email'),
                //   validator: (val) => val!.isEmpty ? 'Enter your email' : null,
                //   onChanged: (val){
                //     setState(() {
                //       email = val;
                //     });
                //   },
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //if (image != null) ClipOval(child: Image.file(image!,width: 250, height: 250, fit: BoxFit.cover,)) else FlutterLogo(size: 150,),
                    if (file != null) ClipOval(child: Image.file(file!,width: 250, height: 250, fit: BoxFit.cover,)) else FlutterLogo(size: 150,),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.pink,
                      onPressed: (){
                        _showChoiceDialog(context);
                        //pickImage(ImageSource.gallery);
                      },
                      child: Text("Select Image"),

                    ),
                    ElevatedButton(onPressed: selectFile, child: Text('Select a file')),
                    Text(fileName, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100),),
                    ElevatedButton(onPressed: uploadFile, child: Text('Upload to storage')),
                    task != null ? buildUploadStatus(task!) : Container(),
                  ],
                ),
                SizedBox(height: 30,),
                Flexible(
                  child: ElevatedButton(
                    child: Text('Continue'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueAccent[400]),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white))),
                    onPressed: () async {Navigator.push(context, MaterialPageRoute(builder: (context) => const AddName()));},
                  ),
                ),
                SizedBox(height: 30),
                Text(error,style: TextStyle(color: Colors.red,fontSize: 20.0),),
                SizedBox(height: 10,),
                ElevatedButton( child: Text('Go back'), onPressed: () {Navigator.pop(context);}),
                // SizedBox(height: 10,),
                // ElevatedButton(onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => const AccountRegistration()));}, child: Text('TEST IMAGE PICKER')),
              ],
            ),
          )
      ),
    );
  }
}
