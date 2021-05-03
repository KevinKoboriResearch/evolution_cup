


import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/home/home_manager.dart';
import 'package:mewnu/models/home/section.dart';
import 'package:mewnu/screens/companies_home/components/add_tile_widget.dart';
import 'package:mewnu/screens/companies_home/components/section_header.dart';
import 'package:mewnu/screens/companies_home/components/section_item.dart';
import 'package:mewnu/models/companies/company.dart';
class SectionStaggered extends StatelessWidget {

  const SectionStaggered(this.section);

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
            Consumer<Section>(
              builder: (_, section, __){
                return StaggeredGridView.countBuilder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categoriesManager.editing
                      ? section.items.length + 1
                      : section.items.length,
                  itemBuilder: (_, index){
                    if(index < section.items.length)
                      return ItemTile(section.items[index],company.id);
                    else
                      return AddTileWidget();
                  },
                  staggeredTileBuilder: (index) =>
                      StaggeredTile.count(2, index.isEven ? 2 : 1),
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
