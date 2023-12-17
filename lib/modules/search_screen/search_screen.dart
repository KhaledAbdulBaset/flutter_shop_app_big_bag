import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class searchScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
          child:Column(
            children: [
              Text("searchSCREEN",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),)
            ],
          )

      ),
    );
  }

}