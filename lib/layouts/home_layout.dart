import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/modules/search_screen/search_screen.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class homeLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<homeCubit,homeStates>(
      builder: (BuildContext context, homeStates state) {
        homeCubit homeCubitObj=homeCubit.get(context);
        return ConditionalBuilder(
            condition: homeCubitObj.homeModelObj!=null,
            builder: (context) => Scaffold(
                appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(height:40,width:40,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),clipBehavior: Clip.antiAliasWithSaveLayer,child: Image(image: NetworkImage("https://img.freepik.com/premium-vector/womans-red-flat-beach-bag-women-accessory-vector-premium-illustration_628688-133.jpg?w=2000"),fit: BoxFit.fill,)),
                ),
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[Color(0xff182232),Colors.pink,Color(0xff650015),]
                        )
                    ),
                  ),
                  elevation: 0,
                  title: Container(width: double.infinity,alignment: Alignment.center,child: Text("BIG BAG",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),)),
                  actions: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => searchScreen(),));

                    }, icon: Icon(Icons.search))
                  ],

                ),
                bottomNavigationBar: BottomNavigationBar
                  (
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Color(0xff650015),
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  onTap: (value){
                    homeCubitObj.changeNavIndex(value);
                  },
                  currentIndex: homeCubitObj.NavIndex,
                  items: [
                    BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
                    BottomNavigationBarItem(icon: Icon(Icons.apps),label: "Category"),
                    BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded),label: "Favourite"),
                    BottomNavigationBarItem(icon: Icon(Icons.settings ),label: "Settings")

                  ],),
                body: homeCubitObj.appScreen[homeCubitObj.NavIndex]

              // Row(
              //     children: [
              //       MaterialButton(
              //           onPressed: (){
              //             cashHelper.clearDataFromSharedPref("token").then((value) {
              //               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loginScreen(),), (route) => false);
              //             });
              //           }
              //           ,child: Text("LogOut",style:TextStyle(fontSize: 20,color: Colors.red),))
              //     ]),

            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),);
      },
      listener: (BuildContext context, homeStates state) {  },

    );
  }

}