part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}
class AllOrderLoading extends OrderState {}
class OrderChangeCurrentIndexTap extends OrderState {}
class AllOrderError extends OrderState {}
class AllOrderLoaded extends OrderState {
  final List<OrderModel> OrderList;

  AllOrderLoaded(this.OrderList);

}