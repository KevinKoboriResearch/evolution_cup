import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:mewnu/models/carts/cart_manager.dart';
import 'package:mewnu/screens/carts_cart/cart_screen.dart';
import 'package:mewnu/common/menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/menu_tile.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/user/components/image_profile_field.dart';
import 'package:mewnu/screens/user_google_sign_in/google_sign_in_screen.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/user/components/image_profile_field.dart';
import 'package:mewnu/screens/user_google_sign_in/google_sign_in_screen.dart';
import 'package:mewnu/models/companies/company.dart';
// import '../../../constants.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key key,
    @required this.cartCompanyId,
    @required this.text,
    @required this.icon,
    @required this.label,
    @required this.width,
    this.press,
  }) : super(key: key);

  final String cartCompanyId, text, icon, label;
  final VoidCallback press;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartCompanyId),
      // background: Container(
      //   color: Theme.of(context).errorColor,
      //   child: Icon(
      //     Icons.delete,
      //     color: Colors.white,
      //     size: 40,
      //   ),
      //   alignment: Alignment.centerRight,
      //   padding: EdgeInsets.only(right: 20),
      //   margin: EdgeInsets.symmetric(
      //     horizontal: 15,
      //     vertical: 4,
      //   ),
      // ),
      background: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: FlatButton(
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.red,
          onPressed: press,
          child: Row(
            children: [
              const Spacer(),
              const Icon(Icons.delete),
            ],
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Tem certeza?'),
            content: Text('Os itens serão perdidos!'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('Não'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Sim'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        Provider.of<CartManager>(context, listen: false).clear(cartCompanyId);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: FlatButton(
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Theme.of(context).accentColor.withOpacity(0.3),
          onPressed: press,
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: SvgPicture.asset(
                  icon,
                  semanticsLabel: label,
                  color: Theme.of(context).accentColor,
                  width: width,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(child: Text(text)),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
