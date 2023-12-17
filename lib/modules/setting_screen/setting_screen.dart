import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/modules/register/register_cubit/register_cubit.dart';
import 'package:shopapp/modules/register/register_cubit/register_states.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';

import '../login/login_screen.dart';

class settingScreen extends StatelessWidget{
  var profileName=TextEditingController();
  var profileEmail=TextEditingController();
  var profilePhone=TextEditingController();
  var _scaffoldKey=GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<homeCubit,homeStates>(
      builder: (BuildContext context, homeStates state) {

        profileName.text=homeCubit.get(context).userProfileModel!.data!.name!;
        profileEmail.text=homeCubit.get(context).userProfileModel!.data!.email!;
        profilePhone.text=homeCubit.get(context).userProfileModel!.data!.phone!;



        return  Scaffold(
          key: _scaffoldKey,
          body: SafeArea(
              child:SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                            clipper:  CustomClipperProfileClass1(),
                            child: Container(height: 250,width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[Colors.black87,Colors.pink,Color(0xff650015)]

                                  )
                              ),

                            )),
                        ClipPath(
                            clipper:  CustomClipperProfileClass3(),
                            child: Container(height: 250,width: double.infinity,

                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      colors: <Color>[Colors.purple,Colors.pink,Color(0xff650015)]

                                  )
                              ),

                            )),
                        ClipPath(
                            clipper:  CustomClipperProfileClass2(),
                            child: Container(height: 200,width: double.infinity,

                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[Color(0xff182232),Colors.pink,Color(0xff650015)]))
                              //
                              //     )
                              // ),


                            )),
                        ClipPath(
                            clipper:  CustomClipperProfileClass2(),
                            child: Container(
                                height: 170,width: double.infinity,color: Colors.grey[100],
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(shape: BoxShape.circle),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,

                                        child: Image(image: NetworkImage("${homeCubit.get(context).userProfileModel!.data!.image}"),fit: BoxFit.fill,)),
                                    Text("${profileName.text}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)

                                  ],
                                )

                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0,bottom: 20.0,left: 20,right: 20),
                      child: Column(children: [
                        if(state is updateLoadingState)
                        LinearProgressIndicator(
                          color: Colors.deepPurpleAccent,
                          backgroundColor: CupertinoColors.systemGrey5,
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: profileName,
                          decoration: InputDecoration(
                              hintText: "Name",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder()
                          ),

                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: profileEmail,
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder()
                          ),

                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: profilePhone,
                          decoration: InputDecoration(
                              hintText: "phone",
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder()
                          ),

                        ),
                        SizedBox(height: 10,),
                        BlocConsumer<registerCubit,registerStates>(
                          builder: (BuildContext context, registerStates state) {

                            return  MaterialButton(onPressed: (){
                              homeCubit.get(context).updateProfile(name: profileName.text, phone: profilePhone.text, email: profileEmail.text , image: "");
                            }
                              ,child: Container(height: 50,width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xff182232),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Text("Update",style: TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.w700),),
                              ),);
                          }, listener: (BuildContext context, registerStates state) {  },
                        ),

                        SizedBox(height: 10,),
                        MaterialButton(onPressed: (){
                          //homeCubit.get(context).logOut(context);
                          cashHelper.clearDataFromSharedPref("token").then((value) {
                            if(value){
                              print(value);
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loginScreen(),), (route) => false);
                            }
                          });
                        },child: Container(height: 50,width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xff650000),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Text("LOG OUT",style: TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.w700),),
                        ),)

                      ],),
                    )

                  ],
                ),
              )

          ),
        );
      },
      listener: (BuildContext context, homeStates state) {

        if(state is updateSuccessState){
         if(state!.updateModelObj!.status==true){
           print(state.updateModelObj.message);
           _scaffoldKey.currentState!.showBottomSheet((context) =>
               Container(alignment: Alignment.center,color: Colors.green.withOpacity(0.9),height: 50,width: double.infinity,
                   child: Text("${state.updateModelObj.message}",style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.w700),)));


         }
         else{
           print(state.updateModelObj.message);
         _scaffoldKey.currentState!.showBottomSheet((context) =>
    Container(alignment: Alignment.center,color: Colors.red.withOpacity(0.9),height: 50,width: double.infinity,
    child: Text("${state.updateModelObj.message}",style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.w700),)));
    }
        }

      },

    );
  }

}


class CustomClipperProfileClass2 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    double w=size.width;
    double h=size.height;

    final path=Path();

    path.lineTo(0, 0.7*h);
    path.quadraticBezierTo(0.6*w, h, w, 0.7*h);
    path.lineTo(w, 0);
    path.close();


    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}

class CustomClipperProfileClass1 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    double w=size.width;
    double h=size.height;

    final path=Path();

    path.lineTo(0, 0.8*h);
    path.quadraticBezierTo(0.4*w, h, w, 0.6*h);
    path.lineTo(w, 0);
    path.close();


    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}

class CustomClipperProfileClass3 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    double w=size.width;
    double h=size.height;

    final path=Path();

    path.lineTo(0, 0.6*h);
    path.quadraticBezierTo(0.8*w, 0.85*h, w, 0.8*h);
    path.lineTo(w, 0);
    path.close();


    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}