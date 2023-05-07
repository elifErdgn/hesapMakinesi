import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../controller/calculate_controller.dart';
import '../utils/colors.dart';
import 'controller/theme_model.dart';
import 'widgets/button.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOperator(String y) {
    if (y == "%" || y == "/" || y == "x" || y == "-" || y == "+" || y == "=") {
      return true;
    }
    return false;
  }

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "^",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CalculateController>();

    return Consumer(
      builder: ((context, ThemeModel themeNotifier, child) {
        return Scaffold(
          backgroundColor: themeNotifier.isDark
              ? DarkColors.scaffoldBgColor
              : LightColors.scaffoldBgColor,
          body: Column(
            children: [
              GetBuilder<CalculateController>(builder: (context) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: 100,
                        height: 45,
                        decoration: BoxDecoration(
                            color: themeNotifier.isDark
                                ? DarkColors.sheetBgColor
                                : LightColors.sheetBgColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    themeNotifier.isDark = false;
                                  });
                                },
                                child: Icon(
                                  Icons.light_mode_outlined,
                                  color: themeNotifier.isDark
                                      ? Colors.white
                                      : Colors.grey,
                                  size: 25,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    themeNotifier.isDark = true;
                                  });
                                },
                                child: Icon(
                                  Icons.dark_mode_outlined,
                                  color: themeNotifier.isDark
                                      ? Colors.white
                                      : Colors.grey,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 70),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                controller.userInput,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: themeNotifier.isDark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 25),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Text(controller.userOutput,
                                  style: TextStyle(
                                      color: themeNotifier.isDark
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 32)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: themeNotifier.isDark
                          ? DarkColors.sheetBgColor
                          : LightColors.sheetBgColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: buttons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemBuilder: (contex, index) {
                        switch (index) {

                          /// CLEAR BTN
                          case 0:
                            return CustomButton(
                                buttonTapped: () {
                                  controller.clearInputAndOutput();
                                },
                                color: themeNotifier.isDark
                                    ? DarkColors.btnBgColor
                                    : LightColors.btnBgColor,
                                textColor: themeNotifier.isDark
                                    ? DarkColors.leftOperatorColor
                                    : LightColors.leftOperatorColor,
                                text: buttons[index]);

                          /// DELETE BTN
                          case 1:
                            return CustomButton(
                                buttonTapped: () {
                                  controller.deleteBtnAction();
                                },
                                color: themeNotifier.isDark
                                    ? DarkColors.btnBgColor
                                    : LightColors.btnBgColor,
                                textColor: themeNotifier.isDark
                                    ? DarkColors.leftOperatorColor
                                    : LightColors.leftOperatorColor,
                                text: buttons[index]);

                          /// EQUAL BTN
                          case 19:
                            return CustomButton(
                                buttonTapped: () {
                                  controller.equalPressed();
                                },
                                color: themeNotifier.isDark
                                    ? DarkColors.btnBgColor
                                    : LightColors.btnBgColor,
                                textColor: themeNotifier.isDark
                                    ? DarkColors.leftOperatorColor
                                    : LightColors.leftOperatorColor,
                                text: buttons[index]);

                          default:
                            return CustomButton(
                                buttonTapped: () {
                                  controller.onBtnTapped(buttons, index);
                                },
                                color: themeNotifier.isDark
                                    ? DarkColors.btnBgColor
                                    : LightColors.btnBgColor,
                                textColor: isOperator(buttons[index])
                                    ? LightColors.operatorColor
                                    : themeNotifier.isDark
                                        ? Colors.white
                                        : Colors.black,
                                text: buttons[index]);
                        }
                      }),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
