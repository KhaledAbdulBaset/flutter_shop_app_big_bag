import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cashHelper{

  static late SharedPreferences _sharedPreferences ;

  static InitSharedPrefrence()async{
    _sharedPreferences=await SharedPreferences.getInstance();
  }

  static Future<bool>  saveDataIntoSharedPref
      ({required String key, required dynamic value})async{
if(value is String)
{return await  _sharedPreferences.setString(key, value);}

if(value is int)
{return await  _sharedPreferences.setInt(key, value);}

if(value is bool)
{return await  _sharedPreferences.setBool(key, value);}

return await  _sharedPreferences.setDouble(key, value);
       }

       static dynamic getDataFromSharedPref
           (@required String key){
           return _sharedPreferences.get(key);}

  static Future<bool> clearDataFromSharedPref
      (@required String key)
 async {
    return await _sharedPreferences.remove(key);
  }

}