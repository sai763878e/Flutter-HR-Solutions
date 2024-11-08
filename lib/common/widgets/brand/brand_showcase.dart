import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/rounded_images.dart';
import 'c_brand_card.dart';

class CBrandShowCase extends StatelessWidget {
  const CBrandShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final isDark = CHelperFunction.isDarkMode(context);

    return CRoundedContainer(
      showBorder: true,
      borderColor: CColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.only(bottom: CSizes.spaceBtwItems),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CSizes.sm),
        child: Column(
          children: [
            ///Brand card
            const CBrandCard(
              brandName: 'Nike',
              showBorder: false,
            ),

            ///Brand Images
            Row(
              children: images
                  .map((image) =>
                  brandTopProductImageWidget(image, context, isDark))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context, bool isDark) {
    return Expanded(
      child: CRoundedContainer(
          height: 100,
          backgroundColor: isDark ? CColors.darkGrey : CColors.white,
          margin: EdgeInsets.all(CSizes.sm),
          child: CRoundImagePromotion(
            imageUrl: image,
            fit: BoxFit.cover,
          )),
    );
  }
}
