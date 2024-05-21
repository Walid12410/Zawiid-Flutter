import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zawiid/Color&Icons/color.dart';

class CouponsTable extends StatelessWidget {
  const CouponsTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Table(
      border: TableBorder.all(color: tdGrey),
      columnWidths:  <int, TableColumnWidth>{
        0: FixedColumnWidth(200.0.w),
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 6.0).w,
                  child: Text('Code',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp),textAlign: TextAlign.center,)
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 6.0).w,
                child: Text('ADI12',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),textAlign: TextAlign.center,),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 6.0).w,
                child: Text('Saving',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),textAlign: TextAlign.center,),
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 6.0).w,
                child: Text('20% Flat',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),textAlign: TextAlign.center,),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 6.0).w,
                child: Text('Available for',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),textAlign: TextAlign.center,),
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 6.0).w,
                child: Text('All Customers',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),textAlign: TextAlign.center,),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 6.0).w,
                child: Text('Min. Order Value',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),textAlign: TextAlign.center,),
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 6.0).w,
                child: Text('- -',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),textAlign: TextAlign.center,),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 6.0).w,
                child: Text('Valid for',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),textAlign: TextAlign.center,),
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 6.0).w,
                child: Text('EveryThing',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: tdBlack),textAlign: TextAlign.center,),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
