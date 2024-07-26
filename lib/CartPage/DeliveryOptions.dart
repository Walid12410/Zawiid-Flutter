import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';

import '../Classes/Delivery/Delivery.dart';
import '../provider/Delivery_Provider.dart';

class DeliveryOptionDialog extends StatefulWidget {
  @override
  _DeliveryOptionDialogState createState() => _DeliveryOptionDialogState();
}

class _DeliveryOptionDialogState extends State<DeliveryOptionDialog> {
  late List<DeliveryOption> deliveryOptions;
  int? selectedOptionID;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    deliveryOptions = Provider.of<DeliveryProvider>(context).allDeliveryOpt;
    final optionsSelected = Provider.of<DeliveryProvider>(context).optionsSelected;

    if (deliveryOptions.isNotEmpty) {
      selectedOptionID = optionsSelected == 0
          ? deliveryOptions.firstWhere(
            (option) => option.isDefault == 1,
        orElse: () => deliveryOptions.first,
      ).shippingOptionID
          : optionsSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deliveryUpdate = Provider.of<DeliveryProvider>(context, listen: true);

    if (deliveryOptions.isEmpty) {
      return AlertDialog(
        backgroundColor: tdWhite,
        surfaceTintColor: tdWhite,
        title: Text(
          'Delivery Information',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
            color: tdBlack,
          ),
        ),
        content: Text(
          'Delivery is free.',
          style: TextStyle(
            fontSize: 12.sp,
            color: tdBlack,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 100.w,
              height: 25.h,
              decoration: BoxDecoration(
                border: Border.all(color: tdBlack),
                borderRadius: BorderRadius.circular(200).w,
                color: tdBlack,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5).w,
                child: Center(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: tdWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return AlertDialog(
      backgroundColor: tdWhite,
      surfaceTintColor: tdWhite,
      title: Text(
        'Select Delivery Option',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.sp,
          color: tdBlack,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: deliveryOptions.map((option) {
            double price = 0.0;
            if (option.additionalCost.isNotEmpty &&
                double.tryParse(option.additionalCost) != null &&
                double.parse(option.additionalCost) > 0) {
              price = double.parse(option.additionalCost);
            } else {
              price = 0.0;
            }
            return CheckboxListTile(
              title: Text(
                option.optionName,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: tdBlack,
                ),
              ),
              subtitle: Text(
                '${option.description} ${price > 0 ? '${option.additionalCost}\$' : '(Free)'}',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: tdGrey,
                ),
              ),
              value: selectedOptionID == option.shippingOptionID,
              activeColor: Colors.black, // Checkbox color when checked
              checkColor: Colors.white, // Color of the checkmark
              onChanged: (bool? value) {
                if (value == true) {
                  setState(() {
                    selectedOptionID = option.shippingOptionID; // Update the selected option
                  });
                }
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 100.w,
                height: 25.h,
                decoration: BoxDecoration(
                  border: Border.all(color: tdBlack),
                  borderRadius: BorderRadius.circular(200).w,
                  color: tdWhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5).w,
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: tdBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                deliveryUpdate.updateSelectedOption(selectedOptionID!);
                deliveryUpdate.getOneDeliveryOptions(selectedOptionID!);
                Navigator.of(context).pop();
              },
              child: Container(
                width: 100.w,
                height: 25.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200).w,
                  color: tdBlack,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5).w,
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: tdWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
