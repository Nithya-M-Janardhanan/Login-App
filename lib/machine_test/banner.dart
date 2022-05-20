import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shimmer/custom_widget.dart';
import 'home_provider.dart';
import 'homemodel.dart';

class HomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.18;
    return Consumer<HomeProvider>(builder: (context, snapshot, child) {
      /* bool isbannerItem = false;
          var bannerItem;
          int? length = snapshot.homeModel?.homeData?.length;
          for(int i = 0;i<length! ; i++){
            if(snapshot.homeModel?.homeData?[i].type == 'banners'){
              bannerItem = snapshot.homeModel?.homeData?[i];
              isbannerItem=true;
              height=height;
            }else{
            }
          }*/
      final bannerItem = snapshot.homeModel?.homeData?.firstWhere(
        ((element) {
          if (element.type != null) {
            return element.type == "banners";
          } else {
            return false;
          }
        }),
        orElse: () => HomeDatum(),
      );

      // if (bannerItem == null || bannerItem.type == null) {
      //   return const SizedBox();
      // }
      return bannerItem == null || bannerItem.type == null ? const CustomWidget.rectangular(height: 140) :
        Container(
        height: MediaQuery.of(context).size.height * 0.18,
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 20),
        child:
        PageView.builder(
          padEnds: false,
          controller: PageController(initialPage: 0, viewportFraction: 0.9),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return
              Container(
                // width: double.maxFinite,
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child:
                CachedNetworkImage(
                  imageUrl: bannerItem.values?[index].bannerUrl ?? '',
                  placeholder: (context, url) => Card(
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //child: Image.asset(Const.placeholder,height: 10,width: 10,),
                  ),
                  fit: BoxFit.fill,
                ));
          },
          itemCount: bannerItem.values?.length ?? 0,
        ),
      );
    });
  }
}
