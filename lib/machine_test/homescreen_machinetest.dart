// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
//
// import '../widgets/categories.dart';
// import 'home_provider.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     Future.microtask(() => context.read<HomeProvider>().getData());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Consumer<HomeProvider>(builder: (context, snapshot, child) {
//           if (snapshot.homeModel?.homeData == null) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return Container(
//             width: double.maxFinite,
//             height: double.maxFinite,
//             child: Column(
//               children: [
//                 SearchWidget(),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         CategoriesWidget(),
//                         HomeBanner(),
//                         ProductsWidget()
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
