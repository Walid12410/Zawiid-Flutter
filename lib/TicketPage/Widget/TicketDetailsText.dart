import 'package:flutter/material.dart';
import 'package:zawiid/Color&Icons/color.dart';

class TicketDetailsText extends StatelessWidget {
  const TicketDetailsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Buy a 1\$ ticket and enter ',
            style: TextStyle(
              fontSize: 18.0,
              color: tdGrey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'A withdrawal on a ',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: tdGrey,
                  ),
                ),
              ),
              Text(
                'WASHING-MACHINE!',
                style: TextStyle(
                  color: tdGrey,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
