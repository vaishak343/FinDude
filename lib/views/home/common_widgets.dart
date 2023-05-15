import 'package:findude/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

enum CreditCardType { visa, mastercard, rupay }

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  IconData icon = Icons.wb_sunny_outlined;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.primary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      centerTitle: false,
      toolbarHeight: 70,
      title: Row(
        children: const [
          Flexible(
            flex: 1,
            child: CircleAvatar(
              foregroundImage: AssetImage('assets/avatar_1.png'),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Mark Johnson",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FilledButton.tonal(
            onPressed: () {
              setState(() {
                if (icon == Icons.wb_sunny_outlined) {
                  icon = Icons.nightlight_outlined;
                } else {
                  icon = Icons.wb_sunny_outlined;
                }
              });
              context.read<HomeCubit>().changeTheme();
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                icon,
                key: UniqueKey(),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PageHeaderWidget extends StatelessWidget {
  const PageHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your card information",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                RichText(
                  text: TextSpan(
                    text: "All Credit Cards",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                    children: [
                      TextSpan(
                        text: " (5)",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                left: 0,
                right: 16,
              ),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle,
              size: 40,
            ),
            label: const Text("Add"),
          ),
        ],
      ),
    );
  }
}

class CreditCardsSection extends StatefulWidget {
  const CreditCardsSection({super.key});

  @override
  State<CreditCardsSection> createState() => _CreditCardsSectionState();
}

class _CreditCardsSectionState extends State<CreditCardsSection> {
  late List<Widget>? listOfCards;

  final CardSwiperController controller = CardSwiperController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listOfCards = [
      const CreditCardWidget(type: CreditCardType.visa),
      const CreditCardWidget(type: CreditCardType.mastercard),
      const CreditCardWidget(type: CreditCardType.rupay),
      const CreditCardWidget(type: CreditCardType.visa),
      const CreditCardWidget(type: CreditCardType.rupay),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 450,
        maxHeight: 250,
      ),
      child: CardSwiper(
        controller: controller,
        cardsCount: listOfCards!.length,
        onSwipe: (
          int previousIndex,
          int? currentIndex,
          CardSwiperDirection direction,
        ) {
          debugPrint(
            'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
          );
          return true;
        },
        numberOfCardsDisplayed: 3,
        isHorizontalSwipingEnabled: false,
        backCardOffset: const Offset(0, -20),
        cardBuilder: (context, index) => listOfCards![index],
      ),
    );
  }
}

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({
    required this.type,
    super.key,
  });

  final CreditCardType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.tertiaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: [
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 60,
            width: 120,
            child: _showImage(type),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "**** **** **** 3732",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                "Mark Johnson",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              )),
              const Expanded(
                  child: Text(
                "09/26",
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
        )
      ]),
    );
  }

  Image _showImage(CreditCardType type) {
    switch (type) {
      case CreditCardType.visa:
        return Image.asset('assets/visa.png');
      case CreditCardType.mastercard:
        return Image.asset('assets/mastercard.png');
      case CreditCardType.rupay:
        return Image.asset('assets/rupay.png');
    }
  }
}

class TransactionCardWidget extends StatelessWidget {
  const TransactionCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: ListTile(
        leading: Image.asset(
          'assets/uber.png',
        ),
        title: const Text("Uber"),
        subtitle: const Text("Today, 12:15"),
        trailing: Text(
          "16.4 \$",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
