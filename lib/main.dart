import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

void main(){
  runApp(
    MaterialApp(
      title: "IO",
      home: Home(),
    )
  );
}

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home>{
  final _enterData=TextEditingController();
  String _savedData;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }
  _loadSavedData()async{
    SharedPreferences preferances=await SharedPreferences.getInstance();

    setState(() {
      if(preferances.getString('data')!=null && preferances.getString("data").isNotEmpty){
        _savedData=preferances.getString('data');
      }else{
        _savedData='';
      }
    });
  }
  _saveData(String str)async{
    SharedPreferences preference=await SharedPreferences.getInstance();
    preference.setString("data", str);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Read/Write'),
        centerTitle:true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller:_enterData,
            decoration: InputDecoration(
              labelText:'Write Something',
            ),
          ),
          subtitle: FlatButton(
            onPressed: (){
              _saveData(_enterData.text);
            },
            child: Column(
              children: <Widget>[
                Text('Save Data'),
                Padding(padding: EdgeInsets.all(14.5),),
                Text(_savedData),
              ],
            ),
          ),  
        ),
      ),
    );
  }

}
