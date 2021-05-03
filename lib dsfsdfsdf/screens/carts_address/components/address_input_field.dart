import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/checkout/address.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/models/companies/company.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField(this.address);

  final Address address;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final Company companyProvider = Provider.of(context, listen: false);
    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatório' : null;

    if (address.zipCode != null && cartManager.deliveryPrice == null)
      return Container(
        color: Colors.white.withOpacity(0.9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 16),
            TextFormField(
              enabled: !cartManager.loading,
              initialValue: address.street,
              decoration: const InputDecoration(
                isDense: true,
                labelText: 'Rua/Avenida',
                hintText: 'Av. Brasil',
              ),
              validator: emptyValidator,
              onSaved: (t) => address.street = t,
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    enabled: !cartManager.loading,
                    initialValue: address.number,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Número',
                      hintText: '123',
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    validator: emptyValidator,
                    onSaved: (t) => address.number = t,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    enabled: !cartManager.loading,
                    initialValue: address.complement,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Complemento',
                      hintText: 'Opcional',
                    ),
                    onSaved: (t) => address.complement = t,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              enabled: !cartManager.loading,
              initialValue: address.district,
              decoration: const InputDecoration(
                isDense: true,
                labelText: 'Bairro',
                hintText: 'Guanabara',
              ),
              validator: emptyValidator,
              onSaved: (t) => address.district = t,
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    enabled: false,
                    initialValue: address.city,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Cidade',
                      hintText: 'Campinas',
                    ),
                    validator: emptyValidator,
                    onSaved: (t) => address.city = t,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextFormField(
                    autocorrect: false,
                    enabled: false,
                    textCapitalization: TextCapitalization.characters,
                    initialValue: address.state,
                    decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'UF',
                      hintText: 'SP',
                      counterText: '',
                    ),
                    maxLength: 2,
                    validator: (e) {
                      if (e.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (e.length != 2) {
                        return 'Inválido';
                      }
                      return null;
                    },
                    onSaved: (t) => address.state = t,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            if (cartManager.loading)
              const LinearProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Theme.of(context).accentColor;
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                ),
              ),
              onPressed: !cartManager.loading
                  ? () async {
                      if (Form.of(context).validate()) {
                        Form.of(context).save();
                        try {
                          await context
                              .read<CartManager>()
                              .setAddress(companyProvider.id, address);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    }
                  : null,
              child: const Text('Inserir Endereço'), //Text('Calcular Frete'),
            ),
          ],
        ),
      );
    else if (address.zipCode != null)
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child:
            Text('${address.street}, ${address.number}\n${address.district}\n'
                '${address.city} - ${address.state}'),
      );
    else
      return Container();
  }
}
