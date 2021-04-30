import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:flutter_instagram_image_picker/flutter_instagram_image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({this.onImagesSelected}); //this.mode

  final Function(List<dynamic>, String) onImagesSelected;
  // final String mode;
  final ImagePicker picker = ImagePicker();

  Future<void> editImage(String path, BuildContext context) async {
    final File croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        // maxWidth: 720,
        // maxHeight: 720,
        // compressQuality: 0,
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Editar Imagem',
        ),
        iosUiSettings: const IOSUiSettings(
          title: 'Editar Imagem',
          cancelButtonTitle: 'Cancelar',
          doneButtonTitle: 'Concluir',
        ));
    if (croppedFile != null) {
      onImagesSelected([croppedFile], 'device');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.camera);
                editImage(file.path, context);
              },
              child: const Text('Câmera', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () async {
                final PickedFile file =
                    await picker.getImage(source: ImageSource.gallery);
                editImage(file.path, context);
              },
              child: const Text('Galeria', style: TextStyle(color: Colors.black)),
            ),
            // TextButton(
            //   onPressed: () async {
            //     final bool isLogged = await InstagramAuth().isLogged;
            //     // check if user already logged in, if not log the user
            //     if (!isLogged) {
            //       final bool loginStatus =
            //           await InstagramAuth().signUserIn(context);
            //       // if user canceled the operation
            //       if (!loginStatus) return;
            //     }

            //     var accessMapData = await InstagramAuth().accessData;
            //     if (accessMapData == null) {
            //       return null;
            //     }

            //     // After got the access data, can go to picker screen
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => InstagramImagePicker(
            //           accessMapData,
            //           showLogoutButton: true,
            //           onDone: (items) {
            //             List<dynamic> items2;
            //             items.forEach((element) {
            //               items2.add(element.url.toString());
            //               print('selected: ${element.url}');
            //             });
            //             onImagesSelected(items2, 'instagram');
            //             Navigator.pop(context);
            //           },
            //           onCancel: () => Navigator.pop(context),
            //         ),
            //       ),
            //     );
            //   },
            //   child: const Text('Instagram'),
            // ),
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o item'),
        message: const Text('Escolha a origem da foto'),
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancelar'),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.camera);
              editImage(file.path, context);
            },
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final PickedFile file =
                  await picker.getImage(source: ImageSource.gallery);
              editImage(file.path, context);
            },
            child: const Text('Galeria'),
          )
        ],
      );
  }
}
