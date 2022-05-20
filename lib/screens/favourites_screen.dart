import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_task/machine_test/homemodel.dart';
import 'package:sample_task/provider/db_provider.dart';

import '../provider/favourites_provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  void initState() {
    Future.microtask(() => context.read<FavouritesProvider>().loadFavList());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        backgroundColor: Colors.teal,
      ),
      body: Consumer<FavouritesProvider>(builder: (context,snapshot,child){
        if(snapshot.favList == null){
          return const SizedBox();
        }
        return ListView.builder(
          itemCount: snapshot.favList?.length,
            itemBuilder: (BuildContext context,int index){
               final check = snapshot.favList?.firstWhere((element) => element.favourites?.id == snapshot.favList?[index].id,orElse: ()=>FavouritesModel());
              return Card(
                child: ListTile(
                  leading: Image.network(snapshot.favList?[index].favourites?.image ??''),
                  title: Text(snapshot.favList?[index].favourites?.name ?? ''),
                  subtitle: Text(snapshot.favList?[index].favourites?.actualPrice ?? ''),
                  trailing: IconButton(onPressed: (){
                     context.read<FavouritesProvider>().deleteFavouritesItem(snapshot.favList?[index].id);
                  },icon: Icon(Icons.delete),),
                ),
              );
            }
        );
      },),
    );
  }
}
