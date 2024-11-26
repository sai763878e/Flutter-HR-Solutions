
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class CoachMarkDesc extends StatelessWidget {
  final String text;
  final String skip;
  final String next;
  final void Function()? onSkip;
  final void Function()? onNext;

  const CoachMarkDesc(
      {super.key,
        required this.text,
        this.skip = "Skip",
        this.next = "Next",
        this.onSkip,
        this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CSizes.xmd),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(CSizes.md)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: CSizes.spaceBtwItems,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: onSkip, child: Text(skip,
                style: Theme.of(context).textTheme.bodyMedium,
              )),
              const SizedBox(
                width: CSizes.spaceBtwItems,
              ),
              ElevatedButton(onPressed: onNext, child: Text(next,
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
              ))
            ],
          )
        ],
      ),
    );
  }
}
