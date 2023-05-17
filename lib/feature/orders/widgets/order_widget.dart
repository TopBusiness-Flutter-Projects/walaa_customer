import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/models/order_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/outline_button_widget.dart';

class OrderItem extends StatefulWidget {
  final OrderModel orderModel;
  final int index;

  const OrderItem({Key? key, required this.orderModel, required this.index}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 3,
                color: AppColors.white,
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            SvgPicture.asset(ImageAssets.calenderIcon),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${widget.orderModel.dataTime}",
                              style: TextStyle(
                                  color: AppColors.gray1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${widget.orderModel.provider_data.name}",
                            style: TextStyle(
                                color: AppColors.gray1,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${widget.orderModel.totalPrice}" + "sar",
                            style: TextStyle(
                                color: AppColors.seconedprimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 35,
                height: 35,
                margin: EdgeInsets.only(left: 10,top: 10),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    (widget.index+1).toString(),
                    style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
