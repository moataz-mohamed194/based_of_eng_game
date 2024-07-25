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
      height: height ?? 140.h,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFF004279)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 30.w,
            height: height != null ? ((height ?? 0) - 10) : 130.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (count % 2 == 0) ...{
                  _listOfCreateBots()
                } else ...{
                  _listOfCreateBots(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.5.w),
                    child: _redBot(),
                  )
                }
              ],
            ),
          ),
        ],
      ),
    );
  }

  _listOfCreateBots() {
    return SizedBox(
      height: ((count ~/ 2) * 25),
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _redBot(),
                _redBot(),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return index == (count ~/ 2) ? 0.ph : 10.ph;
          },
          itemCount: count ~/ 2),
    );
  }

  _redBot() {
    return Container(
      width: 6.w,
      height: 6.w,
      decoration: const ShapeDecoration(
        color: Color(0xFFAA2020),
        shape: OvalBorder(),
      ),
    );
  }
}
