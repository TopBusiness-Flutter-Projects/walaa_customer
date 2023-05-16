import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/circle_network_image.dart';
import '../../home page/models/providers_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.model}) : super(key: key);
  final CategoryModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
          child: ManageNetworkImage(
            imageUrl: model.image!,
            height: 25,
            width: 25,
            borderRadius: 25,
          ),
        ),
        SizedBox(width: 8),
        Text(
          model.categoryName!,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textBackground,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
