import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../cubit/order_cubit.dart';
import 'order_widget.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key, required this.type}) : super(key: key);
final String type;
  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        OrderCubit orderCubit = context.read<OrderCubit>();

        // if(context.read<OrderCubit>().OrderList.length>0){
        //
        //  OrderCubit().getProduct(context.read<OrderCubit>().userModel,OrderCubit().OrderList.elementAt(0).id);
        //
        // }
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:widget.type=="current"?
          Column(
            children: [
              ...List.generate(
                orderCubit.odersize,
                (index) => state is AllOrderLoading
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width - 70,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    : state is AllOrderError
                        ? Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.refresh),
                            ),
                          )
                        : orderCubit.neworderList.isNotEmpty
                            ? InkWell(
                                onTap: () {

                                },
                                child: OrderItem(
                                  orderModel: orderCubit.neworderList
                                      .elementAt(index),
                                  index: index,

                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
              ),
            ],
          )
          :Column(
            children: [
              ...List.generate(
                orderCubit.odersize1,
                (index) => state is AllOrderLoading
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width - 70,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    : state is AllOrderError
                        ? Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.refresh),
                            ),
                          )
                        : orderCubit.oldorderList.isNotEmpty
                            ? InkWell(
                                onTap: () {

                                },
                                child: OrderItem(
                                  orderModel: orderCubit.oldorderList
                                      .elementAt(index),
                                  index: index,
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
              ),
            ],
          ),
        );
      },
    );
  }
}
