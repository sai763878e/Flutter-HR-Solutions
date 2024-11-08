import 'package:hr_solutions/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:hr_solutions/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:hr_solutions/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:hr_solutions/features/authentication/screens/onboarding/widgets/onboarding_pages.dart';
import 'package:hr_solutions/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:hr_solutions/utils/constants/colors.dart';
import 'package:hr_solutions/utils/constants/image_strings.dart';
import 'package:hr_solutions/utils/constants/sizes.dart';
import 'package:hr_solutions/utils/constants/text_strings.dart';
import 'package:hr_solutions/utils/device/device_utility.dart';
import 'package:hr_solutions/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            //Horizontal Scrollable Pages
            children: [
              OnBoardingPages(
                image: CImages.onBoardingImage1,
                title: CTexts.onBoardingTitle1,
                subTitle: CTexts.onBoardingSubTitle1,
              ),
              OnBoardingPages(
                image: CImages.onBoardingImage2,
                title: CTexts.onBoardingTitle2,
                subTitle: CTexts.onBoardingSubTitle2,
              ),
              OnBoardingPages(
                image: CImages.onBoardingImage3,
                title: CTexts.onBoardingTitle3,
                subTitle: CTexts.onBoardingSubTitle3,
              )
            ],
          ),
          //Skip Buttons
          const OnBoardingSkip(),
          //Dot Navigation SmoothPageIndicator
          const OnBoardDotNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
