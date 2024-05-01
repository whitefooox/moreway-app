import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesCarousel extends StatefulWidget {
  final List<String> images;

  const ImagesCarousel({super.key, required this.images});

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  CarouselController buttonCarouselController = CarouselController();

  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
              carouselController: buttonCarouselController,
              items: widget.images
                  .map((e) => Image.network(
                        e,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.not_interested),
                          );
                        },
                      ))
                  .toList(),
              options: CarouselOptions(
                height: constraints.maxHeight,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                autoPlay: widget.images.length != 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentImageIndex = index;
                  });
                },
              )),
          Positioned(
              bottom: 10 + constraints.maxHeight * 0.1,
              child: AnimatedSmoothIndicator(
                activeIndex: currentImageIndex,
                count: widget.images.length,
                effect: const ExpandingDotsEffect(
                    dotColor: AppColor.white,
                    activeDotColor: AppColor.pink,
                    dotHeight: 10,
                    dotWidth: 10),
              ))
        ],
      ),
    );
  }
}
