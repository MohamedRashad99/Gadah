import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/config/network_constents.dart';

class CategoryItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final String? imageUrl;

  const CategoryItem({
    Key? key,
    this.onTap,
    this.title,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 0.2,
              blurRadius: 5,
            )
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: _buildCategoryImage(),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.5, 1],
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(1),
                      ],
                    ).createShader(
                      Rect.fromLTRB(
                        0,
                        -100,
                        rect.width,
                        rect.height,
                      ),
                    );
                  },
                  blendMode: BlendMode.srcIn,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.85),
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryImage() {
    Widget _child = const SizedBox();
    if (imageUrl == Constants.miniLogo) {
      _child = SvgPicture.asset(
        Constants.miniLogo,
        color: AppColors.darkGreenAccent,
      );
    } else if (imageUrl != null) {
      if (imageUrl!.startsWith('http')) {
        _child = FancyShimmerImage(
          imageUrl: kServerUrlWithourSlach + imageUrl!,
          boxFit: BoxFit.cover,
          shimmerBaseColor: Colors.grey[300],
          shimmerHighlightColor: Colors.grey[100],
        );
      } else if (imageUrl!.endsWith('svg')) {
        _child = SvgPicture.asset(
          kServerUrlWithourSlach + imageUrl!,
          color: AppColors.darkGreenAccent,
        );
      } else {
        _child = Image.network(
          kServerUrlWithourSlach + imageUrl!,
          fit: BoxFit.cover,
        );
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: _child,
    );
  }
}
