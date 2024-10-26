import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pos_flutter_app/utils/constants/constants.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/images/slider1.png',
      'assets/images/slider2.png',
      'assets/images/slider3.png',
    ];

    return Container(
      height: 150,
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true, // Tự động chuyển
          height: 150, // Chiều cao của carousel
          enlargeCenterPage: true, // Phóng to hình giữa
          viewportFraction: 1,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
        ),
        items: imgList.map((imgUrl) {
          return Container(
            width: double.infinity,
            margin:const EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
              color: PRIMARY_COLOR,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(DEFAULT_BORDER_RADIUS),
              child: Image.asset(
                imgUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
