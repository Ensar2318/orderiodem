import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:zwerge/screens/home.dart';
import 'package:zwerge/utils/Colors.dart';

import '../controllers/userController.dart';

class InfoSlider extends StatefulWidget {
  const InfoSlider({Key? key}) : super(key: key);

  @override
  State<InfoSlider> createState() => _InfoSliderState();
}

class _InfoSliderState extends State<InfoSlider> {
  int page = 0;
  LiquidController? liquidController;
  final pages = [
    Container(
        child: Stack(
      children: [
        Image.asset('assets/infoBg.png'),
        Center(
          child: Container(
            margin: EdgeInsets.only(left: Get.width * 0.1, right: Get.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/7zwerge.jpeg',
                  width: Get.width * 0.5,
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Text("Hoşgeldin,",
                    style: TextStyle(
                        color: MyColors.slateGrey, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 28.0),
                    textAlign: TextAlign.center),
                SizedBox(height: 20),
                Text("7zwerge’ya Hoşgeldin. \nHaydi, Lezzeti deneyimle!",
                    style: const TextStyle(
                        color: MyColors.slateGrey,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Avenir-Roman",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0),
                    textAlign: TextAlign.center)
              ],
            ),
          ),
        )
      ],
    )),
    Container(
        child: Stack(
      children: [
        Image.asset('assets/infoBg.png'),
        Center(
          child: Container(
            margin: EdgeInsets.only(left: Get.width * 0.1, right: Get.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Image.asset(
                  'assets/7zwerge.jpeg',
                  width: Get.width * 0.4,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: Get.height * 0.33,
                  child: Image.asset(
                    'assets/firt-screen1.png',
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Text("Yiyecek Bişeyler Bul",
                    style: TextStyle(
                        color: MyColors.slateGrey, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 28.0),
                    textAlign: TextAlign.center),
                SizedBox(height: 20),
                Text("Restorandaki, tüm ürünleri\nincele, damağına uygun bir\nlezzet bul.",
                    style: const TextStyle(
                        color: MyColors.slateGrey,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Avenir-Roman",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0),
                    textAlign: TextAlign.center)
              ],
            ),
          ),
        )
      ],
    )),
    Container(
        child: Stack(
      children: [
        Image.asset('assets/infoBg.png'),
        Center(
          child: Container(
            margin: EdgeInsets.only(left: Get.width * 0.1, right: Get.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Image.asset(
                  'assets/7zwerge.jpeg',
                  width: Get.width * 0.4,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: Get.height * 0.33,
                  child: Image.asset(
                    'assets/firt-screen2.png',
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Text("Kolaylıkla Öde",
                    style: TextStyle(
                        color: MyColors.slateGrey, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 28.0),
                    textAlign: TextAlign.center),
                SizedBox(height: 20),
                Text("Banka kartı ve kredi kartıla\nrahatlıkla ödemeni\nyapabilirsin.",
                    style: const TextStyle(
                        color: MyColors.slateGrey,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Avenir-Roman",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0),
                    textAlign: TextAlign.center)
              ],
            ),
          ),
        )
      ],
    )),
    Container(
        child: Stack(
      children: [
        Image.asset('assets/infoBg.png'),
        Center(
          child: Container(
            margin: EdgeInsets.only(left: Get.width * 0.1, right: Get.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Image.asset(
                  'assets/7zwerge.jpeg',
                  width: Get.width * 0.4,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: Get.height * 0.33,
                  child: Image.asset(
                    'assets/firt-screen3.png',
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Text("Lezzet Kapında",
                    style: TextStyle(
                        color: MyColors.slateGrey, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 28.0),
                    textAlign: TextAlign.center),
                SizedBox(height: 20),
                Text("Harika! siparişin kapına ulaştı\nartık lezzeti deneyimlemek\niçin sıra sende!",
                    style: const TextStyle(
                        color: MyColors.slateGrey,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Avenir-Roman",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0),
                    textAlign: TextAlign.center)
              ],
            ),
          ),
        )
      ],
    )),
  ];
//Image.asset('assets/infoBg.png'),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
          builder: (context) => Stack(
                children: [
                  LiquidSwipe(
                    pages: pages,
                    onPageChangeCallback: pageChangeCallback,
                    waveType: WaveType.liquidReveal,
                    liquidController: liquidController,
                    ignoreUserGestureWhileAnimating: true,
                    enableLoop: false,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(4, _buildDot),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(Home());
                            Get.find<UserController>().box.write("firstOpen", true);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 35),
                            width: Get.width * 0.85,
                            height: 52,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(17)), color: MyColors.watermelon),
                            child: Center(
                              child: Text("Start",
                                  style: const TextStyle(
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Avenir",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
    );
  }

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }

  Widget _buildDot(int index) {
    var selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    var zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return Container(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.red,
          type: MaterialType.circle,
          child: Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }
}
