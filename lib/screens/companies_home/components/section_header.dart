import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/common/custom_icon_button.dart';
import 'package:mewnu/models/home/home_manager.dart';
import 'package:mewnu/models/home/section.dart';

class SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoriesManager = context.watch<HomeManager>();
    final section = context.watch<Section>();

    if (categoriesManager.editing) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  initialValue: section.name,
                  decoration: const InputDecoration(
                      hintText: 'Título',
                      isDense: true,
                      border: InputBorder.none),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                  onChanged: (text) => section.name = text,
                ),
              ),
              CustomIconButton(
                iconData: Icons.remove,
                onTap: () {
                  categoriesManager.removeSection(section);
                },
              ),
            ],
          ),
          if (section.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                section.error,
                style: const TextStyle(color: Colors.red),
              ),
            )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          section.name ?? "Banana",
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      );
    }
  }
}
