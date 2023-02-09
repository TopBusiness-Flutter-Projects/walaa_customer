import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/circle_network_image.dart';
import '../../home page/models/providers_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.model}) : super(key: key);
  final CategoryModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          child: ManageCircleNetworkImage(
            imageUrl: model.image!,
            height: 120,
            width: 120,
          ),
        ),
        SizedBox(height: 8),
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
