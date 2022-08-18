import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_fraj/methods/mp3_methods.dart';
import 'package:music_fraj/providers/music_provider.dart';
import 'package:music_fraj/screens/homescreen/home_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'methods/music_handler.dart';

void main() async{

  
  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>music_provider())
  ],child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: home_screen(),
    );
  }
}
class myhomepage extends StatefulWidget {
  const myhomepage({Key? key}) : super(key: key);

  @override
  State<myhomepage> createState() => _myhomepageState();
}

class _myhomepageState extends State<myhomepage> {
  @override
Future<String> createFolderInAppDocDir(String folderName, String path) async {
  //Get this App Document Directory

  final Directory _appDocDir = await getApplicationDocumentsDirectory();
 
  //App Document Directory + folder name
  final Directory _appDocDirFolder =
  Directory('${path}/$folderName/');

  if (await _appDocDirFolder.exists()) {
    //if folder already exists return path
    return _appDocDirFolder.path;
  } else {
    //if folder not exists create folder and then return its path
    final Directory _appDocDirNewFolder =
    await _appDocDirFolder.create(recursive: true);
   
    return _appDocDirNewFolder.path;
    
  }
}



final player = AudioPlayer(); 
  void initState() {


    print(Mp3_Methods().searchforsong("spirited"));
  
    createFolderInAppDocDir("music_fraj","/storage/emulated/0",);

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    FutureBuilder(future:Mp3_Methods().getallmusic() ,builder: (BuildContext context,AsyncSnapshot<List> snap){
      
 if(snap.hasData){
  return ListView.builder(itemCount:snap.data!.length,itemBuilder: (context,i){

    return InkWell(
      onTap:()async{
final duration = await player.setFilePath(snap.data![i].path); 
player.play();

      },
      child: Text(Mp3_Methods().gettitle(  snap.data![i].path)));
  });
 }else if(snap.connectionState==ConnectionState.waiting){

  return CircularProgressIndicator();
 }
 
 
 else{
  return Text("erreur");

 }

    })
    );
  }
}