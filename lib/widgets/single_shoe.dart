import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class SingleShoe extends StatelessWidget {
  const SingleShoe({
    Key? key,
    required this.deviceWidth,
  }) : super(key: key);

  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: deviceWidth,
          decoration: BoxDecoration(
              color: HexColor('#7AD7F0').withOpacity(0.2),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment(0.0, 0.0),
                    child: Transform.rotate(
                      angle: 50,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: HexColor('#7AD7F0').withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 25,
                    child: Container(
                      child: Center(
                        child: Image.asset(
                          'assets/black1.png',
                          width: 250,
                          height: 200,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text('Women Running Shoes'),
                    Row(
                      children: [
                        Text(
                          'React Escape Run',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor('#ffffff').withOpacity(0.3),
                            ),
                            child: Center(
                                child: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.shoppingCart,
                                size: 15,
                                color: HexColor('#A3A3A3'),
                              ),
                              onPressed: () {},
                            )),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '₹ 135',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#7AD7F0')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}