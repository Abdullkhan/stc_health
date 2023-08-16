part of 'detail_bloc.dart';

abstract class DetailProductsState {}

class DetailProductsSuccess extends DetailProductsState {
  final DetailProductResponse data;
  DetailProductsSuccess({required this.data});
}

class LoadingDetailProductsState extends DetailProductsState {}

class InitialDetailProductsState extends DetailProductsState {}

class ErrorDetailProductsState extends DetailProductsState {
  final String error;
  ErrorDetailProductsState({required this.error});
}
