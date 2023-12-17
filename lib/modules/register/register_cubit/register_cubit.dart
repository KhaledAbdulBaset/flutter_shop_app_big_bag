import 'package:shopapp/models/register_model/register_model.dart';
import 'package:shopapp/models/update_model/update_model.dart';
import 'package:shopapp/modules/register/register_cubit/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
class registerCubit extends Cubit<registerStates>{
  registerCubit ():super(registerInitState());

  static registerCubit get(context)=> BlocProvider.of(context);

  registerModel? registerModelObj;
  void postRegisterData(
  {
    required String name,
    required String phone,
    required String email,
    required String password,
    required String? image,

  }
      ){
    emit(registerLoadingState());
    dioHelper.postData(url: "register",
        dataToPost: {
      "name":name,"phone":phone,"email":email,"password":password,"image":image
    },lang: "en").then((value) {
      registerModelObj=registerModel.fromJson(value.data);
      print(registerModelObj!.message.toString());
      emit(registerSuccessState(registerModelObj!));
    }).catchError((error){
      emit(registerErrorState(error.toString()));
    });
  }


// updateModel? updateModelObj;
//   void updateProfile(
//       {
//         required String name,
//         required String phone,
//         required String email,
//         String? password,
//         required String? image,
//
//       }
//       ) {
//     emit(updateLoadingState());
//
//     dioHelper.updateData(
//         methodUrl: "update-profile",
//         lang: "en",
//         updatedDataMap: {
//           "name": name,
//           "phone": phone,
//           "email": email,
//           "password": password,
//           "image": image
//         },
//         query: {}
//
//     ).then((value) {
//       updateModelObj=updateModel.fromJson(value.data);
//       print(updateModelObj!.message);
//       emit(updateSuccessState(updateModelObj));
//
//     }).catchError((error) {
//       emit(updateErrorState(error.toString()));
//
//     });
//   }
//



}