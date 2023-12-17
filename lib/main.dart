import 'package:flutter/material.dart';
import 'package:shopapp/layouts/home_layout.dart';
import 'package:shopapp/modules/favourite_screen/fav_cubit/fav_cubit.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/modules/products_screen/category_cubit/category_cubit.dart';
import 'package:shopapp/modules/register/register_cubit/register_cubit.dart';
import 'package:shopapp/observer.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/trial.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layouts/home_cubit/home_cubit.dart';
import 'modules/login/login_cubit/login_cubit.dart';
import 'modules/onboarding/opening_screen.dart';
import 'package:dio/dio.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Future<void> main() async {---> this is not ok
  // dioHelper dio=dioHelper();
  // dio..Inite();
  //DON'T MAKE OBJ JUST MAKE ALL THE CLASS STATIC
  // AND CALL IT BY IT'S NAME
  dioHelper.Inite();
  Bloc.observer = MyBlocObserver();
  await  cashHelper.InitSharedPrefrence();
  var isSkipOnBoarding=cashHelper.getDataFromSharedPref("skipOnBoarding");
  var token=cashHelper.getDataFromSharedPref("token");

  //List<Widget> currentScreen=[openingScreen(),loginScreen(),homeLayout()];
  //int currentScreenIndex=0;
  Widget widget;

  //if you skiped now you have to choose between login or home
  if(isSkipOnBoarding==true){
    if(token==null){
      widget=loginScreen();
     // currentScreenIndex=1;
    }//if token still null that is means you don't log in
    else{
      widget=homeLayout();
     // currentScreenIndex=2;
      // }//if token NOT null that is means you log in
  }}
  //if you skiped now you have to choose between login or home
  else{
    widget=openingScreen();
    //currentScreenIndex=0;
  }


  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget currentScreen;
  MyApp(this.currentScreen);

  @override
  Widget build(BuildContext context) {
   return MultiBlocProvider(
     providers: [
       BlocProvider(create: (BuildContext context) { return homeCubit()..getHomeData()..getHomeProduct()..getAllFavourite()..getUserProfile(); }),
       BlocProvider(create: (BuildContext context) { return loginCubit(); },),
       //,BlocProvider(create: (BuildContext context) { return categoryCubit()..getProduct(); },)
       //,BlocProvider(create: (BuildContext context) { return favCubit()..getAllFavourite(); },)
       BlocProvider(create: (BuildContext context) { return registerCubit(); },)

     ],
     child: MaterialApp(
       theme: ThemeData(
         appBarTheme: AppBarTheme(
           backgroundColor: Colors.white
         ),
         scaffoldBackgroundColor: Colors.white
       ),
       themeMode: ThemeMode.light,
       debugShowCheckedModeBanner: false,
       home: currentScreen
       // home:currentScreen
     ),
   );
  }


}