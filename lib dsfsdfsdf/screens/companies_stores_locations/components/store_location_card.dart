// import 'package:flutter/material.dart';
// import 'package:map_launcher/map_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../../common/custom_icon_button.dart';
// import '../../../../../models/store.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class StoreLocationCard extends StatelessWidget {
//   const StoreLocationCard(this.store);

//   final Store store;

//   @override
//   Widget build(BuildContext context) {
//     final accentColor = Theme.of(context).accentColor;

//     Color colorForStatus(StoreStatus status) {
//       switch (status) {
//         case StoreStatus.closed:
//           return Colors.red;
//         case StoreStatus.open:
//           return Colors.green;
//         case StoreStatus.closing:
//           return Colors.orange;
//         default:
//           return Colors.green;
//       }
//     }

//     void showError() {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Esta função não está disponível neste dispositivo'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }

//     Future<void> openPhone() async {
//       if (await canLaunch('tel:${store.cleanPhone}')) {
//         launch('tel:${store.cleanPhone}');
//       } else {
//         showError();
//       }
//     }

//     Future<void> openMap() async {
//       try {
//         final availableMaps = await MapLauncher.installedMaps;

//         showModalBottomSheet(
//             context: context,
//             builder: (_) {
//               return SafeArea(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     for (final map in availableMaps)
//                       ListTile(
//                         onTap: () {
//                           map.showMarker(
//                             coords:
//                                 Coords(store.address.lat, store.address.lng),
//                             title: store.name,
//                             description: store.addressText,
//                           );
//                           Navigator.of(context).pop();
//                         },
//                         title: Text(map.mapName),
//                         leading: SvgPicture.asset(
//                           map.icon,
//                         ),
//                       ),
//                   ],
//                 ),
//               );
//             });
//       } catch (e) {
//         showError();
//       }
//     }

//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       clipBehavior: Clip.antiAlias,
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 220,
//             child: Stack(
//               fit: StackFit.expand,
//               children: <Widget>[
//                 Image.network(
//                   store.image,
//                   fit: BoxFit.cover,
//                 ),
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius:
//                             BorderRadius.only(bottomLeft: Radius.circular(8))),
//                     padding: const EdgeInsets.all(8),
//                     child: Text(
//                       store.statusText,
//                       style: TextStyle(
//                         color: colorForStatus(store.status),
//                         fontWeight: FontWeight.w800,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: 140,
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         store.name,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w800,
//                           fontSize: 17,
//                         ),
//                       ),
//                       Text(
//                         store.addressText,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 2,
//                       ),
//                       Text(
//                         store.openingText,
//                         style: const TextStyle(
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     CustomIconButton(
//                       iconData: Icons.map,
//                       color: accentColor,
//                       onTap: openMap,
//                     ),
//                     CustomIconButton(
//                       iconData: Icons.phone,
//                       color: accentColor,
//                       onTap: openPhone,
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
