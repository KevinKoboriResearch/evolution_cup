import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:mewnu/models/checkout/credit_card.dart';
import 'package:mewnu/screens/carts_checkout/components/card_back.dart';
import 'package:mewnu/screens/carts_checkout/components/card_front.dart';

class CreditCardWidget extends StatefulWidget {
  const CreditCardWidget(this.creditCard);

  final CreditCard creditCard;

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final FocusNode numberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      actions: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      autoScroll: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FlipCard(
              key: cardKey,
              direction: FlipDirection.HORIZONTAL,
              speed: 700,
              flipOnTouch: false,
              front: CardFront(
                creditCard: widget.creditCard,
                numberFocus: numberFocus,
                dateFocus: dateFocus,
                nameFocus: nameFocus,
                finishedFront: () {
                  cardKey.currentState.toggleCard();
                  cvvFocus.requestFocus();
                },
              ),
              back: CardBack(
                creditCard: widget.creditCard,
                cvvFocus: cvvFocus,
                finishedBack: () {
                  cardKey.currentState.toggleCard();
                  nameFocus.requestFocus();
                },
              ),
            ),
            TextButton(
              onPressed: () {
                cardKey.currentState.toggleCard();
              },
              child: const Text('Virar cartão'),
            )
          ],
        ),
      ),
    );
  }
}
