import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../ApiService/AddressService/DeleteAddress.dart';
import '../../Color&Icons/color.dart';
import '../../provider/Address_Provider.dart';
import '../../provider/GovArea_Provider.dart';

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

    print(addressProvider.defaultAddressNo);
    var governorateMap = {
      for (var gov in governorates) gov.governerateId: gov.governerateName
    };
    var areaMap = {for (var area in areas) area.areaId: area.areaName};

    return Padding(
      padding: const EdgeInsets.all(8).w,
      child: addressUser.isEmpty
          ? Center(
              child: Text(
                'No addresses available',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: tdBlack,
                ),
              ),
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
                                  'Building ${address.building}',
                                  style: TextStyle(
                                    color: tdBlack,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  '+961 ${address.contactPhoneNumber}',
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
                                        ? 'default'
                                        : 'Use as default',
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
                                    deleteAddress(context, address.addressNo);
                                    addressProvider
                                        .deleteAddress(address.addressNo);
                                  },
                                  child: Text(
                                    'Delete',
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
