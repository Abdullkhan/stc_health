import 'package:stc_health/providers/all_products_provider.dart';
import 'package:stc_health/providers/detail_provider.dart';
import 'package:stc_health/providers/login_provider.dart';

class ApiRepositories {
  Future getLogin() async => LoginProvider.addLoginProvider();
  Future getAllProducts() async => AllProductsProvider.addAllProducts();
  Future getDetailProducts({required int id}) async => DetailPageProvider.addDetailProducts(id: id);
}
