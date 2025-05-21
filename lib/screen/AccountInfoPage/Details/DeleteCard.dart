import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zawiid/Api/UserService.dart';
import 'package:zawiid/Widget/Toast/ToastError.dart';
import '../../../core/Color&Icons/color.dart';
import '../../../generated/l10n.dart';
import '../../../provider/Address_Provider.dart';
import '../../../provider/Auth_Provider.dart';

class DeleteCard extends StatelessWidget {
  const DeleteCard({super.key});

  void _showDeleteDialog(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final address = Provider.of<AddressProvider>(context, listen: false);

    if (authProvider.userId == 0) {
      showToast(S.of(context).errorConnection);
      return;
    }

    final UserService service = UserService();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(
              S.of(context).deleteAccount,
              style: TextStyle(
                  fontSize: 15.sp, color: tdBlack, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: Text(
              S.of(context).sureDelete,
              style: TextStyle(
                  fontSize: 12.sp, color: tdBlack, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: isLoading
                    ? null
                    : () {
                        Navigator.of(ctx).pop(); // Close dialog
                      },
                child: Text(
                  S.of(context).cancel,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlack,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: tdBlack,
                ),
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          bool success = await service
                              .deActiveAccount(authProvider.userId);
                          if (success) {
                            authProvider.logout();
                            address.removeDefaultAddress();
                            if (ctx.mounted) {
                              Navigator.of(ctx).pop(); // Close dialog
                            }
                            if (context.mounted) {
                              GoRouter.of(context).goNamed('SignIn');
                            }
                          } else {
                            showToast(S.of(context).errorConnection);
                          }
                        } catch (e) {
                          showToast(S.of(context).errorConnection);
                        } finally {
                          if (ctx.mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                child: isLoading
                    ? SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: const CircularProgressIndicator(
                          color: tdWhite,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        S.of(context).delete,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: tdWhite,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDeleteDialog(context),
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).w,
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
            padding: const EdgeInsets.only(
              top: 8,
              right: 12,
              left: 12,
              bottom: 4,
            ).w,
            child: Row(
              children: [
                Icon(Icons.delete, color: tdGrey, size: 20.w),
                SizedBox(width: 15.w),
                Expanded(
                  child: Text(
                    S.of(context).deleteAccount,
                    style: TextStyle(color: tdGrey, fontSize: 14.sp),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 5.h),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50).w,
                      ),
                      width: 23.w,
                      height: 22.h,
                      child: SvgPicture.asset(
                        'assets/svg/arrow.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
