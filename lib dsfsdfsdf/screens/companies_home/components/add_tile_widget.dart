import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/image_source_sheet.dart';
import 'package:mewnu/models/home/section.dart';
import 'package:mewnu/models/home/section_item.dart';

class AddTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();

    void onImagesSelected(List<dynamic> listImages, String type) {
      section.addItem(SectionItem(image: listImages[0]));
      Navigator.of(context).pop();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          if (Platform.isAndroid) {
            showModalBottomSheet(
              context: context,
              builder: (context) =>
                  ImageSourceSheet(onImagesSelected: onImagesSelected),
            );
          } else {
            showCupertinoModalPopup(
              context: context,
              builder: (context) =>
                  ImageSourceSheet(onImagesSelected: onImagesSelected),
            );
          }
        },
        child: Container(
          color: Colors.black.withOpacity(0.1),
          child: Icon(
            Icons.add,
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
    );
  }
}
