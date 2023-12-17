import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/login_model/login_model.dart';
import 'package:shopapp/modules/login/login_cubit/login_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/network/remote/end_points.dart';
class loginCubit extends Cubit<loginStates>{
  loginCubit(): super(loginInitState());

  static loginCubit get(context) => BlocProvider.of(context);

  bool isVisiblePassword=false;
  IconData VisibleIcon=Icons.visibility_off_outlined;

  void changeVisibilityPassword(){
    isVisiblePassword=!isVisiblePassword;
    emit(changeVisibilityPasswordState());


  }

  late loginModel loginModelObj;

  void userLoginApi(
    @required String email,
      @required String password
      ) {

    emit(loginLoadingState());
     dioHelper.postData(
     url: Login_EndPoint,
        dataToPost: {
          "email":email,
          "password":password
    }).then((value) {
      print(value.data);
      loginModelObj=loginModel.fromJson(value.data);
      print(loginModelObj.status);
      print(loginModelObj.message);
       print(loginModelObj.data);
       print("Success");
      emit(loginSuccessState(loginModelObj));
 }).catchError((error){
   print("ERORR LOGIN STATE:$error");
   emit(loginErrorState(error.toString()));
 });
  }





}