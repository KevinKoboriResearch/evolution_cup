import 'package:flutter/material.dart';
import 'package:mewnu/models/home/home_manager.dart';
import 'package:mewnu/models/home/section.dart';

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget(this.categoriesManager);

  final HomeManager categoriesManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextButton(
            onPressed: () {
              categoriesManager.addSection(Section(type: 'List'));
            },
            child: const Text('Adicionar Lista'),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              categoriesManager.addSection(Section(type: 'Staggered'));
            },
            child: const Text('Adicionar Grade'),
          ),
        ),
      ],
    );
  }
}
