import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/utils/helper.dart';

class Closed extends GetView<ProductController> {
  const Closed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          left: Get.width * 0.05,
          right: Get.width * 0.05,
          top: Get.height * 0.05,
        ),
        child: GetBuilder<ProductController>(builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(left: screenW(0.15, context), right: screenW(0.15, context)), child: Image.asset('assets/7zwerge.jpeg')),
                const Text("Closed",
                    style: TextStyle(
                        color: MyColors.black, fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 24.0),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 15,
                ),
                const Text("Sorry, we are closed now. You can check our work time in the table.",
                    style: TextStyle(
                        color: MyColors.softText, fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 16.0),
                    textAlign: TextAlign.center),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(120.0),
                    border: TableBorder.all(color: Colors.black, style: BorderStyle.solid, width: 2),
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Day', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                          )
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Time', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                          )
                        ]),
                      ]),
                      TableRow(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Container(margin: EdgeInsets.only(top: 14), child: Text('Monday', style: TextStyle(fontSize: 14.0)))]),
                        controller.options != null
                            ? Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(controller.options!.mondayStart.toString() + '\n' + controller.options!.mondayEnd.toString(),
                                      style: TextStyle(fontSize: 14.0)),
                                )
                              ])
                            : Column(),
                      ]),
                      TableRow(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Container(margin: EdgeInsets.only(top: 14), child: Text('Tuesday', style: TextStyle(fontSize: 14.0)))]),
                        controller.options != null
                            ? Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(controller.options!.tuesdayStart.toString() + '\n' + controller.options!.tuesdayEnd.toString(),
                                      style: TextStyle(fontSize: 14.0)),
                                )
                              ])
                            : Column(),
                      ]),
                      TableRow(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Container(margin: EdgeInsets.only(top: 14), child: Text('Wednesday', style: TextStyle(fontSize: 14.0)))]),
                        controller.options != null
                            ? Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(controller.options!.wednesdayStart.toString() + '\n' + controller.options!.wednesdayEnd.toString(),
                                      style: TextStyle(fontSize: 14.0)),
                                )
                              ])
                            : Column(),
                      ]),
                      TableRow(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Container(margin: EdgeInsets.only(top: 14), child: Text('Thursday', style: TextStyle(fontSize: 14.0)))]),
                        controller.options != null
                            ? Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(controller.options!.thursdayStart.toString() + '\n' + controller.options!.thursdayEnd.toString(),
                                      style: TextStyle(fontSize: 14.0)),
                                )
                              ])
                            : Column(),
                      ]),
                      TableRow(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Container(margin: EdgeInsets.only(top: 14), child: Text('Friday', style: TextStyle(fontSize: 14.0)))]),
                        controller.options != null
                            ? Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(controller.options!.fridayStart.toString() + '\n' + controller.options!.fridayEnd.toString(),
                                      style: TextStyle(fontSize: 14.0)),
                                )
                              ])
                            : Column(),
                      ]),
                      TableRow(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Container(margin: EdgeInsets.only(top: 14), child: Text('Saturday', style: TextStyle(fontSize: 14.0)))]),
                        controller.options != null
                            ? Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(controller.options!.saturdayStart.toString() + '\n' + controller.options!.saturdayEnd.toString(),
                                      style: TextStyle(fontSize: 14.0)),
                                )
                              ])
                            : Column(),
                      ]),
                      TableRow(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Container(margin: EdgeInsets.only(top: 14), child: Text('Sunday', style: TextStyle(fontSize: 14.0)))]),
                        controller.options != null
                            ? Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(controller.options!.sundayStart.toString() + '\n' + controller.options!.sundayEnd.toString(),
                                      style: TextStyle(fontSize: 14.0)),
                                )
                              ])
                            : Column(),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
