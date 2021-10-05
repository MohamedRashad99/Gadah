import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/modules/shared/slider/cubit/slider_cubit.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:queen/queen.dart';

class HomeSlider extends StatelessWidget {
  HomeSlider({Key? key}) : super(key: key);
  final cubit = SliderCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderState>(
      bloc: cubit,
      builder: (_, state) {
        if (state is SliderEmpty) {
          return const SizedBox();
        } else if (state is SliderLoading) {
          return const CenterLoading();
        } else if (state is SliderCant) {
          return Center(child: Text(state.msg));
        } else if (state is SliderLoaded) {
          return SizedBox(
            height: height * .235,
            child: Center(
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: height * .20,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
                itemCount: state.slides.length,
                itemBuilder: (_, index, realIndex) {
                  final slide = state.slides[index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: width * .05,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.bloodRed,
                          spreadRadius: 0.2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: FancyShimmerImage(
                        imageUrl: fullImagePath(slide.imagePath),
                        width: width,
                        shimmerBaseColor: Colors.grey[300],
                        shimmerHighlightColor: Colors.grey[100],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        throw state;
      },
    );
  }
}
