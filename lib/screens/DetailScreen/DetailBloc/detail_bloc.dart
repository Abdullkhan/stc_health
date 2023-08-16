import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stc_health/repositories/api_repository.dart';
import 'package:stc_health/response/detail_product_response.dart';

part 'detail_state.dart';
part 'detail_event.dart';

class DetailProductBloc extends Bloc<DetailProductsEvent, DetailProductsState> {
  DetailProductBloc() : super(InitialDetailProductsState());
  @override
  Stream<DetailProductsState> mapEventToState(DetailProductsEvent event) async* {
    if (event is DetailProductsData) {
      yield LoadingDetailProductsState();
      try {
        dynamic response = await ApiRepositories().getDetailProducts(id: event.id);
        print('----DETAIL-PRODUCTS  Api STARTED-----${response}');
        DetailProductResponse detailProductResponse = DetailProductResponse.fromJson(response);
        yield DetailProductsSuccess(data: detailProductResponse);
      } catch (e) {
        print("----PLEASE CHECK ALL-PRODUCTS BLOC----");
        print('the error is ${e.toString()}');
      }
    }
  }
}
