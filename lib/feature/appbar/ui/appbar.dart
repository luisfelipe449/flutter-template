import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/logot.png',
          width: 300,
          height: 100,
          color: const Color.fromARGB(255, 39, 99, 63),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
