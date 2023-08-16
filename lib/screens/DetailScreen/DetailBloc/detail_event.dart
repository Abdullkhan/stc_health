part of 'detail_bloc.dart';

abstract class DetailProductsEvent {}

class DetailProductsData extends DetailProductsEvent {
  final int id;
  DetailProductsData({required this.id});
}
