import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_fraj/methods/mp3_methods.dart';

class music_provider with ChangeNotifier{
AudioPlayer player = AudioPlayer();  
AudioPlayer get _player =>player;










  bool _isplaying=false;
  bool get state=> _isplaying ;
    bool music=false;
  bool get navbar=> music ;
      bool _sound=true;
  bool get sound=> _sound ;
  String _title="";
  String get title=>_title;
    String _path="";
  String get path=>_path;

  int _duration=0;
  int get duration =>_duration;

      bool _loop=false;
  bool get loop=> _loop ;


void finish1(){
  _isplaying=false;
music=false;
notifyListeners();
}

  void finish(){
_isplaying=false;
music=false;
  player.stop();
  notifyListeners();

}


void setloop1(){
    
  _loop=true;
  notifyListeners();
}
void setloop(){
    _player.setLoopMode(LoopMode.one);
  _loop=true;
  notifyListeners();
}
void cancelloop1(){
    
  _loop=false;
  notifyListeners();
}

void cancelloop(){
    _player.setLoopMode(LoopMode.one);
  _loop=false;
  notifyListeners();
}









 void stopsound(){

  _player.setVolume(0);
  _sound=false;
  notifyListeners();

 }
 void stopsound1(){

  
  _sound=false;
  notifyListeners();

 }
 void playsound(){
  _player.setVolume(100);
_sound=true;
  notifyListeners();
 }
 void playsound1(){
  
_sound=true;
  notifyListeners();
 }
  
  

void get_duration(String path){
  final player1 = AudioPlayer();  
  player1.setFilePath(path);
  _duration=player1.duration!.inSeconds ;
  
  print(_duration);
 notifyListeners();
}








void play(){
  _isplaying=true;
  music=true;
 
  print(player.position.inSeconds);

}
void pause(){
  _isplaying=false;
 
}


  void playsong(String path)async{
_isplaying=true;
music=true;
final duration = await player.setFilePath(path);
 _title=Mp3_Methods().gettitle(path);
 
 _path=path;
 notifyListeners();
player.play();



  }
    void playy()async{


 _isplaying=true;

 notifyListeners();
player.play();



  }
  void stopsong(){
    
    _isplaying=false;
    music=false;
    notifyListeners();
    player.stop();
  }
  void stop(){
    _isplaying=false;
    music=false;
    notifyListeners();
  }

   void pausesong(){
    
    _isplaying=false;
 

    notifyListeners();
    player.pause();
  }
  void unpausesong(){
    

    notifyListeners();
    player.play();
  }





}