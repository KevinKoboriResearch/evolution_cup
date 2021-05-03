import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';
import 'package:mewnu/models/user/user_manager.dart';

class CpfField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // TextFormField(
          //   initialValue: userManager.user.cpf,
          //   decoration: const InputDecoration(
          //     labelText: 'CPF',
          //     hintText: '000.000.000-00',
          //     isDense: true
          //   ),
          //   keyboardType: TextInputType.number,
          //   inputFormatters: [
          //     FilteringTextInputFormatter.digitsOnly,
          //     CpfInputFormatter(),
          //   ],
          //   validator: (cpf){
          //     if(cpf.isEmpty) return 'Campo Obrigatório';
          //     else if(!CPFValidator.isValid(cpf)) return 'CPF Inválido';
          //     return null;
          //   },
          //   onSaved: userManager.user.setCpf,
          // )
          TextFormField(
            initialValue: userManager.user.cpf,
            decoration: InputDecoration(
                labelText: 'CPF', hintText: '000.000.000-00', isDense: true),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            validator: Validatorless.cpf('CPF inválido'),
            onSaved: userManager.user.setCpf,
          ),
        ],
      ),
    );
  }
}
