import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name;
  final String amount;
  final String code;
  final IconData icon;
  final bool isInverted;
  final double yPushC;
  final double scaleIcon;

  final _blackColor = const Color(0xFF1F2123);

  const CurrencyCard({
    super.key,
    required this.name,
    required this.amount,
    required this.code,
    required this.icon,
    required this.isInverted,
    required this.yPushC,
    required this.scaleIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, yPushC),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isInverted ? Colors.white : _blackColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: isInverted ? _blackColor : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          fontSize: 20,
                          color: isInverted ? _blackColor : Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        code,
                        style: TextStyle(
                          fontSize: 20,
                          color: isInverted
                              ? _blackColor
                              : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Transform.scale(
                scale: scaleIcon,
                child: Transform.translate(
                  offset: const Offset(6, 15),
                  child: Icon(
                    icon,
                    color: isInverted ? _blackColor : Colors.white,
                    size: 88,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
