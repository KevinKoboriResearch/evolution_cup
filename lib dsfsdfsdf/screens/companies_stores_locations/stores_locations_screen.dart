// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../models/stores_manager.dart';
// import '../../../../pages/companies/stores/stores_locations/components/store_location_card.dart';

// class CompanyStoresLocationsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text('Lojas'),
//         centerTitle: true,
//       ),
//       body: Consumer<StoresManager>(
//         builder: (_, storesManager, __){
//           if(storesManager.stores.isEmpty){
//             return const LinearProgressIndicator(
//               // valueColor: AlwaysStoppedAnimation(Colors.white),
//               backgroundColor: Colors.transparent,
//             );
//           }

//           return ListView.builder(
//             itemCount: storesManager.stores.length,
//             itemBuilder: (_, index){
//               return StoreLocationCard(storesManager.stores[index]);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
