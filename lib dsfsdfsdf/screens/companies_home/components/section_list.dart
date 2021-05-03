



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/home/home_manager.dart';
import 'package:mewnu/models/home/section.dart';
import 'package:mewnu/screens/companies_home/components/add_tile_widget.dart';
import 'package:mewnu/screens/companies_home/components/section_header.dart';
import 'package:mewnu/screens/companies_home/components/section_item.dart';
import 'package:mewnu/models/companies/company.dart';
class SectionList extends StatelessWidget {

  const SectionList(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final categoriesManager = context.watch<HomeManager>();
   final Company company = Provider.of(context, listen: false);
    return ChangeNotifierProvider.value(
      value: section,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionHeader(),
            SizedBox(
              height: 170,
              child: Consumer<Section>(
                builder: (_, section, __){
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index){
                      if(index < section.items.length)
                        return ItemTile(section.items[index], company.id);
                      else
                        return AddTileWidget();
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 6,),
                    itemCount: categoriesManager.editing
                        ? section.items.length + 1
                        : section.items.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
