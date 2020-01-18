import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() => runApp(Pixabay());
class Pixabay extends StatefulWidget {

  @override
  _PixabayState createState() => _PixabayState();
}

class _PixabayState extends State<Pixabay> {
  Map image;
  // bror kas the same variable 
  List imgList;
  Future getPixabay() async{
    http.Response response = await http.get("https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=yellow+flowers&image_type=photo&pretty=true");
    image = json.decode(response.body);
    setState(() {
      // put name oy the smae variable 
     imgList = image['hits']; 
    });
  }
  @override
  void initState() {
    super.initState();
    getPixabay();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // put title oy nv kondal
          title: Text('Pixabay'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: imgList == null ? 0 : imgList.length,
          itemBuilder: (context, i) {
            return Card(
              child: Column(
                children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Image.network(imgList[i]['largeImageURL']),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       // oy vea kleat pi ak mainAxisAlignment kerr chea ak dek
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: CircleAvatar(
                             backgroundImage:NetworkImage(imgList[i]['largeImageURL']),
                           ),
                         ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text("${imgList[i]['tags']}",
                             style: TextStyle(color: Colors.pink),
                             ),
                           ),
                           IconButton( icon: Icon(Icons.share, color:Colors.green,),),
                           IconButton( icon: Icon(Icons.favorite, color:Colors.pink,),),
                       ],
                     ),
                   )
                ],
                  
              ),
            );
          }
        ),
      ),
      
    );
  }
}