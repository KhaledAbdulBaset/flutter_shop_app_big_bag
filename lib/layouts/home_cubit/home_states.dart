import '../../models/update_model/update_model.dart';

abstract class homeStates{}

class homeInitState extends homeStates{}
class changeNavIndexState extends homeStates{}

class homeLoadingDataState extends homeStates{}
class homeSuccessDataState extends homeStates{}
class homeErrorDataState extends homeStates{}
class changeFavouriteState extends homeStates{}

class homeSuccessPostFav extends homeStates{}
class homeErrorPostFav extends homeStates{}


class homeChangeFavByclick extends homeStates{}


class homeCategoryLoadingGetProdcutStates extends homeStates{}
class homeCategorySuccessGetProdcutStates extends homeStates{}
class homeCategoryErrorGetProdcutStates extends homeStates{}

class homeFavLoadingGetProdcutStates extends homeStates{}
class homeFavSuccessGetProdcutStates extends homeStates{}
class homeFavErrorGetProdcutStates extends homeStates{}

class homeLoadingGetUserProfileStates extends homeStates{}
class homeSuccessGetUserProfileStates extends homeStates{}
class homeErrorGetUserProfiletates extends homeStates{}


class updateLoadingState extends homeStates{}

class updateSuccessState extends homeStates{
  updateModel updateModelObj;
  updateSuccessState(this.updateModelObj);

}
class updateErrorState extends homeStates{
  String error;
  updateErrorState(this.error);
}


class homeDisplayUpdatesState extends homeStates{}
