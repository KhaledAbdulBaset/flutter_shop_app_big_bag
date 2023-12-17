import 'package:shopapp/models/category_model/categories_model.dart';
import 'package:shopapp/modules/products_screen/category_cubit/category_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

import '../../../shared/network/remote/end_points.dart';
class categoryCubit extends Cubit<categoryStates>{


  categoryCubit():super(categoryInitState());
  static categoryCubit get(context)=>BlocProvider.of(context);
  
  CategoriesModel? categoriesModel;
  void getProduct(){
    emit(categoryLoadingGetProdcutStates());

    dioHelper.getData(url: Categories_EndPoint,lang: "en", quires: {})
        .then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      print("###################3${categoriesModel!.categoriesData!.currentPage.toString()}");
      emit(categorySuccessGetProdcutStates());
    }).catchError((error){
      print("ERROR WHILE GET PRODUCT DATA: $error");
      emit(categoryErrorGetProdcutStates());
    });


  }

}