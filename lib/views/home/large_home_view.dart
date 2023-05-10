import 'package:flutter/material.dart';

import 'home.dart';

class LargeHomeView extends StatefulWidget {
  const LargeHomeView({super.key});

  @override
  State<LargeHomeView> createState() => _LargeHomeViewState();
}

class _LargeHomeViewState extends State<LargeHomeView> {
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
            ),
             
          ],
        ),
      ],
    );
  }
}
