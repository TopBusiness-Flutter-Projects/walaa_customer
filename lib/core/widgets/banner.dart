import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/home_model.dart';
import '../utils/assets_manager.dart';
import 'dotes.dart';
import 'network_image.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key, this.isDotes = true, required this.sliderData})
      : super(key: key);
  final List<SliderModel> sliderData;
  final bool isDotes;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.sliderData.isEmpty) {
      return Image.asset(ImageAssets.walaaLogoImage,height: 150,width:  MediaQuery.of(context).size.width * 0.88,);
    } else {
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (int i, CarouselPageChangedReason c) {
                setState(() {
                  page = i;
                });
              },
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              autoPlay: true,
              height: MediaQuery.of(context).size.height * 0.18,
              reverse: true,
              viewportFraction: 1.0,
              animateToClosest: true,
            ),
            items: widget.sliderData.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () async {
                      // String url = i.image.toString();
                      // await launchUrl(Uri.parse(url));
                    },
                    child: ManageNetworkImage(
                      imageUrl: i.image!,
                      borderRadius: 10,
                      width: MediaQuery.of(context).size.width * 0.88,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          // widget.isDotes == true
          //     ? const SizedBox(height: 18)
          //     : const SizedBox(height: 0),
          // widget.isDotes == true
          //     ? DotesWidget(
          //         page: page,
          //         length: widget.sliderData.length,
          //       )
          //     : Container(),
        ],
      );
    }
  }
}
