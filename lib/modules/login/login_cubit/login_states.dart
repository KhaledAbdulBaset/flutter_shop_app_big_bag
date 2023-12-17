import 'package:shopapp/models/login_model/login_model.dart';

abstract class loginStates{}

class loginInitState extends loginStates{}
class changeVisibilityPasswordState extends loginStates{}

class loginSuccessState extends loginStates{
  //to pass the value into the success state so that you can listen on it
  final loginModel loginModelOnj;
  loginSuccessState(this.loginModelOnj);
}
class loginLoadingState extends loginStates{}
class loginErrorState extends loginStates{
  final String error;
  loginErrorState(this.error);
}