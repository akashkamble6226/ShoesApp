import 'dart:io';
import 'dart:ui';

import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shoesapp/controllers/change_image_controller.dart';
import 'package:shoesapp/controllers/dynamic_shoe_size.dart';
import 'package:shoesapp/controllers/shoe_size_controller.dart';
import 'package:shoesapp/models/single_shoe_class.dart';

import '../models/show_dummy_data.dart';

class ShoeDetails extends StatefulWidget {
  final int index;

  ShoeDetails({required this.index});

  @override
  _ShoeDetailsState createState() => _ShoeDetailsState();
}

class _ShoeDetailsState extends State<ShoeDetails>
    with TickerProviderStateMixin {
  // floating action button animation
  late AnimationController floatingButtonController;
  late Animation floatingButtonAnim;

  late AnimationController _controller;
  late Animation _animation;
  late Path _path;

  // shoe shrink down animation

  bool itsVisible = true;
  bool smallShoeItsVisible = false;

  

  @override
  void initState() {
    floatingButtonController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    floatingButtonAnim = Tween<double>(
      begin: 0.0,
      end: -20.0,
    ).animate(floatingButtonController);

    // small shoe animation
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    super.initState();
    _animation = Tween(begin: 0.4, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // _controller.forward();

    // checking whether the screen is scrolled or not
     var _scrollController = ScrollController();
     double height = 600;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // Perform your task
        height = 600.0;
        
      }
      else
      {
         height = 700.0;
      }
    });

    _path = drawPath(height);

    //super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    floatingButtonController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Path drawPath(double height) {
    Size size = Size(300, height - 15);
    Path path = Path();
    //  path.lineTo(size.width /2, 0);
    path.cubicTo(size.width * 0.96, size.height * 0.36, size.width,
        size.height * 0.59, size.width, size.height);
    return path;
  }

  Offset calculate(value) {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos!.position;
  }

  bool startOnce = true;
  bool isActiveCount = false;
  void startFloatingButtonAnimation() {
    if (startOnce) {
      startOnce = false;

      floatingButtonController.forward();

      _controller.forward();

      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            smallShoeItsVisible = false;
            //floatingButtonController.forward();
            //take the floating button up again

            isActiveCount = true;
            // sleep(const Duration(seconds: 2));
            reverseToInitialStage();
          });
        }
      });

      floatingButtonController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          floatingButtonController.reverse();

          setState(() {
            itsVisible = false;
            smallShoeItsVisible = true;
          });
        }

        //  reverseToInitialStage();
      });
    }
  }

  Future<void> reverseToInitialStage() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      itsVisible = true;
      smallShoeItsVisible = false;
      isActiveCount = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Shoe shoe = shoeItems[widget.index];

    final ShoeSizeController shoeSizeController = Get.put(ShoeSizeController());
    final ChangeImageController changeImageController =
        Get.put(ChangeImageController());
    final DynamicShoeSize dynamicShoeSizeController =
        Get.put(DynamicShoeSize());

    return SafeArea(
      child: Scaffold(
        floatingActionButton: Container(
          height: 80,
          width: 80,
          child: AnimatedBuilder(
            animation: floatingButtonAnim,
            builder: (BuildContext btx, Widget? child) {
              return Transform.translate(
                offset: Offset(0, floatingButtonAnim.value),
                child: buildFittedBox(),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: height * 0.6,
                      decoration: BoxDecoration(
                          color: HexColor(shoe.bgColor).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.arrowLeft,
                                  ),
                                ),
                                Spacer(),
                                GetBuilder<ChangeImageController>(
                                  init: ChangeImageController(),
                                  builder: (imagecontroller) {
                                    return Row(
                                      children: [
                                        buildContainer(
                                            imagecontroller.isActive[0]),
                                        SizedBox(width: 5),
                                        buildContainer(
                                            imagecontroller.isActive[1]),
                                        SizedBox(width: 5),
                                        buildContainer(
                                            imagecontroller.isActive[2]),
                                        SizedBox(width: 5),
                                        buildContainer(
                                            imagecontroller.isActive[3]),
                                      ],
                                    );
                                  },
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: FaIcon(FontAwesomeIcons.heart))
                              ],
                            ),
                          ),

                          // main shoe widget
                          Stack(
                            // alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.4,
                                width: width,
                                child: Align(
                                  alignment: Alignment(0.0, 0.8),
                                  child: Transform.rotate(
                                    angle: shoe.rotateAngle.toDouble(),
                                    child: Container(
                                      width: 220,
                                      height: 220,
                                      decoration: BoxDecoration(
                                        color: HexColor(shoe.bgColor)
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                duration: Duration(seconds: 5),
                                curve: Curves.easeInCubic,
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: buildListView(shoe),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Women Running Shoes',
                          style: TextStyle(fontSize: 15),
                        ),
                        Row(
                          children: [
                            Text(
                              shoe.shoeName,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                '\$ ' + shoe.price,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor("#FF8C00")),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Select size",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 70,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (BuildContext ctx, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: GetBuilder<ShoeSizeController>(
                                      init: ShoeSizeController(),
                                      builder: (controller) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.toggleSelectSize(index);
                                          },
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: controller.isActive[index]
                                                  ? HexColor("#FF8C00")
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color:
                                                      controller.isActive[index]
                                                          ? HexColor("#FF8C00")
                                                          : Colors.grey),
                                            ),
                                            child: Center(
                                              child: Text(
                                                controller.shoeSize[index],
                                                style: TextStyle(
                                                    color: controller
                                                            .isActive[index]
                                                        ? Colors.white
                                                        : Colors.grey,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: width,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                "Find in store",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: width,
                            child: Text(
                              "Run the streets in the Nike React Escape Run.Designed and tailored for women, it features a wider collar and embroidered details.Cushioned foam provides a soft, responsive feel on the go.Escape the daily routine and reconnect with yourself through your miles.",
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              smallShoeItsVisible
                  ? Positioned(
                      top: calculate(_animation.value).dy,
                      left: calculate(_animation.value).dx,
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          shoe.images[0],
                          //  scale: 2.5,
                          width: 70,
                          height: 50,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFittedBox() {
    return FittedBox(
      child: FloatingActionButton(
        onPressed: () {
          startFloatingButtonAnimation();
        },
        backgroundColor: isActiveCount ? HexColor('#FF8C00') : Colors.black,
        child: Center(
          child: isActiveCount
              ? Text('+1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ))
              : Icon(Icons.shopping_cart_outlined),
        ),
      ),
    );
  }

// HexColor('') :
  Container buildContainer(bool isActive) {
    return isActive
        ? Container(
            width: 35,
            height: 8,
            decoration: BoxDecoration(
                color: HexColor('#000000'),
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(10)),
          )
        : Container(
            width: 10,
            height: 8,
            decoration: BoxDecoration(
              color: HexColor('#D3D3D3'),
              shape: BoxShape.circle,
            ),
          );
  }

  Widget buildListView(Shoe shoe) {
    return GetBuilder<ChangeImageController>(
      init: ChangeImageController(),
      builder: (controller) {
        return ListView.builder(
          controller: controller.scrollController,
          //  physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: shoe.images.length,
          itemBuilder: (BuildContext ctx, int index) {
            // below line is for shrinking
            return index == 0
                ? AnimatedOpacity(
                    duration: Duration(seconds: 0),
                    opacity: itsVisible ? 1.0 : 0.0,
                    child: Image.asset(
                      shoe.images[index],
                      //  scale: 2.5,
                      width: 350,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : Image.asset(
                    shoe.images[index],
                    //  scale: 2.5,
                    width: 350,
                    fit: BoxFit.fitWidth,
                  );
          },
        );
      },
    );
  }
}

/*
  AnimatedOpacity(
                duration: Duration(seconds: 0),
                opacity: widget.smallShoeItsVisible ? 1.0 : 0.0,
                child: Align(
                  alignment: Alignment(0.0,0.0),
                                  child: Image.asset(
                    widget.shoe.images[0],
                    //  scale: 2.5,
                    width: 100,
                    height: 50,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
 */
