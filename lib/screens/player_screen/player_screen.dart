import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_fraj/methods/get_image.dart';
import 'package:provider/provider.dart';

import '../../providers/music_provider.dart';

class player_screen extends StatefulWidget {
  const player_screen({Key? key, required this.path, required this.title})
      : super(key: key);
  final String path;
  final String title;

  @override
  State<player_screen> createState() => _player_screenState();
}

class _player_screenState extends State<player_screen> {
  final player = AudioPlayer();
  bool finish=false;
  bool is_playing = false;
  bool _isplaying = false;
  @override
  void initState() {
    // TODO: implement initState
    if(finish){
     
                    context.read<music_provider>().finish1();
                    context.read<music_provider>().finish();
                  
    }

 
    super.initState();

   
  }
 

  @override
  Widget build(BuildContext context) {

    bool state = context.watch<music_provider>().state;
    String pathe = context.watch<music_provider>().path;
    bool sound=context.watch<music_provider>().sound;
    bool loop=context.watch<music_provider>().loop;
       AudioPlayer player= context.watch<music_provider>().player;
  
    return Container(
        decoration: BoxDecoration(
            color: Colors.transparent.withOpacity(0.2),
            gradient: LinearGradient(
                colors: [HexColor("#6441A5"), HexColor("#2a0845")])),
        child: Scaffold(
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
                          IconButton(
                              splashRadius: 25,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white.withOpacity(0.6),
                              )),
                          Expanded(
                              child: Center(
                                  child: Text(
                            widget.title.substring(0, 15),
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
                          ))),
                          Icon(
                            Icons.menu,
                            color: Colors.white.withOpacity(0.6),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: image_methods().get_images(),
                          builder: (BuildContext context, AsyncSnapshot snap) {
                            return Container(
                              height: 400,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withOpacity(0.5),
                                  image: DecorationImage(
                                      image: AssetImage(snap.data))),
                            );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                       Text(
                            widget.title.substring(0,9),
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15),
                          ),
                      
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Mohammed Fraj",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          pathe==widget.path?
                          StreamBuilder<Duration>(
                stream: player.positionStream,
                builder: (context, snapshot) {
                  var position = snapshot.data ?? Duration.zero;
                 
                  return Text(
                            position.inMinutes.toString()+":"+(position.inSeconds).toString(),
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15),
                          );
                },
              ):Text("00:00", style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15),),
                          Expanded(

                              child:pathe==widget.path? StreamBuilder<Duration?>(
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
                   
                   
                       finish=true;
                   
                   
                   
                  }
                 
                  return Slider(value: position.inSeconds.toDouble(),
                  onChangeStart:(v){
                    player.seek(Duration(seconds:v.toInt()));
                  },
                   onChanged: (v){
                    player.seek(Duration(seconds:v.toInt()));
                  
                  },max: duration.inSeconds.toDouble(),min:0);
                },
              );
            },
          ):Slider(value: 0, onChanged: (v){},max: 100,min:0)),

          pathe==widget.path?
          StreamBuilder<Duration?>(
            stream: player.durationStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration.zero;
              return Text(
                            duration.inMinutes.toString()+":"+duration.inSeconds.toString(),
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15),
                          );
            },
          ): Text(
                            "00:00",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15),
                          )
         
                         


                        ],
                      ),
                      SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){
                           
                            if(!sound){

 setState(() {
                            context.read<music_provider>().playsound1();
                             
                           });
                           context.read<music_provider>().playsound();

                           
                            }else{
                              
                               setState(() {
                                context.read<music_provider>().stopsound1();
                             
                           });
                           context.read<music_provider>().stopsound();
                           
                          
                            }
                           


                          }, icon: Icon(sound?  Icons.speaker :Icons.speaker_notes_off),iconSize: 30,splashRadius: 20,color: Colors.white.withOpacity(0.8),),
                        IconButton(onPressed: (){}, icon: Icon(Icons.skip_previous),iconSize: 30,splashRadius: 20,color: Colors.white.withOpacity(0.8),),

                          GestureDetector(
                            onTap: () async {
                              if (pathe == widget.path) {
                                if (state) {
                                  context.read<music_provider>().pause();
                                  context.read<music_provider>().pausesong();
                                  setState(() {});
                                } else {
                                  context.read<music_provider>().play();
                                  context.read<music_provider>().playy();
                                  setState(() {});
                                }
                              } else {
                                if (!_isplaying) {
                                  context.read<music_provider>().play();
                                  context
                                      .read<music_provider>()
                                      .playsong(widget.path);
                                  setState(() {});
                                } else {
                                  context.read<music_provider>().pause();
                                  context.read<music_provider>().pausesong();
                                  setState(() {});
                                }
                              }
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color.fromARGB(255, 5, 10, 63),
                              child: Center(
                                child: pathe == widget.path
                                    ? !state
                                        ? Icon(Icons.play_arrow)
                                        : Icon(Icons.pause)
                                    : !_isplaying
                                        ? Icon(Icons.play_arrow)
                                        : Icon(Icons.pause),
                              ),
                            ),
                          ),
                          IconButton(onPressed: (){}, icon: Icon(Icons.skip_next),iconSize: 30,splashRadius: 20,color: Colors.white.withOpacity(0.8),),
                        IconButton(onPressed: (){
                          print(loop);
                          if(loop){
                            setState(() {
                                 context.read<music_provider>().cancelloop1(); 
                            });
                        
context.read<music_provider>().cancelloop();
                            
                          }else{
                            setState(() {
              context.read<music_provider>().setloop1();                
                            });

context.read<music_provider>().setloop();
                          }

                            
                        }, icon: Icon(loop?Icons.tour :Icons.loop),iconSize: 30,splashRadius: 20,color: Colors.white.withOpacity(0.8),),

                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Text("Made by mohammed",
                      style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 15),
                      ),
                      ],)
                    ]))));
  }
}
