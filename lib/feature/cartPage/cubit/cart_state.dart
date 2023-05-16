part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}


class CartChangeItemCount extends CartState {}

class GetTotalPrice extends CartState {}
