import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      centerTitle: false,
      pinned: true,
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
            onPressed: () {},
            child: const Icon(Icons.notifications_none_outlined),
          ),
        )
      ],
    );
  }
}
