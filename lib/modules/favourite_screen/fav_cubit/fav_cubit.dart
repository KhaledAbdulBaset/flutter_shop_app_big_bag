// import 'package:shopapp/models/fav_model/fav_model.dart';
// import 'package:shopapp/modules/favourite_screen/fav_cubit/fav_states.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bloc/bloc.dart';
// import 'package:shopapp/shared/network/local/cash_helper.dart';
// import 'package:shopapp/shared/network/remote/dio_helper.dart';
// class favCubit extends Cubit<favStates>{
//
//   favCubit():super(favInitState());
//
//   static favCubit get(context)=>BlocProvider.of(context);
//   String? token=cashHelper.getDataFromSharedPref("token");
//
//    AllFavModel? allFavModel;
//   void getAllFavourite(){
//     emit(favLoadingGetState());
//     dioHelper.getData(url: "favorites",quires: {},Authorization:token,lang: "en" ).then((value) {
//      allFavModel=AllFavModel.fromJson(value.data);
//      print(allFavModel!.allFavData!.FavDataList[0].favDataItemDetails!.price);
//       emit(favSuccessGetState());
//
//     }).catchError((error){
//       emit(favErrorGetState());
//       print("ERROR WHILE GET ALL FAVOURITES : $error");
//
//     });
//   }
//
// }