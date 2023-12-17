import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/fav_model/fav_model.dart';
import 'package:shopapp/models/login_model/home_model.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/modules/favourite_screen/favourite_screen.dart';
import 'package:shopapp/modules/home_screen/home_screen.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/modules/products_screen/products_Screen.dart';
import 'package:shopapp/modules/setting_screen/setting_screen.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/network/remote/end_points.dart';

import '../../models/category_model/categories_model.dart';
import '../../models/update_model/update_model.dart';
class homeCubit extends Cubit<homeStates>{
  homeCubit():super(homeInitState());

  static homeCubit get(context)=>BlocProvider.of(context);

  int NavIndex=0;
  void changeNavIndex(index){
    NavIndex=index;
    emit(changeNavIndexState());
  }

  List<Widget> appScreen=[homeScreen(),productsScreen(),favouriteScreen(),settingScreen()];

  String token=cashHelper.getDataFromSharedPref("token");

  homeModel? homeModelObj;
  Map<int,bool> myFavMap={};
  void getHomeData(){
    emit(homeLoadingDataState());

    dioHelper.getData(url: Home_EndPoint,quires: {},Authorization: cashHelper.getDataFromSharedPref("token"))
        .then((value){
          homeModelObj=homeModel.fromJson(value.data);
          print(homeModelObj!.homedata!.homeDataProduct[0].image.toString());
          homeModelObj!.homedata!.homeDataProduct.forEach((element) {
            myFavMap.addAll(
                {element.id: element.in_favorites}
            );
          });
          print(myFavMap);
      emit(homeSuccessDataState());

    })
        .catchError((error){
      print("Error while having home data:${error.toString()}");
      emit(homeErrorDataState());

    });


  }


  loginModel? userProfileModel;
  void getUserProfile(){
    emit(homeLoadingGetUserProfileStates());

    dioHelper.getData(url: "profile", quires: {},lang: "en",Authorization: token).then((value) {

      userProfileModel=loginModel.fromJson(value.data);
      print(" ************************************************ ${userProfileModel!.data!.name}88888888888888888888888888888888888888888888888888888888");
      emit(homeSuccessGetUserProfileStates());

    })
        .catchError((error){
          print("Error While get user profile : $error");
          emit(homeErrorGetUserProfiletates());
    });

  }








  FavModel? favModel;
  void PostAddFavourite(int id,index){
    myFavMap[id]=!myFavMap[id]!;
   // homeModelObj!.homedata!.homeDataProduct[index].in_favorites=!homeModelObj!.homedata!.homeDataProduct[index].in_favorites;
    emit(homeChangeFavByclick());
    dioHelper.postData(
      url: Favourite_EndPoint,
      dataToPost: {"product_id":id},
      lang: "en",
        Authorization: token
    )
        .then((value) {
          favModel=FavModel.fromJson(value.data);
          if(favModel!.status==false){
            myFavMap[id]=!myFavMap[id]!;
           // homeModelObj!.homedata!.homeDataProduct[index].in_favorites=!homeModelObj!.homedata!.homeDataProduct[index].in_favorites;
          }
          else{
            getAllFavourite();
          }
          print("FAVOURITE Message:${favModel!.message} ");
          emit(homeSuccessPostFav());
    }).catchError((error){
      myFavMap[id]=!myFavMap[id]!;
    //  homeModelObj!.homedata!.homeDataProduct[index].in_favorites=!homeModelObj!.homedata!.homeDataProduct[index].in_favorites;
        emit(homeErrorPostFav());

    });
    
    
    
  }


  CategoriesModel? categoriesModel;
  void getHomeProduct(){
    emit(homeCategoryLoadingGetProdcutStates());

    dioHelper.getData(url: Categories_EndPoint,lang: "en", quires: {})
        .then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      print("###################3${categoriesModel!.categoriesData!.currentPage.toString()}");
      emit(homeCategorySuccessGetProdcutStates());
    }).catchError((error){
      print("ERROR WHILE GET PRODUCT DATA: $error");
      emit(homeCategoryErrorGetProdcutStates());
    });


  }

 // AllFavModel? allFavModel;

  // void getHomeAllFav(){
  //   emit(homeFavLoadingGetProdcutStates());
  //
  //   dioHelper.getData(url: "favorites", quires: {},lang: "en",Authorization: token)
  //       .then((value) {
  //
  //     allFavModel=AllFavModel.fromJson(value.data);
  //
  //     // print(allFavModel!.allFavData.FavDataList[1].favDataItemDetails!.discount);
  //     emit(homeFavSuccessGetProdcutStates());
  //
  // }).catchError((error){
  //     print("ERROR WHILE GET HOME ALL FAVOURITES:$error");
  //     emit(homeFavErrorGetProdcutStates());
  //
  //   });
  //
  //
  // }


  AllFavModel? allFavModel;
  void getAllFavourite(){
    emit(homeFavLoadingGetProdcutStates());
    dioHelper.getData(url: "favorites",quires: {},Authorization:token,lang: "en" ).then((value) {
      allFavModel=AllFavModel.fromJson(value.data);
      print(allFavModel!.allFavData!.FavDataList[0].favDataItemDetails!.price);
      emit(homeFavSuccessGetProdcutStates());

    }).catchError((error){
      emit(homeFavErrorGetProdcutStates());
      print("ERROR WHILE GET ALL FAVOURITES : $error");

    });
  }



  void logOut(context){
    cashHelper.clearDataFromSharedPref(token).then((value) {
      if(value){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loginScreen(),), (route) => false);
      }
    });

  }

  // bool isFavourite=false;
  // void changeFavourite(){
  //   isFavourite=!isFavourite;
  //   emit(changeFavouriteState());
  // }

  updateModel? updateModelObj;
  void updateProfile(
      {
        required String name,
        required String phone,
        required String email,
        String? password,
        required String? image,

      }
      ) {
    emit(updateLoadingState());

    dioHelper.updateData(
        methodUrl: "update-profile",
        lang: "en",
        updatedDataMap: {
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
          "image": image
        },
        query: {},token: token

    ).then((value) {
      updateModelObj=updateModel.fromJson(value.data);
      print(updateModelObj!.message);
      print("Successfull  UPDATED : $value");
      getUserProfile();
      emit(updateSuccessState(updateModelObj!));

    }).catchError((error) {

      print("ERROR WHILE UPDATED : $error");
      emit(updateErrorState(error.toString()));

    });
  }



}