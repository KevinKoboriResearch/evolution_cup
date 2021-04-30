import 'package:flutter/material.dart';
import 'package:mewnu/router/routes.dart';

class MewnuRouteInformationParser
    extends RouteInformationParser<MewnuRoutePath> {
  @override
  Future<MewnuRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    // if (uri.pathSegments.length >= 2) {
    //   if (uri.pathSegments[0] == 'products') {
    //     return ProductDetailsPath(uri.pathSegments[1]);
    //   }
    // } else {
    if (uri.pathSegments.isEmpty || uri.pathSegments[0] == 'products') {
      if (uri.pathSegments.length == 2) {
        return ProductDetailsPath(uri.pathSegments[1]);
      }
      return SearchPath();
    } else if (uri.pathSegments[0] == 'favorites') {
      return FavoritesPath();
    } else if (uri.pathSegments[0] == 'store') {
      return StorePath();
    } else if (uri.pathSegments[0] == 'carts') {
      return CartsPath();
    } else if (uri.pathSegments[0] == 'profile') {
      return ProfilePath();
    } else {
      return Error404Path();
    }
    // }
  }

  @override
  RouteInformation restoreRouteInformation(MewnuRoutePath configuration) {
    if (configuration is SearchPath) {
      return RouteInformation(location: '/products');
    }
    if (configuration is ProductDetailsPath) {
      return RouteInformation(location: '/products/${configuration.id}');
    }
    if (configuration is FavoritesPath) {
      return RouteInformation(location: '/favorites');
    }
    if (configuration is StorePath) {
      return RouteInformation(location: '/store');
    }
    if (configuration is CartsPath) {
      return RouteInformation(location: '/carts');
    }
    if (configuration is ProfilePath) {
      return RouteInformation(location: '/profile');
    }
    return null;
  }
}
