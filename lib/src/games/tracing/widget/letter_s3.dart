import 'package:based_of_eng_game/src/games/tracing/path_helper/path_helper.dart';
import 'package:flutter/material.dart';
import '../../../core/phonetics_color.dart';

class FlipBookPainterLetterS extends CustomPainter {
  FlipBookPainterLetterS({required this.points, required this.colorsOfPaths});
  static (Path, int) path0(Size size) {
    int keyPosition = 1;

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.7943775, size.height * 0.3075161);
    path_2.cubicTo(
        size.width * 0.8295582,
        size.height * 0.3075161,
        size.width * 0.8640562,
        size.height * 0.2855484,
        size.width * 0.8991968,
        size.height * 0.2416129);
    path_2.cubicTo(
        size.width * 0.9304418,
        size.height * 0.2002903,
        size.width * 0.9467470,
        size.height * 0.1673548,
        size.width * 0.9467470,
        size.height * 0.1427742);
    path_2.cubicTo(
        size.width * 0.9467470,
        size.height * 0.1087742,
        size.width * 0.9206827,
        size.height * 0.08158065,
        size.width * 0.8673092,
        size.height * 0.06222581);
    path_2.cubicTo(
        size.width * 0.8211245,
        size.height * 0.04548387,
        size.width * 0.7755020,
        size.height * 0.03216126,
        size.width * 0.7303213,
        size.height * 0.02212900);
    path_2.lineTo(size.width * 0.7303213, size.height * 0.2938710);
    path_2.cubicTo(
        size.width * 0.7571888,
        size.height * 0.3028387,
        size.width * 0.7786747,
        size.height * 0.3075161,
        size.width * 0.7943775,
        size.height * 0.3075161);
    path_2.close();
    return (path_2, keyPosition);
  }

  static Path mainPath(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4765892, size.height * 0.9998433);
    path_0.cubicTo(
        size.width * 0.3229786,
        size.height * 0.9998433,
        size.width * 0.1791310,
        size.height * 0.9658657,
        size.width * 0.04374489,
        size.height * 0.8974030);
    path_0.cubicTo(
        size.width * 0.01510548,
        size.height * 0.8827687,
        size.width * 0.0007859693,
        size.height * 0.8613358,
        size.width * 0.0007859693,
        size.height * 0.8336343);
    path_0.cubicTo(
        size.width * 0.0007859693,
        size.height * 0.7980970,
        size.width * 0.02942528,
        size.height * 0.7484403,
        size.width * 0.08735483,
        size.height * 0.6836336);
    path_0.cubicTo(
        size.width * 0.1042779,
        size.height * 0.6627276,
        size.width * 0.1296626,
        size.height * 0.6527970,
        size.width * 0.1648113,
        size.height * 0.6527970);
    path_0.cubicTo(
        size.width * 0.2045158,
        size.height * 0.6527970,
        size.width * 0.2507296,
        size.height * 0.6653410,
        size.width * 0.3034517,
        size.height * 0.6909507);
    path_0.cubicTo(
        size.width * 0.3776543,
        size.height * 0.7249239,
        size.width * 0.4407909,
        size.height * 0.7421716,
        size.width * 0.4928625,
        size.height * 0.7421716);
    path_0.cubicTo(
        size.width * 0.5852890,
        size.height * 0.7421716,
        size.width * 0.6315028,
        size.height * 0.7275373,
        size.width * 0.6315028,
        size.height * 0.6982679);
    path_0.cubicTo(
        size.width * 0.6315028,
        size.height * 0.6862470,
        size.width * 0.6171831,
        size.height * 0.6757940,
        size.width * 0.5878922,
        size.height * 0.6669090);
    path_0.cubicTo(
        size.width * 0.5592537,
        size.height * 0.6585463,
        size.width * 0.5228030,
        size.height * 0.6517515,
        size.width * 0.4785428,
        size.height * 0.6465254);
    path_0.cubicTo(
        size.width * 0.4342816,
        size.height * 0.6418209,
        size.width * 0.3867667,
        size.height * 0.6313679,
        size.width * 0.3359963,
        size.height * 0.6162104);
    path_0.cubicTo(
        size.width * 0.2852268,
        size.height * 0.6010537,
        size.width * 0.2377110,
        size.height * 0.5822381,
        size.width * 0.1934507,
        size.height * 0.5602866);
    path_0.cubicTo(
        size.width * 0.1491896,
        size.height * 0.5383351,
        size.width * 0.1127398,
        size.height * 0.5038388,
        size.width * 0.08410037,
        size.height * 0.4568000);
    path_0.cubicTo(
        size.width * 0.05546106,
        size.height * 0.4097604,
        size.width * 0.04049033,
        size.height * 0.3538358,
        size.width * 0.04049033,
        size.height * 0.2895493);
    path_0.cubicTo(
        size.width * 0.04049033,
        size.height * 0.09668806,
        size.width * 0.2051664,
        size.height * 0.0005190724,
        size.width * 0.5351701,
        size.height * 0.0005190724);
    path_0.cubicTo(
        size.width * 0.6432184,
        size.height * 0.0005190724,
        size.width * 0.7538708,
        size.height * 0.02142537,
        size.width * 0.8677770,
        size.height * 0.06271537);
    path_0.cubicTo(
        size.width * 0.9211506,
        size.height * 0.08205373,
        size.width * 0.9471840,
        size.height * 0.1092321,
        size.width * 0.9471840,
        size.height * 0.1432045);
    path_0.cubicTo(
        size.width * 0.9471840,
        size.height * 0.1677694,
        size.width * 0.9309108,
        size.height * 0.2006970,
        size.width * 0.8996710,
        size.height * 0.2419873);
    path_0.cubicTo(
        size.width * 0.8645223,
        size.height * 0.2858903,
        size.width * 0.8300251,
        size.height * 0.3078425,
        size.width * 0.7948773,
        size.height * 0.3078425);
    path_0.cubicTo(
        size.width * 0.7766524,
        size.height * 0.3078425,
        size.width * 0.7506162,
        size.height * 0.3015701,
        size.width * 0.7174210,
        size.height * 0.2895493);
    path_0.cubicTo(
        size.width * 0.6523309,
        size.height * 0.2649843,
        size.width * 0.5904963,
        size.height * 0.2529634,
        size.width * 0.5325669,
        size.height * 0.2529634);
    path_0.cubicTo(
        size.width * 0.4427435,
        size.height * 0.2529634,
        size.width * 0.3984823,
        size.height * 0.2665522,
        size.width * 0.3984823,
        size.height * 0.2932075);
    path_0.cubicTo(
        size.width * 0.3984823,
        size.height * 0.3125463,
        size.width * 0.4134526,
        size.height * 0.3282261,
        size.width * 0.4427435,
        size.height * 0.3397246);
    path_0.cubicTo(
        size.width * 0.4726840,
        size.height * 0.3512231,
        size.width * 0.5097853,
        size.height * 0.3590627,
        size.width * 0.5546970,
        size.height * 0.3637664);
    path_0.cubicTo(
        size.width * 0.5996087,
        size.height * 0.3679478,
        size.width * 0.6477751,
        size.height * 0.3763104,
        size.width * 0.6991952,
        size.height * 0.3883313);
    path_0.cubicTo(
        size.width * 0.7506162,
        size.height * 0.4003530,
        size.width * 0.7987825,
        size.height * 0.4155097,
        size.width * 0.8436942,
        size.height * 0.4332806);
    path_0.cubicTo(
        size.width * 0.8886059,
        size.height * 0.4510507,
        size.width * 0.9257072,
        size.height * 0.4808425,
        size.width * 0.9556506,
        size.height * 0.5226552);
    path_0.cubicTo(
        size.width * 0.9855855,
        size.height * 0.5649903,
        size.width * 0.9999071,
        size.height * 0.6162104,
        size.width * 0.9999071,
        size.height * 0.6773619);
    path_0.cubicTo(
        size.width * 0.9999071,
        size.height * 0.7432172,
        size.width * 0.9849349,
        size.height * 0.7986194,
        size.width * 0.9556506,
        size.height * 0.8430448);
    path_0.cubicTo(
        size.width * 0.9263578,
        size.height * 0.8874701,
        size.width * 0.8840493,
        size.height * 0.9203955,
        size.width * 0.8306766,
        size.height * 0.9418284);
    path_0.cubicTo(
        size.width * 0.7766524,
        size.height * 0.9632537,
        size.width * 0.7219768,
        size.height * 0.9778881,
        size.width * 0.6666506,
        size.height * 0.9867761);
    path_0.cubicTo(
        size.width * 0.6119758,
        size.height * 0.9956642,
        size.width * 0.5481877,
        size.height * 0.9998433,
        size.width * 0.4765892,
        size.height * 0.9998433);
    path_0.close();
    return path_0;
  }

  static (Path, int) path2(Size size) {
    int keyPosition = 6;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8432129, size.height * 0.4330645);
    path_0.cubicTo(
        size.width * 0.7989558,
        size.height * 0.4155484,
        size.width * 0.7514859,
        size.height * 0.4005806,
        size.width * 0.7008835,
        size.height * 0.3886129);
    path_0.lineTo(size.width * 0.05337349, size.height * 0.3886129);
    path_0.cubicTo(
        size.width * 0.06060241,
        size.height * 0.4130000,
        size.width * 0.07060241,
        size.height * 0.4356774,
        size.width * 0.08333333,
        size.height * 0.4565806);
    path_0.cubicTo(
        size.width * 0.09028112,
        size.height * 0.4680000,
        size.width * 0.09771084,
        size.height * 0.4786774,
        size.width * 0.1055823,
        size.height * 0.4886129);
    path_0.lineTo(size.width * 0.9267871, size.height * 0.4886129);
    path_0.cubicTo(
        size.width * 0.9026506,
        size.height * 0.4641290,
        size.width * 0.8748996,
        size.height * 0.4455806,
        size.width * 0.8432129,
        size.height * 0.4330645);
    path_0.close();
    return (path_0, keyPosition);
  }

  static (Path, int) path1(Size size) {
    int keyPosition = 14;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.08658635, size.height * 0.6835806);
    path_1.cubicTo(size.width * 0.02863454, size.height * 0.7484194, 0,
        size.height * 0.7981290, 0, size.height * 0.8336774);
    path_1.cubicTo(
        0,
        size.height * 0.8613871,
        size.width * 0.01433735,
        size.height * 0.8828387,
        size.width * 0.04297189,
        size.height * 0.8974839);
    path_1.cubicTo(
        size.width * 0.07871486,
        size.height * 0.9155806,
        size.width * 0.1150602,
        size.height * 0.9312258,
        size.width * 0.1520080,
        size.height * 0.9445161);
    path_1.lineTo(size.width * 0.1520080, size.height * 0.6531613);
    path_1.cubicTo(
        size.width * 0.1230120,
        size.height * 0.6552581,
        size.width * 0.1015261,
        size.height * 0.6651290,
        size.width * 0.08658635,
        size.height * 0.6835806);
    path_1.close();
    return (path_1, keyPosition);
  }

  static (Path, int) path3(Size size) {
    int keyPosition = 2;

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.5319679, size.height * 0.2526129);
    path_3.cubicTo(
        size.width * 0.5899197,
        size.height * 0.2526129,
        size.width * 0.6517671,
        size.height * 0.2646452,
        size.width * 0.7169076,
        size.height * 0.2892258);
    path_3.cubicTo(
        size.width * 0.7215261,
        size.height * 0.2909032,
        size.width * 0.7259839,
        size.height * 0.2924516,
        size.width * 0.7303614,
        size.height * 0.2939032);
    path_3.lineTo(size.width * 0.7303614, size.height * 0.02216129);
    path_3.cubicTo(size.width * 0.6640964, size.height * 0.007483871,
        size.width * 0.5988755, 0, size.width * 0.5346185, 0);
    path_3.cubicTo(
        size.width * 0.5233735,
        0,
        size.width * 0.5123293,
        size.height * 0.0001290323,
        size.width * 0.5014458,
        size.height * 0.0003548387);
    path_3.lineTo(size.width * 0.5014458, size.height * 0.2532258);
    path_3.cubicTo(
        size.width * 0.5109639,
        size.height * 0.2528387,
        size.width * 0.5211647,
        size.height * 0.2526129,
        size.width * 0.5320080,
        size.height * 0.2526129);
    path_3.lineTo(size.width * 0.5319679, size.height * 0.2526129);
    path_3.close();
    return (path_3, keyPosition);
  }

  static (Path, int) path4(Size size) {
    int keyPosition = 5;

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.6986747, size.height * 0.3880645);
    path_4.cubicTo(
        size.width * 0.6472289,
        size.height * 0.3760323,
        size.width * 0.5990361,
        size.height * 0.3676774,
        size.width * 0.5541365,
        size.height * 0.3634839);
    path_4.cubicTo(
        size.width * 0.5091968,
        size.height * 0.3587742,
        size.width * 0.4720884,
        size.height * 0.3509355,
        size.width * 0.4421285,
        size.height * 0.3394194);
    path_4.cubicTo(
        size.width * 0.4128112,
        size.height * 0.3279032,
        size.width * 0.3978317,
        size.height * 0.3122258,
        size.width * 0.3978317,
        size.height * 0.2928710);
    path_4.cubicTo(
        size.width * 0.3978317,
        size.height * 0.2914194,
        size.width * 0.3979924,
        size.height * 0.2900000,
        size.width * 0.3982735,
        size.height * 0.2886129);
    path_4.lineTo(size.width * 0.03971944, size.height * 0.2886129);
    path_4.cubicTo(
        size.width * 0.03971944,
        size.height * 0.2888065,
        size.width * 0.03971944,
        size.height * 0.2890323,
        size.width * 0.03971944,
        size.height * 0.2892258);
    path_4.cubicTo(
        size.width * 0.03971944,
        size.height * 0.3249677,
        size.width * 0.04437791,
        size.height * 0.3581290,
        size.width * 0.05337390,
        size.height * 0.3886129);
    path_4.lineTo(size.width * 0.7008835, size.height * 0.3886129);
    path_4.cubicTo(
        size.width * 0.7001205,
        size.height * 0.3884516,
        size.width * 0.6993976,
        size.height * 0.3882581,
        size.width * 0.6986747,
        size.height * 0.3880645);
    path_4.close();
    return (path_4, keyPosition);
  }

  static (Path, int) path5(Size size) {
    int keyPosition = 7;

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.9267871, size.height * 0.4886129);
    path_5.lineTo(size.width * 0.1078317, size.height * 0.4886129);
    path_5.lineTo(size.width * 0.1078317, size.height * 0.4914194);
    path_5.cubicTo(
        size.width * 0.1319281,
        size.height * 0.5210968,
        size.width * 0.1602012,
        size.height * 0.5440000,
        size.width * 0.1927313,
        size.height * 0.5601290);
    path_5.cubicTo(
        size.width * 0.2132936,
        size.height * 0.5703226,
        size.width * 0.2345386,
        size.height * 0.5798065,
        size.width * 0.2565064,
        size.height * 0.5886129);
    path_5.lineTo(size.width * 0.9873092, size.height * 0.5886129);
    path_5.cubicTo(
        size.width * 0.9800000,
        size.height * 0.5645161,
        size.width * 0.9693976,
        size.height * 0.5425161,
        size.width * 0.9552209,
        size.height * 0.5224839);
    path_5.cubicTo(
        size.width * 0.9463855,
        size.height * 0.5101290,
        size.width * 0.9369076,
        size.height * 0.4988710,
        size.width * 0.9267871,
        size.height * 0.4886129);
    path_5.close();
    return (path_5, keyPosition);
  }

  static (Path, int) path6(Size size) {
    int keyPosition = 8;

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.2567867, size.height * 0.5886129);
    path_6.lineTo(size.width * 0.2567867, size.height * 0.5887097);
    path_6.cubicTo(
        size.width * 0.2820478,
        size.height * 0.5988065,
        size.width * 0.3082325,
        size.height * 0.6080000,
        size.width * 0.3353410,
        size.height * 0.6160968);
    path_6.cubicTo(
        size.width * 0.3861442,
        size.height * 0.6312581,
        size.width * 0.4336546,
        size.height * 0.6417097,
        size.width * 0.4779518,
        size.height * 0.6464194);
    path_6.cubicTo(
        size.width * 0.5085944,
        size.height * 0.6500323,
        size.width * 0.5354217,
        size.height * 0.6544194,
        size.width * 0.5585944,
        size.height * 0.6595484);
    path_6.lineTo(size.width * 0.9990763, size.height * 0.6595484);
    path_6.cubicTo(
        size.width * 0.9978715,
        size.height * 0.6340968,
        size.width * 0.9939759,
        size.height * 0.6104839,
        size.width * 0.9873494,
        size.height * 0.5885806);
    path_6.lineTo(size.width * 0.2567867, size.height * 0.5885806);
    path_6.lineTo(size.width * 0.2567867, size.height * 0.5886129);
    path_6.close();
    return (path_6, keyPosition);
  }

  static (Path, int) path7(Size size) {
    int keyPosition = 9;

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.9990361, size.height * 0.6595806);
    path_7.lineTo(size.width * 0.5585542, size.height * 0.6595806);
    path_7.cubicTo(
        size.width * 0.5688353,
        size.height * 0.6618710,
        size.width * 0.5784739,
        size.height * 0.6642581,
        size.width * 0.5873092,
        size.height * 0.6668387);
    path_7.cubicTo(
        size.width * 0.6166265,
        size.height * 0.6757419,
        size.width * 0.6309237,
        size.height * 0.6861935,
        size.width * 0.6309237,
        size.height * 0.6982258);
    path_7.cubicTo(
        size.width * 0.6309237,
        size.height * 0.7124516,
        size.width * 0.6199598,
        size.height * 0.7232258,
        size.width * 0.5981124,
        size.height * 0.7305484);
    path_7.lineTo(size.width * 0.9958635, size.height * 0.7305484);
    path_7.cubicTo(
        size.width * 0.9982329,
        size.height * 0.7136452,
        size.width * 0.9994779,
        size.height * 0.6959032,
        size.width * 0.9994779,
        size.height * 0.6772903);
    path_7.cubicTo(
        size.width * 0.9994779,
        size.height * 0.6712903,
        size.width * 0.9993173,
        size.height * 0.6653871,
        size.width * 0.9990361,
        size.height * 0.6595806);
    path_7.close();
    return (path_7, keyPosition);
  }

  static (Path, int) path8(Size size) {
    int keyPosition = 10;

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.5981124, size.height * 0.7305484);
    path_8.cubicTo(
        size.width * 0.5807631,
        size.height * 0.7363548,
        size.width * 0.5565863,
        size.height * 0.7399677,
        size.width * 0.5255020,
        size.height * 0.7414194);
    path_8.lineTo(size.width * 0.5255020, size.height * 0.8273226);
    path_8.lineTo(size.width * 0.9646988, size.height * 0.8273226);
    path_8.cubicTo(
        size.width * 0.9803614,
        size.height * 0.7990000,
        size.width * 0.9908032,
        size.height * 0.7667097,
        size.width * 0.9958635,
        size.height * 0.7305484);
    path_8.lineTo(size.width * 0.5981124, size.height * 0.7305484);
    path_8.close();
    return (path_8, keyPosition);
  }

  static (Path, int) path9(Size size) {
    int keyPosition = 11;

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.5255020, size.height * 0.8273226);
    path_9.lineTo(size.width * 0.5255020, size.height * 0.7414194);
    path_9.cubicTo(
        size.width * 0.5151807,
        size.height * 0.7419032,
        size.width * 0.5040964,
        size.height * 0.7421290,
        size.width * 0.4922490,
        size.height * 0.7421290);
    path_9.cubicTo(
        size.width * 0.4648996,
        size.height * 0.7421290,
        size.width * 0.4344578,
        size.height * 0.7373226,
        size.width * 0.4010044,
        size.height * 0.7278710);
    path_9.lineTo(size.width * 0.4010044, size.height * 0.9971935);
    path_9.cubicTo(
        size.width * 0.4257430,
        size.height * 0.9990323,
        size.width * 0.4507229,
        size.height * 0.9999677,
        size.width * 0.4759839,
        size.height * 0.9999677);
    path_9.cubicTo(
        size.width * 0.4929719,
        size.height * 0.9999677,
        size.width * 0.5094378,
        size.height * 0.9997097,
        size.width * 0.5255020,
        size.height * 0.9992258);
    path_9.cubicTo(
        size.width * 0.5772691,
        size.height * 0.9976774,
        size.width * 0.6243775,
        size.height * 0.9936774,
        size.width * 0.6661044,
        size.height * 0.9868710);
    path_9.cubicTo(
        size.width * 0.7214458,
        size.height * 0.9779677,
        size.width * 0.7761446,
        size.height * 0.9633226,
        size.width * 0.8302008,
        size.height * 0.9419032);
    path_9.cubicTo(
        size.width * 0.8432932,
        size.height * 0.9366452,
        size.width * 0.8557028,
        size.height * 0.9306774,
        size.width * 0.8674297,
        size.height * 0.9240645);
    path_9.cubicTo(
        size.width * 0.9035341,
        size.height * 0.9036129,
        size.width * 0.9330924,
        size.height * 0.8766129,
        size.width * 0.9552209,
        size.height * 0.8430645);
    path_9.cubicTo(
        size.width * 0.9585944,
        size.height * 0.8379677,
        size.width * 0.9617269,
        size.height * 0.8326774,
        size.width * 0.9647390,
        size.height * 0.8272903);
    path_9.lineTo(size.width * 0.5255422, size.height * 0.8272903);
    path_9.lineTo(size.width * 0.5255020, size.height * 0.8273226);
    path_9.close();
    return (path_9, keyPosition);
  }

  static (Path, int) path10(Size size) {
    int keyPosition = 12;

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.3027715, size.height * 0.6909032);
    path_10.cubicTo(
        size.width * 0.2938157,
        size.height * 0.6865484,
        size.width * 0.2851008,
        size.height * 0.6826129,
        size.width * 0.2765064,
        size.height * 0.6790323);
    path_10.lineTo(size.width * 0.2765064, size.height * 0.9797419);
    path_10.cubicTo(
        size.width * 0.3172695,
        size.height * 0.9882581,
        size.width * 0.3587554,
        size.height * 0.9940968,
        size.width * 0.4010044,
        size.height * 0.9972258);
    path_10.lineTo(size.width * 0.4010044, size.height * 0.7279032);
    path_10.cubicTo(
        size.width * 0.3707635,
        size.height * 0.7193548,
        size.width * 0.3380325,
        size.height * 0.7070323,
        size.width * 0.3027715,
        size.height * 0.6909032);
    path_10.close();
    return (path_10, keyPosition);
  }

  static (Path, int) path11(Size size) {
    int keyPosition = 13;

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.1640960, size.height * 0.6527097);
    path_11.cubicTo(
        size.width * 0.1599193,
        size.height * 0.6527097,
        size.width * 0.1559434,
        size.height * 0.6528710,
        size.width * 0.1520478,
        size.height * 0.6531290);
    path_11.lineTo(size.width * 0.1520478, size.height * 0.9444839);
    path_11.cubicTo(
        size.width * 0.1928108,
        size.height * 0.9591290,
        size.width * 0.2342968,
        size.height * 0.9708710,
        size.width * 0.2765458,
        size.height * 0.9797097);
    path_11.lineTo(size.width * 0.2765458, size.height * 0.6790000);
    path_11.cubicTo(
        size.width * 0.2345779,
        size.height * 0.6613871,
        size.width * 0.1971080,
        size.height * 0.6527097,
        size.width * 0.1640960,
        size.height * 0.6527097);
    path_11.close();
    return (path_11, keyPosition);
  }

  static (Path, int) path12(Size size) {
    int keyPosition = 3;

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.4010044, size.height * 0.006129000);
    path_12.lineTo(size.width * 0.4010044, size.height * 0.2815484);
    path_12.cubicTo(
        size.width * 0.4108835,
        size.height * 0.2650968,
        size.width * 0.4441365,
        size.height * 0.2555806,
        size.width * 0.5014056,
        size.height * 0.2531935);
    path_12.lineTo(size.width * 0.5014056, size.height * 0.0003547903);
    path_12.cubicTo(
        size.width * 0.4658635,
        size.height * 0.001096726,
        size.width * 0.4324096,
        size.height * 0.003032210,
        size.width * 0.4010044,
        size.height * 0.006161258);
    path_12.lineTo(size.width * 0.4010044, size.height * 0.006129000);
    path_12.close();
    return (path_12, keyPosition);
  }

  static (Path, int) path13(Size size) {
    int keyPosition = 4;

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.2684743, size.height * 0.02958052);
    path_13.cubicTo(
        size.width * 0.1161851,
        size.height * 0.07145161,
        size.width * 0.03996040,
        size.height * 0.1577097,
        size.width * 0.03971944,
        size.height * 0.2886129);
    path_13.lineTo(size.width * 0.3982735, size.height * 0.2886129);
    path_13.cubicTo(
        size.width * 0.3987554,
        size.height * 0.2861290,
        size.width * 0.3996791,
        size.height * 0.2837742,
        size.width * 0.4010446,
        size.height * 0.2815484);
    path_13.lineTo(size.width * 0.4010446, size.height * 0.006128903);
    path_13.cubicTo(
        size.width * 0.3518478,
        size.height * 0.01103213,
        size.width * 0.3076711,
        size.height * 0.01883858,
        size.width * 0.2685145,
        size.height * 0.02958052);
    path_13.lineTo(size.width * 0.2684743, size.height * 0.02958052);
    path_13.close();
    return (path_13, keyPosition);
  }

  static Path pathOfLetter(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5970046, size.height * 0.8953060);
    path_0.cubicTo(
        size.width * 0.5917974,
        size.height * 0.8953060,
        size.width * 0.5872407,
        size.height * 0.8921716,
        size.width * 0.5872407,
        size.height * 0.8879925);
    path_0.cubicTo(
        size.width * 0.5872407,
        size.height * 0.8838134,
        size.width * 0.5911468,
        size.height * 0.8801493,
        size.width * 0.5963541,
        size.height * 0.8796269);
    path_0.cubicTo(
        size.width * 0.6015604,
        size.height * 0.8796269,
        size.width * 0.6074191,
        size.height * 0.8791045,
        size.width * 0.6126264,
        size.height * 0.8791045);
    path_0.cubicTo(
        size.width * 0.6328039,
        size.height * 0.8780597,
        size.width * 0.6523309,
        size.height * 0.8754478,
        size.width * 0.6712063,
        size.height * 0.8707463);
    path_0.cubicTo(
        size.width * 0.6764136,
        size.height * 0.8697015,
        size.width * 0.6816208,
        size.height * 0.8717910,
        size.width * 0.6835734,
        size.height * 0.8759701);
    path_0.cubicTo(
        size.width * 0.6848755,
        size.height * 0.8801493,
        size.width * 0.6822714,
        size.height * 0.8843358,
        size.width * 0.6770641,
        size.height * 0.8859030);
    path_0.cubicTo(
        size.width * 0.6568866,
        size.height * 0.8911269,
        size.width * 0.6354071,
        size.height * 0.8937388,
        size.width * 0.6139275,
        size.height * 0.8947836);
    path_0.cubicTo(
        size.width * 0.6080697,
        size.height * 0.8953134,
        size.width * 0.6028625,
        size.height * 0.8953060,
        size.width * 0.5970046,
        size.height * 0.8953060);
    path_0.close();
    path_0.moveTo(size.width * 0.5188968, size.height * 0.8953060);
    path_0.cubicTo(
        size.width * 0.5182463,
        size.height * 0.8953060,
        size.width * 0.5182463,
        size.height * 0.8953060,
        size.width * 0.5188968,
        size.height * 0.8953060);
    path_0.cubicTo(
        size.width * 0.4922100,
        size.height * 0.8942612,
        size.width * 0.4655242,
        size.height * 0.8921716,
        size.width * 0.4394879,
        size.height * 0.8895597);
    path_0.cubicTo(
        size.width * 0.4342807,
        size.height * 0.8890373,
        size.width * 0.4303755,
        size.height * 0.8848582,
        size.width * 0.4310260,
        size.height * 0.8806716);
    path_0.cubicTo(
        size.width * 0.4316775,
        size.height * 0.8764925,
        size.width * 0.4368848,
        size.height * 0.8733582,
        size.width * 0.4420920,
        size.height * 0.8738806);
    path_0.cubicTo(
        size.width * 0.4674768,
        size.height * 0.8764925,
        size.width * 0.4928615,
        size.height * 0.8785821,
        size.width * 0.5188968,
        size.height * 0.8796269);
    path_0.cubicTo(
        size.width * 0.5241041,
        size.height * 0.8796269,
        size.width * 0.5286608,
        size.height * 0.8832910,
        size.width * 0.5280093,
        size.height * 0.8879925);
    path_0.cubicTo(
        size.width * 0.5280093,
        size.height * 0.8916493,
        size.width * 0.5241041,
        size.height * 0.8953060,
        size.width * 0.5188968,
        size.height * 0.8953060);
    path_0.close();
    path_0.moveTo(size.width * 0.3639842, size.height * 0.8775373);
    path_0.cubicTo(
        size.width * 0.3633336,
        size.height * 0.8775373,
        size.width * 0.3626822,
        size.height * 0.8775373,
        size.width * 0.3613810,
        size.height * 0.8775373);
    path_0.cubicTo(
        size.width * 0.3353448,
        size.height * 0.8723134,
        size.width * 0.3099600,
        size.height * 0.8665597,
        size.width * 0.2858773,
        size.height * 0.8592463);
    path_0.cubicTo(
        size.width * 0.2806701,
        size.height * 0.8576791,
        size.width * 0.2780660,
        size.height * 0.8535000,
        size.width * 0.2800186,
        size.height * 0.8493134);
    path_0.cubicTo(
        size.width * 0.2819712,
        size.height * 0.8451343,
        size.width * 0.2871784,
        size.height * 0.8430448,
        size.width * 0.2923857,
        size.height * 0.8446119);
    path_0.cubicTo(
        size.width * 0.3164693,
        size.height * 0.8514030,
        size.width * 0.3412026,
        size.height * 0.8571567,
        size.width * 0.3659368,
        size.height * 0.8623806);
    path_0.cubicTo(
        size.width * 0.3711441,
        size.height * 0.8634254,
        size.width * 0.3743987,
        size.height * 0.8676119,
        size.width * 0.3730967,
        size.height * 0.8717910);
    path_0.cubicTo(
        size.width * 0.3724461,
        size.height * 0.8749254,
        size.width * 0.3685409,
        size.height * 0.8775373,
        size.width * 0.3639842,
        size.height * 0.8775373);
    path_0.close();
    path_0.moveTo(size.width * 0.7441069, size.height * 0.8592463);
    path_0.cubicTo(
        size.width * 0.7408522,
        size.height * 0.8592463,
        size.width * 0.7382481,
        size.height * 0.8582015,
        size.width * 0.7362955,
        size.height * 0.8561119);
    path_0.cubicTo(
        size.width * 0.7330418,
        size.height * 0.8524552,
        size.width * 0.7343429,
        size.height * 0.8477463,
        size.width * 0.7388996,
        size.height * 0.8451343);
    path_0.cubicTo(
        size.width * 0.7597277,
        size.height * 0.8336343,
        size.width * 0.7779526,
        size.height * 0.8195224,
        size.width * 0.7922723,
        size.height * 0.8033209);
    path_0.cubicTo(
        size.width * 0.7955270,
        size.height * 0.7996642,
        size.width * 0.8013857,
        size.height * 0.7991418,
        size.width * 0.8059414,
        size.height * 0.8017537);
    path_0.cubicTo(
        size.width * 0.8104981,
        size.height * 0.8043657,
        size.width * 0.8111487,
        size.height * 0.8090746,
        size.width * 0.8078941,
        size.height * 0.8127313);
    path_0.cubicTo(
        size.width * 0.7916217,
        size.height * 0.8305000,
        size.width * 0.7720948,
        size.height * 0.8456567,
        size.width * 0.7499647,
        size.height * 0.8582015);
    path_0.cubicTo(
        size.width * 0.7473606,
        size.height * 0.8587239,
        size.width * 0.7460595,
        size.height * 0.8592463,
        size.width * 0.7441069,
        size.height * 0.8592463);
    path_0.close();
    path_0.moveTo(size.width * 0.2175335, size.height * 0.8352015);
    path_0.cubicTo(
        size.width * 0.2162314,
        size.height * 0.8352015,
        size.width * 0.2149294,
        size.height * 0.8352015,
        size.width * 0.2129768,
        size.height * 0.8341567);
    path_0.cubicTo(
        size.width * 0.1980065,
        size.height * 0.8284104,
        size.width * 0.1836868,
        size.height * 0.8221343,
        size.width * 0.1693671,
        size.height * 0.8153433);
    path_0.cubicTo(
        size.width * 0.1648104,
        size.height * 0.8132537,
        size.width * 0.1628578,
        size.height * 0.8085448,
        size.width * 0.1661125,
        size.height * 0.8043657);
    path_0.cubicTo(
        size.width * 0.1687156,
        size.height * 0.8007090,
        size.width * 0.1745743,
        size.height * 0.7991418,
        size.width * 0.1797816,
        size.height * 0.8017537);
    path_0.cubicTo(
        size.width * 0.1934498,
        size.height * 0.8080224,
        size.width * 0.2077695,
        size.height * 0.8142985,
        size.width * 0.2220892,
        size.height * 0.8200448);
    path_0.cubicTo(
        size.width * 0.2266459,
        size.height * 0.8221343,
        size.width * 0.2285985,
        size.height * 0.8268433,
        size.width * 0.2266459,
        size.height * 0.8305000);
    path_0.cubicTo(
        size.width * 0.2246924,
        size.height * 0.8336343,
        size.width * 0.2207872,
        size.height * 0.8352015,
        size.width * 0.2175335,
        size.height * 0.8352015);
    path_0.close();
    path_0.moveTo(size.width * 0.8339303, size.height * 0.7594179);
    path_0.cubicTo(
        size.width * 0.8332788,
        size.height * 0.7594179,
        size.width * 0.8319768,
        size.height * 0.7594179,
        size.width * 0.8313262,
        size.height * 0.7594179);
    path_0.cubicTo(
        size.width * 0.8261190,
        size.height * 0.7583731,
        size.width * 0.8228652,
        size.height * 0.7541940,
        size.width * 0.8241664,
        size.height * 0.7500075);
    path_0.cubicTo(
        size.width * 0.8274210,
        size.height * 0.7395575,
        size.width * 0.8293736,
        size.height * 0.7296269,
        size.width * 0.8293736,
        size.height * 0.7191739);
    path_0.cubicTo(
        size.width * 0.8293736,
        size.height * 0.7129022,
        size.width * 0.8287230,
        size.height * 0.7061075,
        size.width * 0.8274210,
        size.height * 0.6998351);
    path_0.cubicTo(
        size.width * 0.8267704,
        size.height * 0.6972224,
        size.width * 0.8261190,
        size.height * 0.6946090,
        size.width * 0.8254684,
        size.height * 0.6919955);
    path_0.cubicTo(
        size.width * 0.8241664,
        size.height * 0.6878142,
        size.width * 0.8274210,
        size.height * 0.6836328,
        size.width * 0.8326283,
        size.height * 0.6825881);
    path_0.cubicTo(
        size.width * 0.8378355,
        size.height * 0.6815425,
        size.width * 0.8430428,
        size.height * 0.6841560,
        size.width * 0.8443439,
        size.height * 0.6883373);
    path_0.cubicTo(
        size.width * 0.8449954,
        size.height * 0.6914731,
        size.width * 0.8456459,
        size.height * 0.6946090,
        size.width * 0.8462974,
        size.height * 0.6972224);
    path_0.cubicTo(
        size.width * 0.8475985,
        size.height * 0.7045396,
        size.width * 0.8482500,
        size.height * 0.7118567,
        size.width * 0.8482500,
        size.height * 0.7191739);
    path_0.cubicTo(
        size.width * 0.8482500,
        size.height * 0.7306724,
        size.width * 0.8462974,
        size.height * 0.7426933,
        size.width * 0.8423913,
        size.height * 0.7541940);
    path_0.cubicTo(
        size.width * 0.8417407,
        size.height * 0.7573284,
        size.width * 0.8378355,
        size.height * 0.7594179,
        size.width * 0.8339303,
        size.height * 0.7594179);
    path_0.close();
    path_0.moveTo(size.width * 0.8033383, size.height * 0.6407754);
    path_0.cubicTo(
        size.width * 0.8000836,
        size.height * 0.6407754,
        size.width * 0.7968290,
        size.height * 0.6397299,
        size.width * 0.7955270,
        size.height * 0.6371164);
    path_0.cubicTo(
        size.width * 0.7825093,
        size.height * 0.6214366,
        size.width * 0.7655864,
        size.height * 0.6062799,
        size.width * 0.7460595,
        size.height * 0.5911224);
    path_0.cubicTo(
        size.width * 0.7421543,
        size.height * 0.5879866,
        size.width * 0.7421543,
        size.height * 0.5832828,
        size.width * 0.7454080,
        size.height * 0.5801463);
    path_0.cubicTo(
        size.width * 0.7493141,
        size.height * 0.5770104,
        size.width * 0.7551719,
        size.height * 0.5770104,
        size.width * 0.7590771,
        size.height * 0.5796239);
    path_0.cubicTo(
        size.width * 0.7799061,
        size.height * 0.5953037,
        size.width * 0.7981310,
        size.height * 0.6115060,
        size.width * 0.8117993,
        size.height * 0.6282313);
    path_0.cubicTo(
        size.width * 0.8150539,
        size.height * 0.6318896,
        size.width * 0.8137519,
        size.height * 0.6365940,
        size.width * 0.8091961,
        size.height * 0.6392067);
    path_0.cubicTo(
        size.width * 0.8065920,
        size.height * 0.6402522,
        size.width * 0.8052909,
        size.height * 0.6407754,
        size.width * 0.8033383,
        size.height * 0.6407754);
    path_0.close();
    path_0.moveTo(size.width * 0.6881292, size.height * 0.5571500);
    path_0.cubicTo(
        size.width * 0.6868281,
        size.height * 0.5571500,
        size.width * 0.6848755,
        size.height * 0.5566269,
        size.width * 0.6835734,
        size.height * 0.5561045);
    path_0.cubicTo(
        size.width * 0.6633959,
        size.height * 0.5472194,
        size.width * 0.6399638,
        size.height * 0.5393791,
        size.width * 0.6132770,
        size.height * 0.5320619);
    path_0.cubicTo(
        size.width * 0.6080697,
        size.height * 0.5304940,
        size.width * 0.6054656,
        size.height * 0.5263127,
        size.width * 0.6074191,
        size.height * 0.5221313);
    path_0.cubicTo(
        size.width * 0.6093717,
        size.height * 0.5179500,
        size.width * 0.6145781,
        size.height * 0.5158597,
        size.width * 0.6197853,
        size.height * 0.5174276);
    path_0.cubicTo(
        size.width * 0.6477742,
        size.height * 0.5252672,
        size.width * 0.6718569,
        size.height * 0.5331075,
        size.width * 0.6933364,
        size.height * 0.5425149);
    path_0.cubicTo(
        size.width * 0.6978931,
        size.height * 0.5446060,
        size.width * 0.6998457,
        size.height * 0.5493097,
        size.width * 0.6972426,
        size.height * 0.5529687);
    path_0.cubicTo(
        size.width * 0.6952900,
        size.height * 0.5555813,
        size.width * 0.6920353,
        size.height * 0.5571500,
        size.width * 0.6881292,
        size.height * 0.5571500);
    path_0.close();
    path_0.moveTo(size.width * 0.5416784, size.height * 0.5153373);
    path_0.cubicTo(
        size.width * 0.5410279,
        size.height * 0.5153373,
        size.width * 0.5397258,
        size.height * 0.5153373,
        size.width * 0.5390743,
        size.height * 0.5153373);
    path_0.cubicTo(
        size.width * 0.5299619,
        size.height * 0.5132463,
        size.width * 0.5215009,
        size.height * 0.5116784,
        size.width * 0.5123885,
        size.height * 0.5095881);
    path_0.cubicTo(
        size.width * 0.4961162,
        size.height * 0.5064515,
        size.width * 0.4798429,
        size.height * 0.5027933,
        size.width * 0.4635706,
        size.height * 0.4991343);
    path_0.cubicTo(
        size.width * 0.4583643,
        size.height * 0.4980896,
        size.width * 0.4551097,
        size.height * 0.4939082,
        size.width * 0.4570623,
        size.height * 0.4897269);
    path_0.cubicTo(
        size.width * 0.4583643,
        size.height * 0.4855455,
        size.width * 0.4635716,
        size.height * 0.4829321,
        size.width * 0.4687779,
        size.height * 0.4839776);
    path_0.cubicTo(
        size.width * 0.4850502,
        size.height * 0.4876358,
        size.width * 0.5013234,
        size.height * 0.4907724,
        size.width * 0.5175957,
        size.height * 0.4944306);
    path_0.cubicTo(
        size.width * 0.5267082,
        size.height * 0.4965216,
        size.width * 0.5351691,
        size.height * 0.4980896,
        size.width * 0.5442816,
        size.height * 0.5001799);
    path_0.cubicTo(
        size.width * 0.5494888,
        size.height * 0.5012254,
        size.width * 0.5527435,
        size.height * 0.5054067,
        size.width * 0.5514414,
        size.height * 0.5095881);
    path_0.cubicTo(
        size.width * 0.5501403,
        size.height * 0.5127239,
        size.width * 0.5462342,
        size.height * 0.5153373,
        size.width * 0.5416784,
        size.height * 0.5153373);
    path_0.close();
    path_0.moveTo(size.width * 0.3913216, size.height * 0.4803187);
    path_0.cubicTo(
        size.width * 0.3900204,
        size.height * 0.4803187,
        size.width * 0.3887184,
        size.height * 0.4803187,
        size.width * 0.3880678,
        size.height * 0.4797963);
    path_0.cubicTo(
        size.width * 0.3607296,
        size.height * 0.4714336,
        size.width * 0.3372974,
        size.height * 0.4625485,
        size.width * 0.3158178,
        size.height * 0.4526179);
    path_0.cubicTo(
        size.width * 0.3112621,
        size.height * 0.4505276,
        size.width * 0.3099600,
        size.height * 0.4458231,
        size.width * 0.3125632,
        size.height * 0.4416418);
    path_0.cubicTo(
        size.width * 0.3151673,
        size.height * 0.4379836,
        size.width * 0.3210251,
        size.height * 0.4369381,
        size.width * 0.3262323,
        size.height * 0.4390291);
    path_0.cubicTo(
        size.width * 0.3464099,
        size.height * 0.4489597,
        size.width * 0.3691914,
        size.height * 0.4573216,
        size.width * 0.3952268,
        size.height * 0.4651619);
    path_0.cubicTo(
        size.width * 0.4004340,
        size.height * 0.4667299,
        size.width * 0.4030381,
        size.height * 0.4714336,
        size.width * 0.4010855,
        size.height * 0.4750925);
    path_0.cubicTo(
        size.width * 0.3991329,
        size.height * 0.4787507,
        size.width * 0.3952277,
        size.height * 0.4803187,
        size.width * 0.3913216,
        size.height * 0.4803187);
    path_0.close();
    path_0.moveTo(size.width * 0.2598411, size.height * 0.4149866);
    path_0.cubicTo(
        size.width * 0.2572379,
        size.height * 0.4149866,
        size.width * 0.2546338,
        size.height * 0.4139410,
        size.width * 0.2526812,
        size.height * 0.4123731);
    path_0.cubicTo(
        size.width * 0.2325037,
        size.height * 0.3951254,
        size.width * 0.2175335,
        size.height * 0.3768321,
        size.width * 0.2084210,
        size.height * 0.3574940);
    path_0.cubicTo(
        size.width * 0.2064675,
        size.height * 0.3533127,
        size.width * 0.2090716,
        size.height * 0.3491313,
        size.width * 0.2142788,
        size.height * 0.3475634);
    path_0.cubicTo(
        size.width * 0.2194861,
        size.height * 0.3459955,
        size.width * 0.2246924,
        size.height * 0.3480866,
        size.width * 0.2266459,
        size.height * 0.3522672);
    path_0.cubicTo(
        size.width * 0.2351069,
        size.height * 0.3695149,
        size.width * 0.2481255,
        size.height * 0.3862403,
        size.width * 0.2670009,
        size.height * 0.4019201);
    path_0.cubicTo(
        size.width * 0.2709061,
        size.height * 0.4050560,
        size.width * 0.2702556,
        size.height * 0.4102828,
        size.width * 0.2663504,
        size.height * 0.4128963);
    path_0.cubicTo(
        size.width * 0.2650483,
        size.height * 0.4139410,
        size.width * 0.2624452,
        size.height * 0.4149866,
        size.width * 0.2598411,
        size.height * 0.4149866);
    path_0.close();
    path_0.moveTo(size.width * 0.2090716, size.height * 0.3010470);
    path_0.cubicTo(
        size.width * 0.2084210,
        size.height * 0.3010470,
        size.width * 0.2084201,
        size.height * 0.3010470,
        size.width * 0.2077695,
        size.height * 0.3010470);
    path_0.cubicTo(
        size.width * 0.2025623,
        size.height * 0.3005246,
        size.width * 0.1986571,
        size.height * 0.2963433,
        size.width * 0.1993076,
        size.height * 0.2921619);
    path_0.cubicTo(
        size.width * 0.2025623,
        size.height * 0.2712552,
        size.width * 0.2110242,
        size.height * 0.2508716,
        size.width * 0.2253439,
        size.height * 0.2304881);
    path_0.cubicTo(
        size.width * 0.2279470,
        size.height * 0.2268299,
        size.width * 0.2338058,
        size.height * 0.2252612,
        size.width * 0.2383615,
        size.height * 0.2273522);
    path_0.cubicTo(
        size.width * 0.2429182,
        size.height * 0.2294425,
        size.width * 0.2448708,
        size.height * 0.2341470,
        size.width * 0.2422667,
        size.height * 0.2378052);
    path_0.cubicTo(
        size.width * 0.2292491,
        size.height * 0.2566209,
        size.width * 0.2214387,
        size.height * 0.2754366,
        size.width * 0.2181840,
        size.height * 0.2942522);
    path_0.cubicTo(
        size.width * 0.2181840,
        size.height * 0.2979112,
        size.width * 0.2142788,
        size.height * 0.3010470,
        size.width * 0.2090716,
        size.height * 0.3010470);
    path_0.close();
    path_0.moveTo(size.width * 0.7799061, size.height * 0.2038328);
    path_0.cubicTo(
        size.width * 0.7779526,
        size.height * 0.2038328,
        size.width * 0.7753494,
        size.height * 0.2033097,
        size.width * 0.7733968,
        size.height * 0.2017418);
    path_0.cubicTo(
        size.width * 0.7733968,
        size.height * 0.2017418,
        size.width * 0.7493141,
        size.height * 0.1855396,
        size.width * 0.7102602,
        size.height * 0.1677694);
    path_0.cubicTo(
        size.width * 0.7057035,
        size.height * 0.1656784,
        size.width * 0.7037509,
        size.height * 0.1609746,
        size.width * 0.7063550,
        size.height * 0.1573157);
    path_0.cubicTo(
        size.width * 0.7089582,
        size.height * 0.1536575,
        size.width * 0.7148160,
        size.height * 0.1520896,
        size.width * 0.7193727,
        size.height * 0.1541799);
    path_0.cubicTo(
        size.width * 0.7603792,
        size.height * 0.1729955,
        size.width * 0.7844619,
        size.height * 0.1891978,
        size.width * 0.7857639,
        size.height * 0.1902433);
    path_0.cubicTo(
        size.width * 0.7896691,
        size.height * 0.1928567,
        size.width * 0.7903197,
        size.height * 0.1980836,
        size.width * 0.7870660,
        size.height * 0.2012194);
    path_0.cubicTo(
        size.width * 0.7851125,
        size.height * 0.2027873,
        size.width * 0.7825093,
        size.height * 0.2038328,
        size.width * 0.7799061,
        size.height * 0.2038328);
    path_0.close();
    path_0.moveTo(size.width * 0.2813206, size.height * 0.1923343);
    path_0.cubicTo(
        size.width * 0.2787175,
        size.height * 0.1923343,
        size.width * 0.2761134,
        size.height * 0.1918112,
        size.width * 0.2741608,
        size.height * 0.1902433);
    path_0.cubicTo(
        size.width * 0.2702556,
        size.height * 0.1871075,
        size.width * 0.2702556,
        size.height * 0.1824037,
        size.width * 0.2741608,
        size.height * 0.1792679);
    path_0.cubicTo(
        size.width * 0.2930372,
        size.height * 0.1641104,
        size.width * 0.3145167,
        size.height * 0.1505216,
        size.width * 0.3379489,
        size.height * 0.1395455);
    path_0.cubicTo(
        size.width * 0.3425046,
        size.height * 0.1374552,
        size.width * 0.3483625,
        size.height * 0.1385000,
        size.width * 0.3516171,
        size.height * 0.1421590);
    path_0.cubicTo(
        size.width * 0.3542212,
        size.height * 0.1458172,
        size.width * 0.3529191,
        size.height * 0.1505216,
        size.width * 0.3483625,
        size.height * 0.1531343);
    path_0.cubicTo(
        size.width * 0.3268829,
        size.height * 0.1635881,
        size.width * 0.3067054,
        size.height * 0.1761313,
        size.width * 0.2884805,
        size.height * 0.1902433);
    path_0.cubicTo(
        size.width * 0.2865279,
        size.height * 0.1912888,
        size.width * 0.2839238,
        size.height * 0.1923343,
        size.width * 0.2813206,
        size.height * 0.1923343);
    path_0.close();
    path_0.moveTo(size.width * 0.6445195, size.height * 0.1421590);
    path_0.cubicTo(
        size.width * 0.6432184,
        size.height * 0.1421590,
        size.width * 0.6419164,
        size.height * 0.1421590,
        size.width * 0.6412649,
        size.height * 0.1416366);
    path_0.cubicTo(
        size.width * 0.6165316,
        size.height * 0.1343187,
        size.width * 0.5917974,
        size.height * 0.1285694,
        size.width * 0.5677138,
        size.height * 0.1249112);
    path_0.cubicTo(
        size.width * 0.5625065,
        size.height * 0.1238657,
        size.width * 0.5586013,
        size.height * 0.1202075,
        size.width * 0.5599033,
        size.height * 0.1160261);
    path_0.cubicTo(
        size.width * 0.5612054,
        size.height * 0.1118448,
        size.width * 0.5657612,
        size.height * 0.1087090,
        size.width * 0.5709684,
        size.height * 0.1097537);
    path_0.cubicTo(
        size.width * 0.5963532,
        size.height * 0.1134127,
        size.width * 0.6223894,
        size.height * 0.1191619,
        size.width * 0.6477742,
        size.height * 0.1270015);
    path_0.cubicTo(
        size.width * 0.6529814,
        size.height * 0.1285694,
        size.width * 0.6555846,
        size.height * 0.1332739,
        size.width * 0.6536320,
        size.height * 0.1369321);
    path_0.cubicTo(
        size.width * 0.6516794,
        size.height * 0.1400679,
        size.width * 0.6484247,
        size.height * 0.1421590,
        size.width * 0.6445195,
        size.height * 0.1421590);
    path_0.close();
    path_0.moveTo(size.width * 0.4147537, size.height * 0.1290925);
    path_0.cubicTo(
        size.width * 0.4101980,
        size.height * 0.1290925,
        size.width * 0.4062928,
        size.height * 0.1270015,
        size.width * 0.4056413,
        size.height * 0.1233433);
    path_0.cubicTo(
        size.width * 0.4043392,
        size.height * 0.1191619,
        size.width * 0.4069433,
        size.height * 0.1149806,
        size.width * 0.4121506,
        size.height * 0.1139351);
    path_0.cubicTo(
        size.width * 0.4375353,
        size.height * 0.1081858,
        size.width * 0.4642221,
        size.height * 0.1050500,
        size.width * 0.4915595,
        size.height * 0.1045276);
    path_0.cubicTo(
        size.width * 0.4967667,
        size.height * 0.1045276,
        size.width * 0.5013234,
        size.height * 0.1076634,
        size.width * 0.5013234,
        size.height * 0.1123672);
    path_0.cubicTo(
        size.width * 0.5013234,
        size.height * 0.1165485,
        size.width * 0.4974173,
        size.height * 0.1202075,
        size.width * 0.4915595,
        size.height * 0.1202075);
    path_0.cubicTo(
        size.width * 0.4661747,
        size.height * 0.1207299,
        size.width * 0.4407900,
        size.height * 0.1238657,
        size.width * 0.4167063,
        size.height * 0.1290925);
    path_0.cubicTo(
        size.width * 0.4160558,
        size.height * 0.1290925,
        size.width * 0.4154052,
        size.height * 0.1290925,
        size.width * 0.4147537,
        size.height * 0.1290925);
    path_0.close();

    return path_0;
  }

  static Path pathOfNumber(Size size) {
    Path path_44 = Path();
    path_44.moveTo(size.width * 0.8197546, size.height * 0.2257276);
    path_44.lineTo(size.width * 0.8155204, size.height * 0.2257276);
    path_44.lineTo(size.width * 0.8155204, size.height * 0.2040627);
    path_44.cubicTo(
        size.width * 0.8145009,
        size.height * 0.2048433,
        size.width * 0.8131608,
        size.height * 0.2056239,
        size.width * 0.8114981,
        size.height * 0.2064052);
    path_44.cubicTo(
        size.width * 0.8098513,
        size.height * 0.2071858,
        size.width * 0.8083699,
        size.height * 0.2077709,
        size.width * 0.8070520,
        size.height * 0.2081612);
    path_44.lineTo(size.width * 0.8070520, size.height * 0.2048746);
    path_44.cubicTo(
        size.width * 0.8094201,
        size.height * 0.2039806,
        size.width * 0.8114907,
        size.height * 0.2028978,
        size.width * 0.8132621,
        size.height * 0.2016261);
    path_44.cubicTo(
        size.width * 0.8150344,
        size.height * 0.2003545,
        size.width * 0.8162890,
        size.height * 0.1991201,
        size.width * 0.8170260,
        size.height * 0.1979239);
    path_44.lineTo(size.width * 0.8197546, size.height * 0.1979239);
    path_44.lineTo(size.width * 0.8197546, size.height * 0.2257276);
    path_44.close();
    return path_44;
  }

  static Path pathOfStart(Size size) {
    Path path_33 = Path();
    path_33.moveTo(size.width * 0.8156199, size.height * 0.2388418);
    path_33.cubicTo(
        size.width * 0.8332844,
        size.height * 0.2388418,
        size.width * 0.8475762,
        size.height * 0.2273328,
        size.width * 0.8475762,
        size.height * 0.2131813);
    path_33.cubicTo(
        size.width * 0.8475762,
        size.height * 0.1990299,
        size.width * 0.8332444,
        size.height * 0.1874888,
        size.width * 0.8156199,
        size.height * 0.1874888);
    path_33.cubicTo(
        size.width * 0.7979963,
        size.height * 0.1874888,
        size.width * 0.7836245,
        size.height * 0.1989978,
        size.width * 0.7836245,
        size.height * 0.2131813);
    path_33.cubicTo(
        size.width * 0.7836245,
        size.height * 0.2273657,
        size.width * 0.7979563,
        size.height * 0.2388418,
        size.width * 0.8156199,
        size.height * 0.2388418);
    path_33.close();
    return path_33;
  }

  static Path pathOfArrow(Size size) {
    Path path_22 = Path();
    path_22.moveTo(size.width * 0.1175223, size.height * 0.7473284);
    path_22.cubicTo(
        size.width * 0.1246571,
        size.height * 0.7464701,
        size.width * 0.1278783,
        size.height * 0.7499851,
        size.width * 0.1247110,
        size.height * 0.7552015);
    path_22.lineTo(size.width * 0.09699349, size.height * 0.8008358);
    path_22.cubicTo(
        size.width * 0.09382621,
        size.height * 0.8060522,
        size.width * 0.08838745,
        size.height * 0.8061791,
        size.width * 0.08484229,
        size.height * 0.8011343);
    path_22.lineTo(size.width * 0.05889377, size.height * 0.7642910);
    path_22.cubicTo(
        size.width * 0.05534861,
        size.height * 0.7592388,
        size.width * 0.05825223,
        size.height * 0.7544627,
        size.width * 0.06538755,
        size.height * 0.7535970);
    path_22.lineTo(size.width * 0.1175223, size.height * 0.7473284);
    path_22.close();
    return path_22;
  }

  final List<Color?>? colorsOfPaths;
  final List<Offset> points;
  @override
  void paint(Canvas canvas, Size size) {
    // List of path functions and their corresponding colors
    final List pathFunctions = [
      path0,
      path3,
      path12,
      path13,
      path4,
      path2,
      path5,
      path6,
      path7,
      path8,
      path9,
      path10,
      path11,
      path1
    ];

    final Paint defaultPaint = Paint()..style = PaintingStyle.fill;

    // Draw all paths with default or provided colors

    for (int i = 0; i < pathFunctions.length; i++) {
      Path path = pathFunctions[i]!(size).$1;
      Paint paint = defaultPaint
        ..color = AppColorPhonetics.lightBlueColor2.withOpacity(1.0);
      canvas.drawPath(path, paint);
    }

    // Draw the letter paths
    Path allMainPath = mainPath(size);
    Path allPathOfLetter = pathOfLetter(Size(size.width, size.height));
    Rect bounds2 = allPathOfLetter.getBounds();
    Rect adjustedBounds1 = Rect.fromLTRB(
      bounds2.left,
      bounds2.top,
      bounds2.right,
      bounds2.bottom,
    );
    double dx = adjustedBounds1.center.dx - bounds2.center.dx;
    double dy = adjustedBounds1.center.dy - bounds2.center.dy;
    allMainPath = allPathOfLetter.shift(Offset(dx, dy));
    Paint paintOfLetterFill = Paint()..style = PaintingStyle.fill;
    paintOfLetterFill.color = AppColorPhonetics.greyColor.withOpacity(1.0);
    canvas.drawPath(allMainPath, paintOfLetterFill);

    // Draw additional paths
    final List<Path Function(Size)> additionalPaths = [
      pathOfArrow,
      pathOfStart,
      pathOfNumber
    ];

    final List<Color> additionalColors = [
      AppColorPhonetics.whiteColor,
      AppColorPhonetics.whiteColor,
      AppColorPhonetics.greyColor
    ];

    for (int i = 0; i < additionalPaths.length; i++) {
      Path path = additionalPaths[i](size);
      Paint paint = Paint()
        ..style = PaintingStyle.fill
        ..color = additionalColors[i].withOpacity(1.0);
      canvas.drawPath(path, paint);
    }

    if (points.isNotEmpty && colorsOfPaths != null) {
      int lastIndexcolor =
          colorsOfPaths!.lastIndexWhere((color) => color != null);

      if (lastIndexcolor != -1) {
        for (int i = 0; i < pathFunctions.length; i++) {
          Path path = pathFunctions[i]!(size).$1;
          Paint paint = defaultPaint
            ..color = colorsOfPaths?[i] ??
                AppColorPhonetics.lightBlueColor2.withOpacity(1.0);
          if (i == lastIndexcolor) {
            // PathHelper.paintPathUntilOffset(
            //     canvas, path, points, paint, i == pathFunctions.length - 1);
          } else {
            if (colorsOfPaths![i] != null) {
              Paint paint = defaultPaint
                ..color = colorsOfPaths![i] ?? Colors.transparent;
              canvas.drawPath(path, paint);
            }
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  static (Path, int)? indexOfPointInside(
      Offset point, Size size, bool isFingerPosition) {
    if (path0(size).$1.contains(point)) {
      return path0(size);
    } else if (path1(size).$1.contains(point)) {
      return path1(size);
    } else if (path2(size).$1.contains(point)) {
      return path2(size);
    } else if (path3(size).$1.contains(point)) {
      return path3(size);
    } else if (path4(size).$1.contains(point)) {
      return path4(size);
    } else if (path5(size).$1.contains(point)) {
      return path5(size);
    } else if (path6(size).$1.contains(point)) {
      return path6(size);
    } else if (path7(size).$1.contains(point)) {
      return path7(size);
    } else if (path8(size).$1.contains(point)) {
      return path8(size);
    } else if (path9(size).$1.contains(point)) {
      return path9(size);
    } else if (path10(size).$1.contains(point)) {
      return path10(size);
    } else if (path11(size).$1.contains(point)) {
      return path11(size);
    } else if (path12(size).$1.contains(point)) {
      return path12(size);
    } else if (path13(size).$1.contains(point)) {
      return path13(size);
    } else {
      return null;
    }
  }

  static (Path, int)? checkDistanceFromPathEdge(
      (Path, int) pathAndValue, Offset offset) {
    Path path = pathAndValue.$1;
    Rect bounds = path.getBounds();
    double distanceToLeftEdge = (offset.dx - bounds.left).abs();
    double distanceToBottomEdge = (offset.dy - bounds.bottom).abs();
    bool is20FromLeftEdge = distanceToLeftEdge <= 20;
    bool is20FromBottomEdge = distanceToBottomEdge <= 20;
    if (is20FromLeftEdge == true || is20FromBottomEdge == true) {
      return pathAndValue;
    } else {
      return null;
    }
  }
}
