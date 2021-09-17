import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shoesapp/controllers/change_image_controller.dart';
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

  // shoe shrink down animation
  late AnimationController shoeShrinkController;
  late Animation shoeShrinkAnim;

  @override
  void initState() {
    floatingButtonController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    floatingButtonAnim = Tween<double>(
      begin: 0.0,
      end: -20.0,
    ).animate(floatingButtonController);

    shoeShrinkController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    shoeShrinkAnim =
        Tween<double>(begin: 0.0, end: 500).animate(shoeShrinkController);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    floatingButtonController.dispose();

    super.dispose();
  }

  void startFloatingButtonAnimation() {
    floatingButtonController.forward();
    floatingButtonController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // start shoe animation here
        shoeShrinkController.forward();
        floatingButtonController.reverse();
        // create +1 symbol
      }
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
          child: Column(
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
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 20),
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
                                    buildContainer(imagecontroller.isActive[0]),
                                    SizedBox(width: 5),
                                    buildContainer(imagecontroller.isActive[1]),
                                    SizedBox(width: 5),
                                    buildContainer(imagecontroller.isActive[2]),
                                    SizedBox(width: 5),
                                    buildContainer(imagecontroller.isActive[3]),
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
                                    color:
                                        HexColor(shoe.bgColor).withOpacity(0.2),
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
                                              color: controller.isActive[index]
                                                  ? HexColor("#FF8C00")
                                                  : Colors.grey),
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.shoeSize[index],
                                            style: TextStyle(
                                                color:
                                                    controller.isActive[index]
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
        ),
      ),
    );
  }

  FittedBox buildFittedBox() {
    return FittedBox(
      child: FloatingActionButton(
          onPressed: () {
            startFloatingButtonAnimation();
          },
          backgroundColor: Colors.black,
          child: Center(
            child: Icon(Icons.shopping_cart_outlined),
          )),
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
                ? AnimatedBuilder(
                    animation: shoeShrinkAnim,
                    builder: (BuildContext ctx, Widget? child) {
                      return Transform.translate(
                        offset: Offset(0, shoeShrinkAnim.value),
                        child: Image.asset(
                          shoe.images[index],
                          //  scale: 2.5,
                          width: 350,
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    },
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
