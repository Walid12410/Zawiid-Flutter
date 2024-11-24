import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Api/AddressService.dart';
import 'package:zawiid/Widget/Toast/ToastError.dart';
import 'package:zawiid/core/Color&Icons/color.dart';
import 'package:zawiid/generated/l10n.dart';
import 'package:zawiid/provider/GovArea_Provider.dart';
import 'package:zawiid/provider/User_Provider.dart';
import 'Details/AddAddressHead.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key, required this.isCheckOut});

  final int isCheckOut;

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  String? selectedGovernorate;
  String? selectedArea;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode focusNode = FocusNode();
  String _countryCode = '';

  final TextEditingController _contactNum = TextEditingController();
  final TextEditingController _block = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _building = TextEditingController();
  final TextEditingController _floor = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GovAreaProvider>(context, listen: false).getAllGov();
    });
    super.initState();
  }

  void createAddress(String number, String block, String gov, String area,
      String street, String building, String floor) async {
    UserProvider userDetails =
        Provider.of<UserProvider>(context, listen: false);
    var userInfo = userDetails.userInfo.first;
    AddressService service = AddressService();
    setState(() {
      isLoading = true;
    });
    try {
      bool isCreated = await service.insertAddress(
          number, gov, area, block, street, building, floor, userInfo.userNo);
      if (isCreated) {
        if (widget.isCheckOut == 1) {
          setState(() {
            context.push(context.namedLocation('shippingAddress'));
          });
        } else {
          setState(() {
            context.goNamed("AddressView");
          });
        }
      }
    } catch (e) {
      showToast('Something went wrong $e');
    } finally {
      setState(() {
        isLoading = false;
      });
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
              AddAddressHead(
                isCheckOut: widget.isCheckOut,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0).w,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).contactNumber,
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 15)
                                  .w,
                          child: IntlPhoneField(
                            focusNode: focusNode,
                            languageCode: "en",
                            controller: _contactNum,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                            showDropdownIcon: false, // Hide the dropdown icon
                            style: TextStyle(color: tdBlack, fontSize: 12.sp),
                            dropdownTextStyle: TextStyle(
                              fontSize: 18.sp,
                              color: tdBlack,
                            ),
                            dropdownDecoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Colors.transparent), // Removes the border
                              borderRadius: BorderRadius.circular(0),
                            ),
                            cursorColor: tdBlack, // Color of the cursor
                            disableAutoFillHints: true,
                            onChanged: (phone) {
                              setState(() {
                                _countryCode = phone.countryCode;
                                _contactNum.text = phone.number;
                                _contactNum.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: _contactNum.text
                                            .length)); // Move cursor to end
                              });
                            },
                            onCountryChanged: (country) {
                              setState(() {
                                _countryCode = country.dialCode;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        S.of(context).gov,
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
                                S.of(context).governorate,
                                style:
                                    TextStyle(fontSize: 12.sp, color: tdBlack),
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
                        S.of(context).selectArea,
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
                                S.of(context).area,
                                style:
                                    TextStyle(fontSize: 12.sp, color: tdBlack),
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
                        S.of(context).block,
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
                        S.of(context).street,
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
                            S.of(context).building,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: tdBlack,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(),
                          Text(
                            S.of(context).floorDoor,
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
                          onTap: isLoading
                              ? null
                              : () {
                                  if (_contactNum.text.isEmpty ||
                                      _block.text.isEmpty ||
                                      _building.text.isEmpty ||
                                      _street.text.isEmpty ||
                                      selectedArea == null ||
                                      selectedGovernorate == null) {
                                    return showToast('SomeField is empty');
                                  }
                                  createAddress(
                                      '$_countryCode ${_contactNum.text}',
                                      _block.text,
                                      selectedGovernorate!,
                                      selectedArea!,
                                      _street.text,
                                      _building.text,
                                      _floor.text);
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
                                isLoading
                                    ? S.of(context).saving
                                    : S.of(context).save,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
