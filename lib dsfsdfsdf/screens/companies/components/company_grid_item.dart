import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:mewnu/models/companies/company.dart';
import 'package:mewnu/models/categories/category_manager.dart';
import 'package:mewnu/models/user/user_manager.dart';
import 'package:mewnu/screens/companies_categories/categories_screen.dart';
import 'package:mewnu/screens/companies_edit_company/edit_company_screen.dart';

class CompanyGridItem extends StatefulWidget {
  final Company company;
  final String pageType;
  const CompanyGridItem(this.company, this.pageType);

  @override
  _CompanyGridItemState createState() => _CompanyGridItemState();
}

class _CompanyGridItemState extends State<CompanyGridItem> {
  @override
  Widget build(BuildContext context) {
    final Company companyProvider = Provider.of(context, listen: false);
    companyProvider.setCompany(widget.company);

    final Company company = Provider.of(context, listen: false);
    return Consumer<UserManager>(
      builder: (_, userManager, __) {
        return GestureDetector(
          onTap: () async {
           company.setCompany(widget.company);
            final CategoryManager categoryManager =
                Provider.of(context, listen: false);
            await categoryManager.loadCompanyCategories(widget.company.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CompanyCategoriesScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              color: Colors.grey[100],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Image.network(
                                widget.company.images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: widget.company.images.length, //10,
                    viewportFraction: 1,
                    scale: 0.9,
                    // autoplay: true,
                    pagination: widget.company.images.length <= 1
                        ? null
                        : SwiperPagination(
                            margin: EdgeInsets.all(0.0),
                            builder: SwiperCustomPagination(
                              builder: (BuildContext context,
                                  SwiperPluginConfig config) {
                                return ConstrainedBox(
                                  constraints:
                                      BoxConstraints.expand(height: 20.0),
                                  child: Center(
                                    child: DotSwiperPaginationBuilder(
                                            color: Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.4),
                                            activeColor:
                                                Theme.of(context).accentColor,
                                            size: 8.0,
                                            activeSize: 8.0)
                                        .build(context, config),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0), // bottom: 15), //24.0),
                      child: LayoutBuilder(
                        builder: (context, size) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const SizedBox(height: 4),
                              Text(
                                widget.company.name,
                                style:  const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 4,
                      child: userManager.isLoggedIn &&
                              userManager.adminEnabled(context)
                          ? SizedBox(
                              height: 18.0,
                              width: 18.0,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            EditCompanyScreen(widget.company)),
                                  );
                                },
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.edit, size: 16, color: Colors.grey),
                              ),
                            )
                          : Container(),
                          // SizedBox(
                          //     height: 18.0,
                          //     width: 18.0,
                          //     child: IconButton(
                          //       onPressed: () {},
                          //       padding: const EdgeInsets.all(0.0),
                          //       icon: SvgPicture.asset(
                          //         'assets/icons/Heart Icon.svg',
                          //         semanticsLabel: 'Perfil',
                          //         height: 18,
                          //       ),
                          //     ),
                          //   ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
