import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_layout.dart';
import 'package:shopapp/modules/login/login_cubit/login_cubit.dart';
import 'package:shopapp/modules/login/login_cubit/login_states.dart';
import 'package:shopapp/modules/register/register_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cash_helper.dart';

class loginScreen extends StatelessWidget{
  var emailController= TextEditingController();
  var passwordController= TextEditingController();
  GlobalKey<FormState> _fromKey=GlobalKey<FormState>();

validator(){
  if(_fromKey.currentState!=null&&_fromKey.currentState!.validate()){
    print("Validate");
  }
  else{
    print("Not Validate");

  }
}

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<loginCubit,loginStates>(
      builder: (BuildContext context, state) {
        loginCubit loginCubitObj = loginCubit.get(context);

        return  Scaffold(
          // appBar: AppBar(
          //   elevation: 0,
          // ),
          body: SafeArea(
            child: Column(
                children: [

                  Expanded(
                      flex: 5,
                      child:Stack(
                        children: [
                          ClipPath(
                            clipper: customClipperClass(),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(

                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[Colors.pink,Colors.black]
                                  )
                              ),
                            ),
                          ),
                          ClipPath(
                            clipper: customClipperClass(),
                            child: Container(
                                height: 300,
                                color: Colors.pink,
                                width: double.infinity,
                                child: Image(image: AssetImage("assets/images/shplogin1.jpg"),fit: BoxFit.cover,)
                            ),
                          ),
                        ],)
                  ),
                  Expanded(
                    flex: 6,
                    child: Form(
                      key: _fromKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("LogIn",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
                                SizedBox(height: 8,),
                                Text("login now to get best offers",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w700),),
                                SizedBox(height: 16,),
                                TextFormField(
                                  validator: (String? value){
                                    if(value==null||value.trim().length==0){
                                      return "     Email must not be empty !!";
                                    }
                                    return null;

                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    prefixIcon: Icon(Icons.email_outlined),
                                  ),

                                ),
                                SizedBox(height: 16,),
                                TextFormField(
                                  validator: (String? value){
                                    if(value==null||value.trim().length==0){
                                      return "     Password must not be empty !!";
                                    }
                                    return null;

                                  },
                                  keyboardType: TextInputType.text,
                                  obscureText: loginCubitObj.isVisiblePassword?false:true,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(onPressed: (){
                                      loginCubitObj.changeVisibilityPassword();

                                    },icon: Icon(loginCubitObj.isVisiblePassword?Icons.visibility_rounded:Icons.visibility_off_rounded)),

                                  ),

                                ),
                                SizedBox(height: 16,),
                                ConditionalBuilder(
                                  condition: state is !loginLoadingState,
                                  builder: (context)=> MaterialButton(onPressed: (){validator();loginCubitObj.userLoginApi(emailController.text, passwordController.text);

                                  }, child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors:<Color>[Color(0xff650015),Color(0xff182232)]),
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 20),)),),
                                  fallback: (context)=>Center(child: CircularProgressIndicator()),

                                ),
                                SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don't have an acount?",style: TextStyle(fontSize: 15)),
                                    Column(
                                      children: [
                                        MaterialButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) {return registerScreen();},));},child: Text("please Sign Up",style: TextStyle(color: Color(0xff650015),fontSize: 15,fontWeight: FontWeight.w500),)),
                                        Container(height: 1,width: 100,color: Color(0xff650015),)
                                      ],
                                    ),
                                  ],
                                ),



                              ],),
                          ),
                        ),
                      ),
                    ),

                  ),
                ]),
          ),
        );

      },
      listener: (context, state) {

        if(state is loginSuccessState){
          print("HEEEEEEEEEEEEEEEEEEERRRRRRRRREE");
          if(state.loginModelOnj.status==true){
            //if the message true so the email and password go home
            print(state.loginModelOnj.message);
            print(state.loginModelOnj.data!.token);
            //toast(state.loginModelOnj.message.toString(), Colors.green);
            cashHelper.saveDataIntoSharedPref(key: "token", value: state.loginModelOnj.data!.token.toString()).then((value) {
             // homeCubit.get(context).token=loginCubit.get(context).loginModelObj.data!.token!;
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homeLayout(),), (route) => false);
            });


          }
          if(state.loginModelOnj.status==false){
            print("false state");
          }

           else{
            print("else state");
            print(state.loginModelOnj.message);
            //toast(state.loginModelOnj.message.toString(), Colors.green);

           }

        }



      },

    );
  }

}
class customClipperClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    double w=size.width;
    double h=size.height;
    final path=Path();

    path.lineTo(0, 0.6*h);
    path.quadraticBezierTo(0.2*w, 0.3*h, 0.4*w, 0.6*h);
   path.quadraticBezierTo(0.7*w, h, w, 0.82*h);
    path.lineTo(w, 0);
    path.close();


    return path;


  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}