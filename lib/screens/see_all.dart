import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:music_fraj/screens/player_screen/player_screen.dart';

import '../methods/mp3_methods.dart';
import 'homescreen/component.dart';

class see_all extends StatefulWidget {
  const see_all({Key? key}) : super(key: key);

  @override
  State<see_all> createState() => _see_allState();
}
bool is_searching=false;
TextEditingController _search=TextEditingController();

class _see_allState extends State<see_all> {
  @override
  void dispose() {
    // TODO: implement dispose
    _search.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.2),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
          gradient: LinearGradient(
              colors: [HexColor("#6441A5"), HexColor("#2a0845")])),
      child: Scaffold(
backgroundColor: Colors.transparent,

     
            body:
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
          children: [
              SizedBox(height: 20,),
               Row(
                        children: [
                          IconButton(
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
                            "find your music",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
                          ))),
                          Icon(
                            Icons.menu,
                            color: Colors.white.withOpacity(0.6),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
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
                                  child: music_card(Mp3_Methods().gettitle(snap.data![i].path), "The weekend", false, "assets/love.png"));
                                
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
            )
            
            
    
            );
  }
}