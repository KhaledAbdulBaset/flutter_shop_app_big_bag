import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:shopapp/models/category_model/categories_model.dart';
import 'package:shopapp/modules/products_screen/category_cubit/category_cubit.dart';
import 'package:shopapp/modules/products_screen/category_cubit/category_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class productsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<homeCubit,homeStates>(
      builder: (BuildContext context,  state) {
      homeCubit categoryCubitObj=homeCubit.get(context);
      return Scaffold(

        body:
          SingleChildScrollView(
            child: Column(children: [
              ListView.separated(
                physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,

                  itemBuilder: (context,index)=>ListProductItemVertical(categoryCubitObj.categoriesModel, index), separatorBuilder: (context, index) => SizedBox(height: 0,), itemCount: categoryCubitObj.categoriesModel!.categoriesData!.categoriesData.length)
            ],),
          )
             

        
      );
    }, listener: (BuildContext context, state) {  },

    );
  }

}

Widget ListProductItemVertical(CategoriesModel? categoriesModel,index)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(child: Image(image: NetworkImage("${categoriesModel!.categoriesData!.categoriesData[index].image}"),fit: BoxFit.fill,height: 100,width: 100,)),
      SizedBox(width: 20,),
      Expanded(child: Text("${categoriesModel!.categoriesData!.categoriesData[index].name}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),maxLines: 2,overflow: TextOverflow.ellipsis,)),
      Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  stops: [0.3,0.4,0.9],
                  colors: <Color>[Colors.pink,Colors.purple,Color(0xff650015)]

              ),

              shape: BoxShape.circle),
          child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,color: Colors.white,)))
    ],
  ),
);