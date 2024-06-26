import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/provider/GovArea_Provider.dart';
import 'package:zawiid/provider/User_Provider.dart';

import 'Widget/UpdateProfileHead.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool _isChecked = false;
  String? selectedGovernorate;
  String? selectedArea;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GovAreaProvider>(context, listen: false).getAllGov();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.userInfo.isNotEmpty) {
      var user = userProvider.userInfo.first;
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      if (user.birthDate?.date != null) {
        birthDateController.text =
            "${user.birthDate?.date?.year}-${user.birthDate?.date?.month.toString().padLeft(2, '0')}-${user.birthDate?.date?.day.toString().padLeft(2, '0')}";
      }
      if (user.govNo != 0) {
        selectedGovernorate = user.govNo.toString();
      }

      if (user.gender == 'male') {
        _isChecked = true;
      } else {
        _isChecked = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GovAreaProvider>(context);
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const UpdateProfileHead(),
              Padding(
                padding: const EdgeInsets.all(8.0).w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'First Name',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: tdBlack,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Last Name',
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
                                controller: firstNameController,
                                style: TextStyle(fontSize: 12.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
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
                                controller: lastNameController,
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
                    SizedBox(height: 10.h),
                    Text(
                      'Birthdate',
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
                            readOnly: true,
                            controller: birthDateController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2035),
                              );
                              if (picked != null) {
                                setState(() {
                                  birthDateController.text =
                                      "${picked.year}-${picked.month}-${picked.day}";
                                });
                              }
                            },
                          )),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Gender',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: tdBlack),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 1.3,
                                    child: Checkbox(
                                      value: _isChecked,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          _isChecked = newValue!;
                                        });
                                      },
                                      shape: const CircleBorder(),
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    'Male',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: tdBlack,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 1.3,
                                    child: Checkbox(
                                      value: !_isChecked,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          _isChecked = !newValue!;
                                        });
                                      },
                                      shape: const CircleBorder(),
                                      checkColor: Colors.white,
                                      activeColor: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    'Female',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: tdBlack,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ),
                    SizedBox(height: 10.h),
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
                              'Select Governorate',
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
                              'Select Area',
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
                    SizedBox(height: 30.h),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).go('/Profile');
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
                            color: tdWhite,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10).w,
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: tdBlack,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
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
    );
  }
}
