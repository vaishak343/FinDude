import 'package:flutter/material.dart';

import 'common_widgets.dart';
import 'custom_background.dart';

class SmallHomeView extends StatelessWidget {
  const SmallHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter:
              CustomBackground(color: Theme.of(context).colorScheme.primary),
          size: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 2,
          ),
        ),
        CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              sliver: AppBarWidget(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Your card information",
                        ),
                        RichText(
                          maxLines: 2,
                          softWrap: true,
                          text: TextSpan(
                            text: "All Credit Cards",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: 50),
                            children: const [
                              TextSpan(
                                text: "(2)",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
