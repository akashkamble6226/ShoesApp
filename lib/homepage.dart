import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: HexColor('#ffffff'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Column(
              children: [
                MenuBar(),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: deviceWidth,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor('#A3A3A3').withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: FaIcon(FontAwesomeIcons.search,size:15,color: HexColor('#A3A3A3'),),
                            ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            Text('Search items',style: TextStyle(color: HexColor('#A3A3A3')),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class MenuBar extends StatelessWidget {
  const MenuBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.stream),
        ),
        Spacer(),
        Text(
          'New Arrival',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.filter),
        ),
      ],
    );
  }
}
