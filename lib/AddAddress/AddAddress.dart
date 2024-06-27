import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';
import '../provider/GovArea_Provider.dart';
import '../provider/User_Provider.dart';
import 'AlertDialog/AlertAddressInsert.dart';
import 'Widget/AddAddressHead.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key, required this.isCheckOut});

  final int isCheckOut;

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  String? selectedGovernorate;
  String? selectedArea;

  final TextEditingController _contactNum = TextEditingController();
  final TextEditingController _block = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _building = TextEditingController();
  final TextEditingController _floor = TextEditingController();

  final AlertUserAddressAdded addingAddress = AlertUserAddressAdded();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GovAreaProvider>(context, listen: false).getAllGov();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userDetails = Provider.of<UserProvider>(context, listen: true);
    var userInfo = userDetails.userInfo;
    final provider = Provider.of<GovAreaProvider>(context);

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddAddressHead(
                isCheckOut: widget.isCheckOut,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Number',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: tdBlack),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: tdWhite,
                        borderRadius: BorderRadius.circular(5).w,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5).w,
                        child: TextFormField(
                          controller: _contactNum,
                          cursorColor: tdBlack, // Color of the cursor
                          style: TextStyle(fontSize: 12.sp),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Select Governorate',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: tdBlack,
                          fontSize: 12.sp),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5).w,
                        color: tdWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5).w,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(
                              'Governorate',
                              style: TextStyle(fontSize: 12.sp, color: tdBlack),
                            ),
                            value: selectedGovernorate,
                            items: provider.gov.map((gov) {
                              return DropdownMenuItem<String>(
                                value: gov.governerateId.toString(),
                                child: Text(
                                  gov.governerateName,
                                  style: TextStyle(
                                      fontSize: 12.sp, color: tdBlack),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGovernorate = newValue;
                                selectedArea = null;
                              });
                              provider.getAllArea();
                            },
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: tdBlack,
                              size: 40.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Select Area',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: tdBlack,
                          fontSize: 12.sp),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5).w,
                        color: tdWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5).w,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(
                              'Area',
                              style: TextStyle(fontSize: 12.sp, color: tdBlack),
                            ),
                            value: selectedArea,
                            items: provider.area
                                .where((area) =>
                                    area.governerateId ==
                                    int.parse(selectedGovernorate ?? '0'))
                                .map((area) {
                              return DropdownMenuItem<String>(
                                value: area.areaId.toString(),
                                child: Text(area.areaName,
                                    style: TextStyle(
                                        fontSize: 12.sp, color: tdBlack)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedArea = newValue;
                              });
                            },
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: tdBlack,
                              size: 40.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Block',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: tdBlack),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: tdWhite,
                        borderRadius: BorderRadius.circular(5).w,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5).w,
                        child: TextFormField(
                          controller: _block,
                          cursorColor: tdBlack, // Color of the cursor
                          style: TextStyle(fontSize: 12.sp),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Street',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: tdBlack),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: tdWhite,
                        borderRadius: BorderRadius.circular(5).w,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5).w,
                        child: TextFormField(
                          controller: _street,
                          style: TextStyle(fontSize: 12.sp),
                          cursorColor: tdBlack, // Color of the cursor
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Building',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(),
                        Text(
                          'Floor / Door',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: tdWhite,
                              borderRadius: BorderRadius.circular(5).w,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 5).w,
                              child: TextFormField(
                                controller: _building,
                                cursorColor: tdBlack, // Color of the cursor
                                style: TextStyle(fontSize: 12.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 50.w),
                        Expanded(
                          child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: tdWhite,
                              borderRadius: BorderRadius.circular(5).w,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 5).w,
                              child: TextFormField(
                                cursorColor: tdBlack, // Color of the cursor
                                controller: _floor,
                                style: TextStyle(fontSize: 12.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                    SizedBox(height: 35.h),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          addingAddress.userAddress(
                              context,
                              _contactNum.text,
                              selectedGovernorate,
                              selectedArea,
                              _block.text,
                              _street.text,
                              _building.text,
                              _floor.text,
                              userInfo[0].userNo,
                              widget.isCheckOut);
                        },
                        child: Container(
                          width: 180.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: tdBlack),
                              borderRadius: BorderRadius.circular(50).w,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              color: tdWhite),
                          child: Padding(
                            padding: const EdgeInsets.all(10).w,
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: tdBlack,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
