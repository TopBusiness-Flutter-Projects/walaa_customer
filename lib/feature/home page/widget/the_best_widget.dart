import 'package:flutter/material.dart';

import '../../../core/widgets/network_image.dart';
import '../models/providers_model.dart';

class TheBestCoffeeWidget extends StatelessWidget {
  const TheBestCoffeeWidget({Key? key, required this.bestModel})
      : super(key: key);

  final List<ProviderModel> bestModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 20),
            ...List.generate(
              bestModel.length,
              (index) {
                return SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 150,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ManageNetworkImage(
                          imageUrl: bestModel[index].image!,
                          width: 120,
                          height: 120,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 8),
                                  Text(bestModel[index].rate.toString()),
                                  SizedBox(width: 12),
                                ],
                              ),
                              Text(
                                bestModel[index].name!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                bestModel[index].description ?? '',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
              },
            )
          ],
        ),
      ),
    );
  }
}
