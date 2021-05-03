abstract class MewnuRoutePath {}

class SearchPath extends MewnuRoutePath {}
class ProductDetailsPath extends MewnuRoutePath {
  final String id;
  ProductDetailsPath(this.id);
}
class FavoritesPath extends MewnuRoutePath {}
// class UsersDetailsPath extends MewnuRoutePath {
//   final String username;
//   UsersDetailsPath(this.username);
// }
class ProfilePath extends MewnuRoutePath {}
// class UsersDetailsPath extends MewnuRoutePath {
//   final String username;
//   UsersDetailsPath(this.username);
// }
class StorePath extends MewnuRoutePath {}
// class UsersDetailsPath extends MewnuRoutePath {
//   final String username;
//   UsersDetailsPath(this.username);
// }
class CartsPath extends MewnuRoutePath {}
// class UsersDetailsPath extends MewnuRoutePath {
//   final String username;
//   UsersDetailsPath(this.username);
// }
class Error404Path extends MewnuRoutePath {}
