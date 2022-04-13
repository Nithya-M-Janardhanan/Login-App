import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabase{
   Box? box;

   Future openBox() async{
     var dir = await getApplicationDocumentsDirectory();
     Hive.init(dir.path);
     box = await Hive.openBox('data');
     return;
   }

   getAllData() async{
     await openBox();

   }
   Future putData(data) async{
     await box!.clear();
     for(var d in data){
       box!.add(d);
     }
   }
}