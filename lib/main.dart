
import 'places_search_map.dart';
import 'search_filter.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new App());
  }

}

final TextStyle textStyleGreen=TextStyle(
  
  color: Colors.blue[750],
  fontWeight: FontWeight.bold,
  fontSize: 42,
  
);
class App extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      theme:ThemeData(
        primarySwatch:Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
        ),
        body: Center(
          
          child: Center(child: Column(children: <Widget>[
           
            Container(
                child: Text('WELCOME\n       TO\n  VIRTUAL\n  TOURIST\n    GUIDE',style: textStyleGreen),alignment: Alignment.center,)
                ,
            Container(
              child: FloatingActionButton(
                
                onPressed:(){
                 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  MyHomePage()),
  );
              }),
            ),
                
          ])
            
          ),
        ),
      ),
    );
  }
 
   }

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Virtual Tourist Guide'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.all(75),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  MyPicturePage()),
  );},
                  child: Text('TAKE PICTURE'),
                  highlightElevation: 20.0,
                  highlightColor: Colors.pink[200],
                  padding: EdgeInsets.all(75),
                  color: Colors.lightBlue[100],
                  textColor: Colors.black,
                )),
                Container(
                margin: EdgeInsets.all(40),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  GoogleMapsSampleApp()),
  );
                  },
                  child: Text('GET NEAR-BY \n LOCATIONS'),
                  highlightElevation: 20.0,
                  highlightColor: Colors.pink[200],
                  padding: EdgeInsets.all(75),
                  color: Colors.lightBlue[100],
                  textColor: Colors.black,
                  
                )),
          ])),
        ));
  }
}

class MyPicturePage extends StatefulWidget {
  @override
  _MyPicturePageState createState() => _MyPicturePageState();
}
class _MyPicturePageState extends State<MyPicturePage> {
  File _image;
  String base64Image;
  _openGallery(BuildContext context) async{
    _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    List<int> imageBytes = _image.readAsBytesSync();
    // print(imageBytes);
    base64Image = base64Encode(imageBytes);
    //print('string is');
    //print(base64Image);
    //print("You selected gallery image : " + _image.path);
    setState(() {
    });
    Navigator.of(context).pop();
  }
  _openCamera(BuildContext context)async{
    _image = await ImagePicker.pickImage(source: ImageSource.camera);
    List<int> imageBytes = _image.readAsBytesSync();
    //print(imageBytes);
    base64Image = base64Encode(imageBytes);
    //print('string is');
    //print(base64Image);
    //print("You selected gallery image : " + _image.path)
    setState(() {
        });
    Navigator.of(context).pop();
  }
  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text('Choose a Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child:Text("Gallery"),
                onTap: (){
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child:Text("Camera"),
                onTap: (){
                  _openCamera(context);
                },
              )
            ]
          ),
        ),
      );
    });
  }
  Widget _isImage(){
    if(_image==null){
      return Text('No Image Selected !');
    }
    else{
      return Image.file(_image,width: 400,height: 400);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Image Detector')
      ),
      body: Container(
        child:Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[ 
            _isImage(),
            RaisedButton(onPressed: (){
              _showChoiceDialog(context);
            },child: Text('Select Image !'),
            )
          ],
        ),
        ),
      ),
    );
  }
}

class GoogleMapsSampleApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoogleMapSampleApp();
  }
}

class _GoogleMapSampleApp extends State<GoogleMapsSampleApp>{
  static String keyword = "Bakery";

  void updateKeyWord(String newKeyword) {
    print(newKeyword);
    setState(() {
      keyword = newKeyword;  
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Maps RW'),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                    icon: Icon(Icons.filter_list),
                    tooltip: 'Filter Search',
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    });
              },
            ),
          ],
        ),
        body: PlacesSearchMapSample(keyword),
        endDrawer: SearchFilter(updateKeyWord),
      ),
    );
  }
}
