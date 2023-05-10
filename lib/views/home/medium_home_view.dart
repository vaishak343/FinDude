import 'package:flutter/material.dart';

import 'common_widgets.dart';
import 'custom_background.dart';

class MediumHomeView extends StatelessWidget {
  const MediumHomeView({super.key});

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
        const CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: AppBarWidget(),
            )
          ],
        ),
      ],
    );
  }
}
