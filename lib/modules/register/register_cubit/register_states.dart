import 'package:shopapp/models/register_model/register_model.dart';
import 'package:shopapp/models/update_model/update_model.dart';

abstract class registerStates{}
class registerInitState extends registerStates{}

class registerLoadingState extends registerStates{}
class registerSuccessState extends registerStates{
  final registerModel registerModelObj;
  registerSuccessState(this.registerModelObj);
}
class registerErrorState extends registerStates{
  final String? error;
  registerErrorState(this.error);
}

// class updateLoadingState extends registerStates{}
//
// class updateSuccessState extends registerStates{
//   updateModel updateModelObj;
//   updateSuccessState(this.updateModelObj);
//
// }
// class updateErrorState extends registerStates{
//  String error;
// updateErrorState(this.error);
// }


