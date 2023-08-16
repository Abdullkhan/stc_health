import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_health/repositories/api_repository.dart';
import 'package:stc_health/response/all_products_response.dart';

part 'allProducts_event.dart';
part 'allProducts_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  AllProductsBloc() : super(InitialAllProductsState());
  @override
  Stream<AllProductsState> mapEventToState(AllProductsEvent event) async* {
    if (event is AllProductsData) {
      yield LoadingAllProductsState();
      try {
        dynamic response = await ApiRepositories().getAllProducts();
        print('----ALL-PRODU   CTS  Api STARTED-----${response}');
        // AllProductsResponse allProductsResponse = AllProductsResponse.fromJson(response);
        yield AllProductsSuccess(data: response);
      } catch (e) {
        print("----PLEASE CHECK ALL-PRODUCTS BLOC----");
        print('the error is ${e.toString()}');
      }
    }
  }
}
