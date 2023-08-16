part of 'allProducts_bloc.dart';

abstract class AllProductsState {}

class AllProductsSuccess extends AllProductsState {
  var data;
  AllProductsSuccess({required this.data});
}

class LoadingAllProductsState extends AllProductsState {}

class InitialAllProductsState extends AllProductsState {}

class ErrorAllProductsState extends AllProductsState {
  final String error;
  ErrorAllProductsState({required this.error});
}
