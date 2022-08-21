import 'package:flutter/material.dart';
import 'package:rare_crew/utils/utils.dart';

class JobItemCard extends StatelessWidget {
  const JobItemCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: rareCrewColors.background,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: hPadding,
          vertical: vPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Software Engineer',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const YBox(10),
            IntrinsicWidth(
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: rareCrewColors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '10 - 100k EUR',
                    style: TextStyle(
                      fontSize: 16,
                      color: rareCrewColors.purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const YBox(20),
            Text(
              'Posted March 30, 2022',
              style: TextStyle(
                color: rareCrewColors.darkGrey,
              ),
            ),
            const YBox(10),
          ],
        ),
      ),
    );
  }
}
