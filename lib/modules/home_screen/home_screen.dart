import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/category_model/categories_model.dart';
import 'package:shopapp/models/login_model/home_model.dart';
import 'package:shopapp/modules/products_screen/category_cubit/category_cubit.dart';
import 'package:shopapp/modules/products_screen/category_cubit/category_states.dart';



class homeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<homeCubit,homeStates>(
      builder: (BuildContext context, homeStates state) {
        homeCubit homeCubitObj =homeCubit.get(context);
        return Scaffold(

          body: SafeArea(
              child:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSliderProductItem(homeCubitObj.homeModelObj),
                    SizedBox(height: 10,),
                    Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 180,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,colors: <Color>[Colors.purple,Colors.pink]
                        ),

                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text("Categories",style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w700),)),
                    SizedBox(height: 10,),
        Container(
                            height: 100,
                            decoration: BoxDecoration(
                            gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,colors: <Color>[Colors.purple,Colors.pink]
                        ),
                            ),
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index)=>ListProductItemHorizontal(homeCubitObj!.categoriesModel,index),
                              separatorBuilder: (context,index)=>SizedBox(width: 40,),
                              itemCount: homeCubitObj.categoriesModel!.categoriesData!.categoriesData.length),
                        )
                    ,
                    SizedBox(height: 10,),
                    Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 180,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,colors: <Color>[Colors.pink,Color(0xff650015)]
                            ),

                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Text("New Products",style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w700),)),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft
                              ,end: Alignment.centerRight,
                          colors: <Color>[Colors.pink,Color(0xff650015)]
                        )
                      ),
                      child: GridView.count(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                           mainAxisSpacing: 10,
                           crossAxisSpacing: 10,
                           childAspectRatio: 1/(1.4),
                           children:
                           List.generate(homeCubitObj.homeModelObj!.homedata!.homeDataProduct.length, (index) =>GrideViewProductItem(homeCubitObj.homeModelObj!, index,context))
                      ),
                    )
                  ],
                ),
              )

          ),
        );
      },
      listener: (BuildContext context, homeStates state) {  },

    );
  }

}

Widget ListProductItemHorizontal(CategoriesModel? categoriesModel,index)=> Container(
  height: 20,
  decoration: BoxDecoration(
      boxShadow: [BoxShadow(
          offset: Offset(1, 1),
          color: Colors.black,
          spreadRadius: 4,
          blurRadius: 4
      )],
      borderRadius: BorderRadius.all(Radius.circular(14))
  ),
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(image: NetworkImage("${categoriesModel!.categoriesData!.categoriesData[index].image}"),fit: BoxFit.fill,height: 100,width: 100,),
      Container(
          alignment: Alignment.center,
          height: 50,
          width: 100,
          color: Colors.black.withOpacity(0.5),
          child: Text("${categoriesModel!.categoriesData!.categoriesData[index].name}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),))

    ],
  ),
);

Widget CarouselSliderProductItem(homeModel? homeModelObj)=>CarouselSlider(
    items: homeModelObj!.homedata!.homeDataBanar.map((e) =>
    Image(image: NetworkImage("${e.image}"),fit: BoxFit.fill,width: double.infinity,)).toList(),
    options: CarouselOptions(
      height: 200,
      initialPage: 0,
      reverse: false,
      autoPlay: true,
      autoPlayAnimationDuration: Duration(seconds: 5),
      autoPlayInterval: Duration(seconds: 10),
      autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
        enableInfiniteScroll: true,
      viewportFraction: 0.8

    ));

Widget GrideViewProductItem(homeModel homeModelObj,index,context)=>
 Padding(
   padding: const EdgeInsets.all(10.0),
   child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                              clipBehavior: Clip.antiAliasWithSaveLayer,

                              child: Column(
                                  children: [

                                Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  children: [
                                    Image(image: NetworkImage("${homeModelObj!.homedata!.homeDataProduct[index].image.toString()}"),fit: BoxFit.fill,height: 120,width: 120,),
                                    if(homeModelObj!.homedata!.homeDataProduct[index].discount!=0)
                                    Container(
                                      width: double.infinity,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFF0000).withOpacity(0.7),
                                        // borderRadius: BorderRadius.circular(20)
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Text("Discount !",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 9,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Text("${homeModelObj!.homedata!.homeDataProduct[index].name.toString()}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,height: 1.2),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                ),
                                SizedBox(height: 9,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: Text("${homeModelObj!.homedata!.homeDataProduct[index].price..round().toString()} .LE",style: TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.w700,height: 1.2),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                      ),
                                    ),
                                    if(homeModelObj!.homedata!.homeDataProduct[index].discount!=0)
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                            child: Text("${homeModelObj!.homedata!.homeDataProduct[index].old_price..round().toString()} .LE",style: TextStyle(color: Colors.red,decoration: TextDecoration.lineThrough,fontSize: 15,fontWeight: FontWeight.w700,height: 1.2),maxLines: 1,overflow: TextOverflow.ellipsis),
                                          ),
                                        ),


                                  ],
                                ),
                                SizedBox(height: 9,),
                                Expanded(
                                  child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(onPressed: (){

                                        homeCubit.get(context).PostAddFavourite(homeModelObj!.homedata!.homeDataProduct[index].id,index);

                                       }, icon: homeCubit.get(context).myFavMap[homeCubit.get(context).homeModelObj!.homedata!.homeDataProduct[index]!.id]==true?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_outline)

                                      //homeCubit.get(context).homeModelObj!.homedata!.homeDataProduct[index].in_favorites?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_outline)

                                      )),
                                )


                                  ]),
                                      ),
 );
