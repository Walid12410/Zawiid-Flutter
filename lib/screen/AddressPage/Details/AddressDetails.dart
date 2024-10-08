import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Api/addressService.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/localization/generated/l10n.dart';
import 'package:zawiid/provider/Address_Provider.dart';
import 'package:zawiid/provider/GovArea_Provider.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    AddressProvider addressProvider =
        Provider.of<AddressProvider>(context, listen: true);
    GovAreaProvider govAreaProvider =
        Provider.of<GovAreaProvider>(context, listen: true);

    var addressUser = addressProvider.addressView;
    var governorates = govAreaProvider.gov;
    var areas = govAreaProvider.area;

    var governorateMap = {
      for (var gov in governorates) gov.governerateId: gov.governerateName
    };
    var areaMap = {for (var area in areas) area.areaId: area.areaName};

    return Padding(
      padding: const EdgeInsets.all(8).w,
      child: addressUser.isEmpty
          ? Column(
            children: [
              SizedBox(height: 100.h),
              Padding(
                padding: const EdgeInsets.all(20).w,
                child: Center(
                    child: Text(
                     S.of(context).noAddressAvailable,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: tdGrey,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ),
            ],
          )
          : Column(
              children: [
                for (var address in addressUser)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0).w,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: tdWhite,
                        borderRadius: BorderRadius.circular(10).w,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(0, 0),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12).w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Home',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: tdBlack,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  '${governorateMap[address.governorate] ?? 'Unknown'} ${areaMap[address.area] ?? 'Unknown'}, ${address.street} Block ${address.block}',
                                  style: TextStyle(
                                    color: tdBlack,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  '${S.of(context).building} ${address.building}',
                                  style: TextStyle(
                                    color: tdBlack,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  address.contactPhoneNumber,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: tdBlack,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                              ],
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(5).w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    addressProvider
                                        .setDefaultAddress(address.addressNo);
                                  },
                                  child: Text(
                                    addressProvider.defaultAddressNo ==
                                            address.addressNo
                                        ? S.of(context).defaults
                                        : S.of(context).useDefault,
                                    style: TextStyle(
                                      fontSize: 12.h,
                                      color: addressProvider.defaultAddressNo ==
                                              address.addressNo
                                          ? tdBlack
                                          : tdGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    AddressService service = AddressService();
                                    service.deleteAddress(context, address.addressNo);
                                    addressProvider
                                        .deleteAddress(address.addressNo);
                                  },
                                  child: Text(
                                   S.of(context).delete,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: tdGrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
