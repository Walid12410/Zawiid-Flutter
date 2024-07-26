import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/ApiService/UserInformationService/UpdateProfileApi.dart';
import 'package:zawiid/Color&Icons/color.dart';
import 'package:zawiid/PageHeadWidget.dart';
import 'package:zawiid/provider/Auth_Provider.dart';
import 'package:zawiid/provider/GovArea_Provider.dart';
import 'package:zawiid/provider/User_Provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool _isChecked = false;
  String? selectedGovernorate;
  String? selectedArea;
  bool _isUpdating = false;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  TextEditingController birthDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GovAreaProvider>(context, listen: false).getAllGov();
    });
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final govArea = Provider.of<GovAreaProvider>(context, listen: false);

    if (userProvider.userInfo.isNotEmpty) {
      var user = userProvider.userInfo.first;
      setState(() {
        firstNameController = TextEditingController(text: user.firstName);
        lastNameController = TextEditingController(text: user.lastName);
        if (user.birthDate?.date != null) {
          birthDateController.text = user.birthDate != null
              ? "${user.birthDate!.date!.year}-${user.birthDate!.date!.month.toString().padLeft(2, '0')}-${user.birthDate!.date!.day.toString().padLeft(2, '0')}"
              : '';
        }
        if (user.gender == 'male') {
          _isChecked = true;
        } else {
          _isChecked = false;
        }
      });
      if (user.govNo != 0) {
        selectedGovernorate = user.govNo.toString();
        selectedArea = null;
        govArea.getAllArea();
      }
      if (user.areaNo != 0) {
        selectedArea = user.areaNo.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GovAreaProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PageHeadView(
                  title: 'My Profile',
                  onPressed: () {
                    GoRouter.of(context).go("/Profile");
                  }),
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
                                cursorColor: tdBlack, // Color of the cursor
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
                                cursorColor: tdBlack,
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
                        child: TextFormField(
                          readOnly: true,
                          controller: birthDateController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Select Birth Date',
                            hintStyle: TextStyle(color: tdBlack),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2035),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: tdBlack,
                                      onPrimary: tdWhite,
                                    ),
                                    textTheme: const TextTheme(
                                      bodyText1: TextStyle(color: tdBlack),
                                      subtitle1: TextStyle(color: tdBlack),
                                      button: TextStyle(color: tdBlack),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              setState(() {
                                birthDateController.text =
                                    "${picked.year}-${picked.month}-${picked.day}";
                              });
                            }
                          },
                        )),
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
                                        fontSize: 12.sp, color: tdBlack),
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
                                        fontSize: 12.sp, color: tdBlack),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Select Governorate',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: tdBlack),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 40.h,
                      width: double.infinity,
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
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedGovernorate,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: tdBlack,
                          size: 40.w,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: tdBlack, fontSize: 12.sp),
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGovernorate = newValue;
                            selectedArea = null;
                            provider.getAllArea(); // Update area list
                          });
                        },
                        items: provider.gov.map((governorate) {
                          return DropdownMenuItem<String>(
                            value: governorate.governerateId.toString(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, top: 5).w,
                              child: Text(
                                governorate.governerateName,
                                style:
                                    TextStyle(fontSize: 12.sp, color: tdBlack),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Area',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: tdBlack),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 40.h,
                      width: double.infinity,
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
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedArea,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: tdBlack,
                          size: 40.w,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: tdBlack, fontSize: 12.sp),
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedArea = newValue;
                          });
                        },
                        items: provider.area
                            .where((area) =>
                                area.governerateId ==
                                int.parse(selectedGovernorate ?? '0'))
                            .map((area) {
                          return DropdownMenuItem<String>(
                            value: area.areaId.toString(),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, top: 5).w,
                              child: Text(
                                area.areaName,
                                style:
                                    TextStyle(fontSize: 12.sp, color: tdBlack),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          if (_isUpdating) return;
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: tdBlack,
                                ),
                              );
                            },
                          );
                          if (selectedGovernorate == null || selectedArea == null) {
                            Navigator.pop(context); // Close the progress dialog if selections are missing
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please select Governorate and Area',
                                  style: TextStyle(fontSize: 10.sp, color: tdWhite),
                                ),
                                backgroundColor: tdBlack,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            return;
                          }
                          setState(() {
                            _isUpdating = true;
                          });
                          bool isUpdated = await updateUserProfile(
                            context,
                            authProvider.userId,
                            firstNameController.text,
                            lastNameController.text,
                            birthDateController.text,
                            _isChecked ? 'male' : 'female',
                            selectedGovernorate.toString(),
                            selectedArea.toString(),
                          );
                          Navigator.of(context, rootNavigator: true).pop();
                          if (isUpdated) {
                            await userProvider.getUserInfo(authProvider.userId);
                            GoRouter.of(context).go('/Profile');
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Profile updated successfully',
                                    style: TextStyle(fontSize: 10.sp, color: tdWhite),
                                  ),
                                  backgroundColor: tdBlack,
                                ),
                              );
                            });
                          } else {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Failed to update profile',
                                    style: TextStyle(fontSize: 10.sp, color: tdWhite),
                                  ),
                                  backgroundColor: tdBlack,
                                ),
                              );
                            });
                          }
                          setState(() {
                            _isUpdating = false;
                          });
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
