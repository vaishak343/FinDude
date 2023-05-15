import 'package:flutter/material.dart';

import 'common_widgets.dart';
import 'custom_background.dart';

class SmallHomeView extends StatefulWidget {
  const SmallHomeView({super.key});

  @override
  State<SmallHomeView> createState() => _SmallHomeViewState();
}

class _SmallHomeViewState extends State<SmallHomeView> {
  bool hasScrolled = false;
  late DraggableScrollableController draggableScrollController;

  @override
  void initState() {
    super.initState();
    draggableScrollController = DraggableScrollableController();
    draggableScrollController.addListener(() {
      if (draggableScrollController.isAttached) {
        if (draggableScrollController.size == 0.25 && hasScrolled) {
          setState(() {
            hasScrolled = false;
          });
        } else if (draggableScrollController.size > 0.25 && !hasScrolled) {
          setState(() {
            hasScrolled = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    draggableScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: CustomBackground(
            color: Theme.of(context).colorScheme.primary,
          ),
          size: Size(MediaQuery.of(context).size.width, 600),
        ),
        CustomScrollView(
          controller: ScrollController(),
          slivers: const [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              sliver: AppBarWidget(),
            ),
            SliverToBoxAdapter(
              child: PageHeaderWidget(),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: CreditCardsSection(),
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: DraggableScrollableSheet(
            initialChildSize: 0.25,
            controller: draggableScrollController,
            minChildSize: 0.25,
            maxChildSize: 1,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                color: Theme.of(context).colorScheme.background,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Latest",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Transactions",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            hasScrolled
                                ? const Icon(Icons.arrow_downward_outlined)
                                : const Icon(Icons.arrow_upward_outlined),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: 45,
                        itemBuilder: (context, index) {
                          return const TransactionCardWidget();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
