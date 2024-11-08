import 'package:flutter/material.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/circular_image.dart';
import '../texts/brand_title_with_verification_icon.dart';

class CBrandCard extends StatelessWidget {
  const CBrandCard({
    super.key,
    this.showBorder = true,
    this.onTap,
    required this.brandName,
    this.productCount = "200",
    this.brandIcon = CImages.homeBanner_2,
  });

  final String brandName;
  final String productCount;
  final String brandIcon;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = CHelperFunction.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: CRoundedContainer(
        padding: const EdgeInsets.all(CSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            ///Icon
            Flexible(
              child: CCircularImage(
                  imageUrl: CImages.homeBanner_2,
                  isNetworkImage: false,
                  backgroundColor: Colors.transparent,
                  overlayColor: isDark ? Colors.white : Colors.black),
            ),
            const SizedBox(
              width: CSizes.spaceBtwItems / 2,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CBrandTitleWithVerificationIcon(
                    title: 'Nike',
                    mainAxisSize: MainAxisSize.min,
                    brandTextSize: TextSize.large,
                  ),
                  Text(
                    '256 products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
