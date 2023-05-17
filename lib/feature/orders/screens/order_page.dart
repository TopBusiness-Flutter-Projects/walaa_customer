import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../cubit/order_cubit.dart';
import '../widgets/order_list.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key, required this.type}) : super(key: key);
final String type;
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {

    context.read<OrderCubit>().setlang("ar");
    return Scaffold(

      body: OrderList(type:widget.type),
    );
  }
}
