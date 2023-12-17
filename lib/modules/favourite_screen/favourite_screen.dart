import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/layouts/home_cubit/home_cubit.dart';
import 'package:shopapp/layouts/home_cubit/home_states.dart';
import 'package:shopapp/models/fav_model/fav_model.dart';
import 'package:shopapp/modules/favourite_screen/fav_cubit/fav_cubit.dart';
import 'package:shopapp/modules/favourite_screen/fav_cubit/fav_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class favouriteScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<homeCubit,homeStates>(
      builder: (BuildContext context,  state) {
        homeCubit favCubitObj=homeCubit.get(context);
        return  Scaffold(

          body: SafeArea(
              child:
              SingleChildScrollView(
                child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: state is !homeFavLoadingGetProdcutStates,
                      builder: (BuildContext context) { return  ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index)=>ListFavItem(favCubitObj.allFavModel,index,context), separatorBuilder: (context,index)=>SizedBox(height: 0,),
                          itemCount: favCubitObj.allFavModel!.allFavData!.FavDataList.length); },
                      fallback: (BuildContext context) { return Center(child: CircularProgressIndicator()); },

                    )
                  ],
                ),
              )
          ),
        );
      }, listener: (BuildContext context, state) {  },

    );
  }

}

Widget ListFavItem(AllFavModel? allFavModel,index,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    alignment: Alignment.topLeft,
    height: 150,
    width: double.infinity,
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
          clipBehavior:  Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: [
              Image(image: NetworkImage("${allFavModel!.allFavData!.FavDataList[index].favDataItemDetails!.image}",),height: 120,width: 120,fit: BoxFit.fill,),

              if(allFavModel!.allFavData!.FavDataList[index]!.favDataItemDetails!.discount!=0)
                Container(alignment: Alignment.center,height: 25,width: 120,color: Colors.red.withOpacity(0.7),child: Text("Discount!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),))
            ],
          ),
        )
        ,SizedBox(width: 10,),
        Container(
          height: 100,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(
                   "${allFavModel!.allFavData!.FavDataList[index]!.favDataItemDetails!.name}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,),maxLines: 2,overflow: TextOverflow.ellipsis,))
              ,
              Row(children: [
                Expanded(child: Text("${allFavModel!.allFavData!.FavDataList[index]!.favDataItemDetails!.price}",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w700,fontSize: 18,),maxLines: 1,overflow: TextOverflow.ellipsis,))
                ,SizedBox(width: 20,),
                if(allFavModel!.allFavData!.FavDataList[index]!.favDataItemDetails!.discount!=0)
                Expanded(child: Text("${allFavModel!.allFavData!.FavDataList[index]!.favDataItemDetails!.oldPrice}",style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.red,fontWeight: FontWeight.w700,fontSize: 18,),maxLines: 1,overflow: TextOverflow.ellipsis,))


              ],)

            ],),
        ),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 40,
                width: 40,
                alignment: Alignment.bottomCenter,
                child: IconButton(onPressed: (){
                //
                //    homeCubit.get(context).PostAddFavourite(homeCubit.get(context).homeModelObj!.homedata!.homeDataProduct[index].id,index);
                //
                // }, icon: homeCubit.get(context).homeModelObj!.homedata!.homeDataProduct[index].in_favorites?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_outline)// homeCubit.get(context).homeModelObj!.homedata!.homeDataProduct[index].in_favorites?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_outline)
                //
                  homeCubit.get(context).PostAddFavourite(allFavModel!.allFavData!.FavDataList[index].favDataItemDetails!.id,index);

                }, icon: homeCubit.get(context).myFavMap[homeCubit.get(context).homeModelObj!.homedata!.homeDataProduct[index]!.id]==true?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_outline)




                )),
          ],
        )


      ],
    ),
  ),
);