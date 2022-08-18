import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class image_methods 

{


  Future get_images() async {
      // >> To get paths you need these 2 lines
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
    
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      // >> To get paths you need these 2 lines

      final imagePaths = manifestMap.keys
          .where((String key) => key.contains('assets/'))
          .where((element) => element.contains(".png") || element.contains(".jpg"))
          .toList();
    
      
      Random random = new Random();
int randomNumber = random.nextInt(imagePaths.length);
return imagePaths[randomNumber];

    }












}