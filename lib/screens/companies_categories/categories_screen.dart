import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/models/categories/category_manager.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/companies_categories/components/category_grid_item.dart';
import 'package:mewnu/screens/companies_edit_category/edit_category_screen.dart';

class CompanyCategoriesScreen extends StatelessWidget {
  // CompanyCategoriesScreen();
  // String companyId;
  // String companyName;
  @override
  Widget build(BuildContext context) {
    final Company companyProvider = Provider.of(context, listen: false);
    return Consumer<CategoryManager>(
      builder: (_, categoryManager, __) {
        final filteredCategories = categoryManager.filteredCategories;
        return Scaffold(
          // backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverAppBar(
                floating: true,
                snap: true,
                elevation: 0,
                expandedHeight: 10,
                toolbarHeight: 40,
                backgroundColor: Theme.of(context).canvasColor,
                actions: <Widget>[
                  Consumer<UserManager>(
                    builder: (_, userManager, __) {
                      if (userManager.adminEnabled(context)) {
                        return IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.grey[500],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EditCategoryScreen(null)),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
                title: Text(
                  '${companyProvider.name}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                titleSpacing: 0,
              ),
              SliverAppBar(
                expandedHeight: 10,
                toolbarHeight: 48,
                pinned: true,
                elevation: 0,
                backgroundColor: Theme.of(context).canvasColor,
                leading: Container(),
                leadingWidth: 0,
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  child: Container(
                    // width: SizeConfig.screenWidth * 0.64,
                    height: 38,
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      onChanged: (value) => categoryManager.search = value,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "Pesquisar categoria...",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: const Icon(Icons.search)),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 15,
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 406,
                  childAspectRatio: 1.66,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CategoryGridItem(filteredCategories[index], 'store');
                  },
                  childCount: filteredCategories.length,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
