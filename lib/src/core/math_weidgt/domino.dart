import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DominoWidget extends StatelessWidget {
  final int count;
  final double? height;

  const DominoWidget({super.key, required this.count, this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height:
          height ?? (MediaQuery.of(context).size.height > 450 ? 180.h : 130.h),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFF004279)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: SizedBox(
        // widthh: 30.w,
        // height: height != null ? ((height ?? 0) - 10) : 130.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (count % 2 == 0) ...{
              Transform.scale(
                  scale: (MediaQuery.of(context).size.height > 450 ? 1 : 1),
                  child: _listOfCreateBots())
            } else ...{
              Transform.scale(
                  scale: (MediaQuery.of(context).size.height > 450 ? 1 : 1),
                  child: _listOfCreateBots()),
              Transform.scale(
                  scale: (MediaQuery.of(context).size.height > 450 ? 1 : 1),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.5.w),
                    child: _redBot(),
                  ))
            }
          ],
        ),
      ),
    );
  }

  _listOfCreateBots() {
    return Column(
        children: List.generate(
            ((count ~/ 2)),
            (index) => Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _redBot(),
                        _redBot(),
                      ],
                    ),
                    index == (count ~/ 2) ? 0.ph : 10.ph
                  ],
                ))
        // SizedBox(
        //   // height: ((count ~/ 2) * 25),
        //   child: ListView.separated(
        //       shrinkWrap: true,
        //       physics: NeverScrollableScrollPhysics(),
        //       itemBuilder: (context, index) {
        //         return Row(
        //           mainAxisSize: MainAxisSize.max,
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             _redBot(),
        //             _redBot(),
        //           ],
        //         );
        //       },
        //       separatorBuilder: (context, index) {
        //         return index == (count ~/ 2) ? 0.ph : 10.ph;
        //       },
        //       itemCount: count ~/ 2),
        // ),
        // ],
        );
  }

  _redBot() {
    return Container(
      width: 13.h,
      height: 13.h,
      decoration: const ShapeDecoration(
        color: Color(0xFFAA2020),
        shape: OvalBorder(),
      ),
    );
  }
}
