import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:mewnu/common/image_source_sheet.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/user/user_page.dart';

class ImageProfileField extends StatefulWidget {
  @override
  _ImageProfileFieldState createState() => _ImageProfileFieldState();
}

class _ImageProfileFieldState extends State<ImageProfileField> {
  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();
    File image;

    ImageProvider<Object> returnImage() {
      if (image == null)
        return userManager.user.imageProfile != null
            ? NetworkImage(
                userManager.user.imageProfile, // image as String,
              )
            : null;
      else
        return FileImage(
          image,
        ) as ImageProvider<Object>;
    }

// onImagesSelected(List<dynamic> listImages, String type) {
//           if(type == 'instagram') {
//             state.value.add(listImages);
//             state.didChange(state.value);
//           } else {
//           state.value.add(listImages[0]);
//           state.didChange(state.value);
//           }
//           Navigator.of(context).pop();
//         }

    void onImagesSelected(List<dynamic> listImages, String type) {
      if (type == 'instagram') {
      } else {
        setState(() {
          image = listImages[0] as File;
        });
        userManager.user.uploadImageProfile(listImages[0] as File).then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => UserPage()),
          );
        });
      }

      // Navigator.of(context).pop();
    }

    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: returnImage(),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: const Color(0xFFF5F6F9),
                onPressed: () {
                  //         print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' +
                  // userManager.user.imageProfile.toString());
                  if (Platform.isAndroid)
                    showModalBottomSheet(
                        context: context,
                        builder: (_) => ImageSourceSheet(
                              onImagesSelected: onImagesSelected,
                            ));
                  else
                    showCupertinoModalPopup(
                        context: context,
                        builder: (_) => ImageSourceSheet(
                              onImagesSelected: onImagesSelected,
                            ));
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
    // Padding(
    //   padding: const EdgeInsets.all(16),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       TextFormField(
    //         initialValue: userManager.user.cpf,
    //         decoration: const InputDecoration(
    //           labelText: 'CPF',
    //           hintText: '000.000.000-00',
    //           isDense: true
    //         ),
    //         keyboardType: TextInputType.number,
    //         inputFormatters: [
    //           FilteringTextInputFormatter.digitsOnly,
    //           CpfInputFormatter(),
    //         ],
    //         validator: (cpf){
    //           if(cpf.isEmpty) return 'Campo Obrigatório';
    //           else if(!CPFValidator.isValid(cpf)) return 'CPF Inválido';
    //           return null;
    //         },
    //         onSaved: userManager.user.setCpf,
    //       )
    //     ],
    //   ),
    // );
  }
}
