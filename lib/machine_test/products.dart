

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/provider/db_provider.dart';
import '../common/const.dart';
import '../common/helpers.dart';
import '../services/db_helper.dart';
import 'hexcolor.dart';
import 'home_provider.dart';
import 'homemodel.dart';

class ProductsWidget extends StatelessWidget {
  ValueNotifier<bool> isfav = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider,ContactsProvider>(
          builder: (context, snapshot,model,child) {
            final productItem = snapshot.homeModel?.homeData?.firstWhere(
              ((element) {
                if (element.type != null) {
                  return element.type == "products";
                } else {
                  return false;
                }
              }),
              orElse: () => HomeDatum(),
            );
            if(productItem == null || productItem.type ==null){
              return const SizedBox();
            }
            return Container(
              height: 280,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: productItem.values?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  final check = model.cartModel?.firstWhere((element) => element.value?.id == productItem.values?[index].id,orElse: ()=>CartModel());
                  final favCheck = model.favList?.firstWhere((element) => element.favourites?.id == productItem.values?[index].id,orElse: ()=>FavouritesModel());
                  return Container(
                      width: 170.0,
                      margin: const EdgeInsets.only(left: 10),
                      child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: HexColor("#FFEAEAEA"))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(right: 10.0),
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    productItem.values?[index].offer == 0 ? SizedBox() :
                                    Stack(children: [
                                      Image.asset(Const.redTag),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 3.0,),
                                            child: Text('${productItem.values?[index].offer}',style: const TextStyle(color: Colors.white,fontSize: 10),),
                                          ),
                                          const Icon(Icons.percent,color: Colors.white,size: 10,),
                                           Text('OFF',style: TextStyle(color: Colors.white,fontSize: 10))
                                        ],
                                      )
                                    ],),
                                    Container(
                                      //margin: const EdgeInsets.only(top: 10.0),
                                      child: ValueListenableBuilder<bool>(
                                        valueListenable: isfav,
                                        builder: (context, snapshot,child) {
                                          return GestureDetector(
                                            onTap: (){
                                              final check = model.favList?.firstWhere((element) => element.favourites?.id == productItem.values?[index].id,orElse: ()=>FavouritesModel());
                                              if(check?.favourites == null){
                                                context.read<ContactsProvider>().insertFavItems(productItem.values![index]);
                                              }else{
                                                context.read<ContactsProvider>().deleteFavouritesItem(check?.id);
                                              }
                                            },
                                            child:
                                            favCheck?.favourites != null ? Icon(Icons.favorite,color: Colors.red,) :
                                            Image.asset(
                                              Const.favIcon,
                                              height: 19.h,
                                              width: 19.0,
                                            ),
                                          );
                                        }
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    child:
                                    FadeInImage.assetNetwork(placeholder: Const.placeholder, image: productItem.values?[index].image ??'',height: 90,width: 90,)
                                )),
                            Container(
                                margin: const EdgeInsets.only( left: 11.0),
                                child: productItem.values![index].isExpress! ?
                                Image.asset(Const.truckImg,height: 14,width: 22,) :  Container(height: 14,width: 22,)
                            ),
                            Container(
                                margin: const EdgeInsets.only( left: 11.0),
                                child:productItem.values?[index].actualPrice! == productItem.values?[index].offerPrice! ? SizedBox() :
                                Text(productItem.values?[index].actualPrice??'',style: TextStyle(decoration: TextDecoration.lineThrough,color: HexColor('#727272'),fontSize: 12),)
                            ),
                            Container(
                                margin: const EdgeInsets.only( left: 11.0),
                                child: Text(productItem.values?[index].offerPrice ?? '',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                            ),
                            Container(
                              margin: const EdgeInsets.only( left: 11.0,),
                              child: Text((productItem.values?[index].name ?? '')+'\n',style:  TextStyle(fontSize: 14.sp,),maxLines: 2,),
                            ),

                            Container(
                              alignment: Alignment.center,
                              child:Column(children: [
                                check?.count != null ?
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Row(
                                    children: [
                                      IconButton(onPressed: (){
                                        final check = model.cartModel?.firstWhere((element) => element.value?.id == productItem.values?[index].id,orElse: ()=>CartModel());
                                        int countMinus = check?.count ?? 0;
                                        countMinus = countMinus - 1;
                                        if(countMinus <= 0){
                                          context.read<ContactsProvider>().deleteData(check?.id);
                                        }else{
                                          context.read<ContactsProvider>().updateCountfn(check?.id, countMinus);
                                        }
                                      }, icon: Container(decoration:  BoxDecoration(shape: BoxShape.circle,color: Colors.grey[300]),child: Icon(Icons.remove,color: HexColor('#199B3B'),))),
                                       // count(model.cartModel),
                                       check?.count == null ? Text('0') : Text('${check?.count}'),
                                      IconButton(onPressed: ()async{
                                       final check = model.cartModel?.firstWhere((element) => element.value?.id == productItem.values?[index].id,orElse: ()=>CartModel());
                                       if(check?.value != null){
                                         if(check?.count != null){
                                           int? count = check?.count ?? 0;
                                           count = count + 1;
                                           context.read<ContactsProvider>().updateCountfn(check?.id, count);
                                         }
                                       }else{
                                         context.read<ContactsProvider>().insertProducts(productItem.values![index]);
                                       }
                                      }, icon: Container(decoration:  BoxDecoration(shape: BoxShape.circle,color: Colors.grey[300]),child: Icon(Icons.add,color: HexColor('#199B3B'),))),
                                    ],
                                  ),
                                ) :
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: HexColor('#199B3B'),minimumSize: Size(110, 30)),
                                  onPressed: (){
                                    context.read<ContactsProvider>().insertProducts(productItem.values![index]);
                                    // context.read<ContactsProvider>().loadProducts();
                                  },
                                  child: Text('ADD'),
                                ),
                              ],)
                            )
                          ],
                        ),
                      )
                  );
                },

              ),
            );
          }
      );
  }
}
