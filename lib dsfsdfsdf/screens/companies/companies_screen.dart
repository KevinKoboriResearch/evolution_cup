import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/companies/company_manager.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/companies/components/company_grid_item.dart';
import 'package:mewnu/screens/companies_edit_company/edit_company_screen.dart';

// class CompaniesScreen extends StatelessWidget {
class CompaniesScreen extends StatefulWidget {
  _CompaniesScreenState createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  @override
  void initState() {
    final CompanyManager companyManager = Provider.of(context, listen: false);
    companyManager.loadCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final CompanyManager companyManager = Provider.of(context, listen: false);
    return Consumer<CompanyManager>(
      builder: (_, companyManager, __) {
        // companyManager.loadCompanies();
        final filteredCompanies = companyManager.filteredCompanies;
        return Scaffold(
        //  backgroundColor: Colors.white,
          body:  CustomScrollView(
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
                      if(userManager.isLoggedIn) {
                        if (userManager.user.companiesAdmin.length == 0) {
                          return IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.grey[500],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EditCompanyScreen(null)),
                              );
                            },
                          );
                        } else {
                        return Container();
                      }
                      }
                      else {
                        return Container();
                      }
                    },
                  ),
                ],
                title: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    'Lojas',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                expandedHeight: 10,
                toolbarHeight: 48,
                pinned: true,
                elevation: 0,
                backgroundColor: Theme.of(context).canvasColor,
                leading: Container(),
                leadingWidth: 0,
                title: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onChanged: (value) => companyManager.search = value,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "Pesquisar loja...",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: const Icon(Icons.search)),
                  ),
                ),
              ),
              // const SliverToBoxAdapter(
              //   child: SizedBox(
              //     height: 16,
              //   ),
              // ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  8.0,
                  16.0,
                  8.0,
                  8.0,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 203,
                    childAspectRatio: 0.88,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return CompanyGridItem(filteredCompanies[index], 'store');
                    },
                    childCount: filteredCompanies.length,
                  ),
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
