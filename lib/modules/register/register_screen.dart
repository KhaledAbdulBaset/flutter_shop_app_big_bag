import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/layouts/home_layout.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/modules/register/register_cubit/register_cubit.dart';
import 'package:shopapp/modules/register/register_cubit/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';
class registerScreen extends StatelessWidget{
  var registerNameController=TextEditingController();
  var registerPhoneController=TextEditingController();
  var registerEmailController=TextEditingController();
  var registerPasswordController=TextEditingController();
  var _formKey=GlobalKey<FormState>();
  var _scaffoldkey=GlobalKey<ScaffoldState>();
 int validation(){
    if(_formKey.currentState!.validate()){
      print("Validate");
      return 1;
    }
    else{
      print("Validate");
      return 0;
    }
  }
  @override
  Widget build(BuildContext context) {
  return BlocConsumer<registerCubit,registerStates>(
    builder: (BuildContext context, registerStates state) {
      registerCubit registerCubitObj=registerCubit.get(context);
      return   Form(
        key: _formKey,
        child: Scaffold(
          key: _scaffoldkey,
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  height:double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[Color(0xff650015),Colors.black87]
                      )
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
                Container(
                  height:800,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(600)),
                      boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 20),
                          blurRadius: 1,
                          spreadRadius: 7
                      )],
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[Colors.purple,Colors.black]
                      )
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
                Container(
                  height:640,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(0, 20),
                          blurRadius: 1,
                          spreadRadius: 7
                      )],
                      // gradient: LinearGradient(
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //     colors: <Color>[Colors.white]
                      // ),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(700))
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0,right: 50,top: 30,bottom: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40))) ,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Image(image: NetworkImage("https://kit8.net/wp-content/uploads/2020/12/MNC_cash_register_preview@2x.jpg"),fit: BoxFit.fill,),
                                Container(
                                    height: 30,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    color: Colors.black.withOpacity(0.5),
                                    child: Text("SIGN UP",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),))
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: registerNameController,
                        validator: (String? value){
                          if(value==null||value.length<3){
                            return "please write suitable name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "name",
                            prefixIcon: Icon(Icons.person),
                            border:  OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: registerPhoneController,
                        validator: (String? value){
                          if(value==null||value.length<3){
                            return "please write suitable phone";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Phone",
                            prefixIcon: Icon(Icons.phone),
                            border:  OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: registerEmailController,
                        validator: (String? value){
                          if(value==null||value.length<3){
                            return "please write suitable email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border:  OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: registerPasswordController,
                        validator: (String? value){
                          if(value==null||value.length<3){
                            return "please write suitable password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "password",
                            prefixIcon: Icon(Icons.lock),
                            border:  OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loginScreen(),), (route) => false);

                          }, icon: CircleAvatar(backgroundColor: Color(0xff182232),child: Icon(Icons.arrow_back_ios_new,color: Colors.white,),)),
                          ConditionalBuilder(
                            condition: state is!registerLoadingState,
                            builder: (BuildContext context) { return  MaterialButton(onPressed: (){
                              validation();
                              if(validation()==1){
                                registerCubitObj.postRegisterData(name: registerNameController.text, phone: registerPhoneController.text, email: registerEmailController.text, password: registerPasswordController.text, image: "");
                              }

                            },child: Container(height: 50,width: 100,alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[Colors.pink,Color(0xff650015)])
                              ),
                              child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),),
                            ),); },
                            fallback: (BuildContext context) {return Center(child: CircularProgressIndicator()); },

                          )
                        ],),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     MaterialButton(onPressed: (){},child:
                      //     Container(height: 50,width: 90,alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.all(Radius.circular(20)),
                      //           gradient: LinearGradient(
                      //               begin: Alignment.centerLeft,
                      //               end: Alignment.centerRight,
                      //               colors: <Color>[Colors.pink,Color(0xff650015)])
                      //       ),
                      //       child: Row(
                      //         children: [
                      //           Icon(Icons.arrow_back_ios_new),
                      //           Text("Log in",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),),
                      //         ],
                      //       ),
                      //     ),),
                      //   ],
                      // ),

                    ],),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }, listener: (BuildContext context, registerStates state) {
      if(state is registerSuccessState){
        if(state.registerModelObj.status==true){
          print(state.registerModelObj.message);
          _scaffoldkey.currentState!.showBottomSheet((context) =>
              Container(alignment: Alignment.center,color: Colors.green.withOpacity(0.9),height: 50,width: double.infinity,
                  child: Text("${state.registerModelObj.message}",style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.w700),)));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loginScreen(),), (route) => false);
        }
        if(state.registerModelObj.status==false){
          print(state.registerModelObj.message);
          _scaffoldkey.currentState!.showBottomSheet((context) =>
          Container(alignment: Alignment.center,color: Colors.red.withOpacity(0.9),height: 50,width: double.infinity,
              child: Text("${state.registerModelObj.message}",style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.w700),)));


            // ,duration: Duration(seconds: 4),);

          // showSnackBar(
          //     SnackBar(content:
          //     Container(color: Colors.pink,height: 100,width: 100,
          //         child: Text("${state.registerModelObj.message}"))
          //     // ,duration: Duration(seconds: 4),
          //     ));
        }

      }
      // if(state is registerErrorState){
      //   _scaffoldkey.currentState!.showSnackBar(
      //       SnackBar(content: Container(height: 100,width: 100,color:Colors.red,child: Text("${state..error}"))
      //         ,duration: Duration(seconds: 4),
      //
      //       ));
      //
      // }


  },
  );
  }

}
class CustomClipperClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    double w=size.width;
    double h=size.height;

    final path=Path();


    path.lineTo(0, 0.3*h);
    path.quadraticBezierTo(0.5*w, 0.5*h, w, 0.3*h);
    path.lineTo(w,0 );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}