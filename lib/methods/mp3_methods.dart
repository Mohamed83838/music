import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Mp3_Methods {


  Future<List<FileSystemEntity>> getallmusic() async {
    List<FileSystemEntity> _files = [];
    List<FileSystemEntity> _musics = [];
    List<String>_paths=[];

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      final directory = await getApplicationDocumentsDirectory();
      final dir = directory.path;
      String pdfDirectory = '$dir/';
      final myDir = new Directory("/storage/emulated/0/");

      _files = myDir.listSync(recursive: true, followLinks: false);
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final dir = directory.path;
      String pdfDirectory = '$dir/';
      final myDir = new Directory("/storage/emulated/0/");

      _files = myDir.listSync(recursive: true, followLinks: false);
    }
    int a = _files.length;
    for (var i = 0; i < a; i++) {
      if (_files[i].path.toString().endsWith('.mp3')) {
        _musics.add(_files[i]);
        _paths.add(_files[i].path);
      }
    }

    return _musics;
  }

  String gettitle(String path){
    String title="";
int len=path.length;
int last=0;
for (var i = 0; i < len; i++) {

  if(path[i]=="/"){

  last=i;
  
  }
}


   for (var i = last+1; i < len-4; i++) {
     title=title+path[i];
   }
return title;
  }

  Future<List<FileSystemEntity>> searchforsong(String value)async{

    List<FileSystemEntity> _musics = await getallmusic();
    List<FileSystemEntity> _results = [];

   _results= _musics.where((element) => element.path.toString().toLowerCase().contains(value.toLowerCase())).toList();

return _results;
  }
}
