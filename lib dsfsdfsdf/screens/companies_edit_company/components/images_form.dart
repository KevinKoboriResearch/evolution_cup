import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_carousel/reorderable_carousel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:mewnu/common/image_source_sheet.dart';
import 'package:mewnu/models/companies/company.dart';

class ImagesForm extends StatefulWidget {
  final Company company;
  const ImagesForm(this.company);
  @override
  _ImagesFormState createState() => _ImagesFormState();
}

class _ImagesFormState extends State<ImagesForm> {
  int globalIndex = 0;
  int insertIndex;
  String mode;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(widget.company.images),
      validator: (images) {
        if (images.isEmpty)
          return 'Insira ao menos uma imagem';
        else if (images[0] ==
            'https://idealservis.com.br/portal/wp-content/uploads/2014/07/default-placeholder.png')
          return 'Mude a imagem principal';
        return null;
      },
      onSaved: (images) => widget.company.newImages = images,
      builder: (state) {
        void onImagesSelected(List<dynamic> listImages, String type) {
          if (type == 'instagram') {
            // state.value.add(listImages);
            // state.didChange(state.value);
          } else {
            if (mode == 'replace') {
              insertIndex = globalIndex;
              state.value.removeAt(globalIndex);
              state.value.insert(insertIndex, listImages[0]);
              state.didChange(state.value);
            } else {
              // insertIndex
              // dynamic swap = state.value.removeAt(oldIndex);
              //             state.value.insert(newIndex, swap);
              state.value.insert(insertIndex, listImages[0]);
              state.didChange(state.value);
            }
          }
          Navigator.of(context).pop();
        }

        if (state.value.isEmpty) {
          state.value.insert(0,
              'https://idealservis.com.br/portal/wp-content/uploads/2014/07/default-placeholder.png');
        }

        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Container(
                        color: Colors.grey[100],
                      ),
                    ),
                    if (state.value[globalIndex] is String)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.network(
                          state.value[globalIndex] as String,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.file(
                          state.value[globalIndex] as File,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: Theme.of(context).accentColor,
                            child: InkWell(
                              onTap: () {
                                mode = 'replace';
                                // insertIndex = globalIndex;
                                // state.value.removeAt(globalIndex);
                                if (Platform.isAndroid)
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (_) => ImageSourceSheet(
                                      onImagesSelected: onImagesSelected,
                                      // mode: 'replace',
                                    ),
                                  );
                                else
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (_) => ImageSourceSheet(
                                      onImagesSelected: onImagesSelected,
                                      // mode: 'replace',
                                    ),
                                  );
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 8.0, 12.0, 8.0),
                                child: Text(
                                  'Mudar Foto',
                                  style: TextStyle(
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipOval(
                          child: Material(
                            color: Theme.of(context).accentColor,
                            child: InkWell(
                              onTap: () {
                                if (globalIndex == 0) {
                                  state.value.removeAt(globalIndex);
                                  state.didChange(state.value);
                                } else {
                                  final int lastGlobalIndex = globalIndex;
                                  globalIndex = globalIndex - 1;
                                  state.value.removeAt(lastGlobalIndex);
                                  state.didChange(state.value);
                                }
                                // state.value.remove(state.value[globalIndex]);

                                // }
                              },
                              child: SizedBox(
                                width: 32,
                                height: 32,
                                child: Icon(
                                  Icons.remove,
                                  color: Theme.of(context).canvasColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Container(height: 100, width: 100, color: state.value[0]),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 130,
                  child: ReorderableCarousel(
                    itemBuilder: (boxSize, index, isSelected) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              color: Colors.grey[100],
                            ),
                          ),
                          state.value[index] is String
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    state.value[index] as String,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(
                                    state.value[index] as File,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ],
                      );
                    },
                    numItems: state.value.isNotEmpty ? state.value.length : 1,
                    addItemAt: (index) {
                      if (state.value.length <= 4) {
                        insertIndex = index;
                        mode = 'insert';
                        if (Platform.isAndroid)
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                              onImagesSelected: onImagesSelected,
                              // mode: 'insert',
                            ),
                          );
                        else
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => ImageSourceSheet(
                              onImagesSelected: onImagesSelected,
                              // mode: 'insert',
                            ),
                          );
                      } else {
                        Flushbar(
                          title: 'Número máximo de fotos atingido!',
                          message:
                              'Você só pode adicionar até 5 fotos por postagem...',
                          flushbarPosition: FlushbarPosition.TOP,
                          flushbarStyle: FlushbarStyle.GROUNDED,
                          isDismissible: true,
                          backgroundColor: Theme.of(context).accentColor,
                          duration: const Duration(seconds: 5),
                          icon: SvgPicture.asset(
                            'assets/icons/cart_icon.svg',
                            semanticsLabel: 'Carrinhos',
                            height: 20,
                            color: Theme.of(context).canvasColor,
                          ),
                        ).show(context);
                      }
                    },
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        final dynamic swap = state.value.removeAt(oldIndex);
                        state.value.insert(newIndex, swap);
                      });
                    },
                    onItemSelected: (int selectedIndex) {
                      if (selectedIndex <= state.value.length - 1) {
                        setState(() {
                          globalIndex = selectedIndex;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            if (state.hasError)
              Container(
                margin: const EdgeInsets.only(top: 16, left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
