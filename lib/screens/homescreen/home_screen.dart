import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_fraj/methods/get_image.dart';
import 'package:music_fraj/screens/homescreen/component.dart';
import 'package:music_fraj/screens/player_screen/player_screen.dart';
import 'package:provider/provider.dart';

import '../../methods/mp3_methods.dart';
import '../../providers/music_provider.dart';
import '../see_all.dart';

class home_screen extends StatefulWidget {
  const home_screen({Key? key,  this.is_playing :false}) : super(key: key);
  final bool is_playing;

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  void initState() {
    // TODO: implement initState
    
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }
  TextEditingController _search=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _search.dispose();
    super.dispose();
  }
bool _selectcard=false;
    bool is_searching=false;
    
  Widget build(BuildContext context) {
AudioPlayer player= context.watch<music_provider>().player;
    bool state=context.watch<music_provider>().state;
    bool music=context.watch<music_provider>().music;

    
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.2),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
          gradient: LinearGradient(
              colors: [HexColor("#6441A5"), HexColor("#2a0845")])),
      child: Scaffold(
 

        bottomNavigationBar: InkWell(
          onTap: (){
                       Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => player_screen(path:context.watch<music_provider>().path , title:context.watch<music_provider>().title ),)
                                  );
          },
          child: Visibility(
            visible:music,
            child: Container(
             
          decoration: BoxDecoration(
        color:   Color.fromARGB(255, 5, 10, 63),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
          ),
              width: double.infinity,
              height: 75,
              
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                       Container(
                  height: 50,
                  width: 50,
                   decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),        
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "assets/love.png"))),
            ),
            SizedBox(width: 10,),
            Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(context.watch<music_provider>().title,style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize:14,fontWeight: FontWeight.normal),),
                     Text("desc",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize:10,fontWeight: FontWeight.normal),),
                  ],
          
            ),
            Expanded(child: SizedBox()),
            IconButton(

              
              splashColor: Colors.transparent,
              
              onPressed: (){
        
              if(state){
       context.read<music_provider>().pause();
  context.read<music_provider>().pausesong();
        
              }else{
         context.read<music_provider>().play();
context.read<music_provider>().playy();
        
              }
            }, icon: Icon(
              state?
              Icons.pause:Icons.play_arrow,color:Colors.white,size:30),splashRadius: 20,),
            IconButton(splashColor: Colors.transparent,onPressed: (){
               context.read<music_provider>().stop();
  context.read<music_provider>().stopsong();
            }, icon: Icon(Icons.cancel,color:Colors.white,size: 30,),splashRadius: 20,),
          
                    ],
                    
                    
                  ),
                  SizedBox(height: 5,),
                  StreamBuilder<Duration?>(
            stream: player.durationStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration(seconds: 1);
              return StreamBuilder<Duration>(
                stream: player.positionStream,
                builder: (context, snapshot) {
                  var position = snapshot.data ?? Duration.zero;
                  if (position > duration) {
                    position = duration;
                  }
                   if(position==duration){
                    
                   
                  }
                
                  return  Container(
                  margin:EdgeInsets.symmetric(horizontal: 6) ,
                  height: 3,
                   child: LinearProgressIndicator(
                    value: position.inSeconds/duration.inSeconds,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                   ),
                 );
                },
              );
            },
          ),
                
                ],
              ),
            ),
          ),
        ),
 
  

        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5), fontSize: 16),
                      ),
                      Text(
                        "Fraj!",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/solo.png"),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.4)),
                child: TextField(
                  controller: _search,

                  onChanged: (data){
                    setState(() {
                         is_searching=true;
                     
                    });
                  },
                  onSubmitted: (value){
                    setState(() {
                      is_searching=false;
                    });
                  },
                    style: TextStyle(color:Colors.white),
                  decoration: InputDecoration(
                    
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    alignLabelWithHint: false,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    
                    hintText: "Search for new music",
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: !(is_searching),
                child: Container(
                  width: double.infinity,
                  height: 172,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.4),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                              'assets/ad.jpg'))),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Icon(
                            Icons.music_note,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Go find your",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "favorites",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "The songs being discovered",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    "around the world right now",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.purple,
                                child: Center(
                                  child: Icon(Icons.arrow_forward),
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(!(is_searching)?
                    "Latest songs played":"Search ",
                    style: TextStyle(
                        color: Colors.white.withOpacity(1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: SizedBox()),
                   InkWell(
                    onTap:(){
                              Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => see_all(),)
                                  );
                    },
                     child: Text("see all",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8
                          ),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                                     ),
                   ),
                ],
              ),
              SizedBox(height: 20,),
              FutureBuilder(
                  future: !(is_searching)? Mp3_Methods().getallmusic():Mp3_Methods().searchforsong(_search.text),
                  builder: (BuildContext context, AsyncSnapshot<List> snap) {
                  
                    
                    if (snap.hasData) {
                      return Expanded(
                        
                        child: ListView.builder(
                            itemCount: snap.data!.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: (){
                                              Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => player_screen(path: snap.data![i].path, title: Mp3_Methods().gettitle(snap.data![i].path,)),)
                                  );
                                   
                                  
                                  
                                  
                                },
                                child: FutureBuilder(future: image_methods().get_images(),builder:(BuildContext context,AsyncSnapshot snapyy ){
                                 if(snapyy.hasError){
                                  return CircularProgressIndicator();
                                 }else if(snap.hasData){
 return  music_card(Mp3_Methods().gettitle(snap.data![i].path), "The weekend", false,snapyy.data);
                                 }else{
                                  return Text("fgg");
                                 }
                                 
                                 
                                 
                                })

                                
                                );
                              
                        }
                        )
                      );
                    } else if (snap.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return Text("erreur");
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
