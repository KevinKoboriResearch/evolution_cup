import 'package:flutter/material.dart';
import 'package:mewnu/common/custom_icon_button.dart';
import 'package:mewnu/models/products/item_size.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize(
      {Key key, this.size, this.onRemove, this.onMoveUp, this.onMoveDown})
      : super(key: key);

  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      // borderRadius: BorderRadius.c4rc4la4(20),
      // borderSide: BorderSide(color: Colors.red),
      gapPadding: 4,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 35,
            child: TextFormField(
              initialValue: size.name,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 0),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                border: outlineInputBorder,
                labelText: 'Título',
                isDense: true,
              ),
              validator: (name) {
                if (name.isEmpty) return 'Inválido';
                return null;
              },
              onChanged: (name) => size.name = name,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 25,
            child: TextFormField(
              initialValue: size.stock?.toString(),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 0),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                border: outlineInputBorder,
                labelText: 'Estoque',
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              validator: (stock) {
                if (int.tryParse(stock) == null) return 'Inválido';
                return null;
              },
              onChanged: (stock) => size.stock = int.tryParse(stock),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 40,
            child: TextFormField(
              initialValue: size.price?.toStringAsFixed(2),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 0),
                enabledBorder: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                border: outlineInputBorder,
                labelText: 'Preço R\$',
                isDense: true,
                // prefixText: 'R\$',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (price) {
                if (num.tryParse(price) == null) return 'Preço Inválido';
                return null;
              },
              onChanged: (price) => size.price = num.tryParse(price),
            ),
          ),
          CustomIconButton(
            iconData: Icons.remove,
            color: Theme.of(context).accentColor,
            onTap: onRemove,
          ),
          CustomIconButton(
            iconData: Icons.arrow_drop_up,
            color: Colors.black,
            onTap: onMoveUp,
          ),
          CustomIconButton(
            iconData: Icons.arrow_drop_down,
            color: Colors.black,
            onTap: onMoveDown,
          )
        ],
      ),
    );
  }
}
