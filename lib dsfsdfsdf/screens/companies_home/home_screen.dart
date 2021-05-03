


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/home/home_manager.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/companies_home/components/add_section_widget.dart';
import 'package:mewnu/screens/companies_home/components/section_list.dart';
import 'package:mewnu/screens/companies_home/components/section_staggered.dart';
import 'package:mewnu/models/companies/company.dart';
class CompanyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
       final Company company = Provider.of(context, listen: false);
    return CustomScrollView(
      slivers: <Widget>[
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverAppBar(
          floating: true,
          snap: true,
          elevation: 0,
          expandedHeight: 10,
          toolbarHeight: 40,
          // backgroundColor: Theme.of(context).canvasColor,
           title: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              company.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Consumer2<UserManager, HomeManager>(
                builder: (_, userManager, categoriesManager, __) {
                  if (userManager.adminEnabled(context) &&
                      !categoriesManager.loading) {
                    if (categoriesManager.editing) {
                      return PopupMenuButton(
                        onSelected: (e) {
                          if (e == 'Salvar') {
                            categoriesManager.saveEditing(company.id);
                          } else {
                            categoriesManager.discardEditing();
                          }
                        },
                        itemBuilder: (_) {
                          return ['Salvar', 'Descartar'].map((e) {
                            return PopupMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList();
                        },
                      );
                    } else {
                      return IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        onPressed: categoriesManager.enterEditing,
                      );
                    }
                  } else
                    return Container();
                },
              ),
            ),
            const SizedBox(width: 4)
          ],
         
        ),
        Consumer<HomeManager>(
          builder: (_, categoriesManager, __) {
            if (categoriesManager.loading) {
              return const SliverToBoxAdapter(
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                  backgroundColor: Colors.transparent,
                ),
              );
            }

            final List<Widget> children =
                categoriesManager.sections.map<Widget>((section) {
              switch (section.type) {
                case 'List':
                  return SectionList(section);
                case 'Staggered':
                  return SectionStaggered(section);
                default:
                  return Container();
              }
            }).toList();
            

            if (categoriesManager.editing)
              children.add(AddSectionWidget(categoriesManager));

            return SliverList(
              delegate: SliverChildListDelegate(children),
            );
          },
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}
