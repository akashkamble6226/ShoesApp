import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shoesapp/widgets/single_shoe.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: HexColor('#ffffff'),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                children: [
                  MenuBar(),
                  SizedBox(
                    height: 25,
                  ),
                  SearchBar(deviceWidth: deviceWidth),
                  SizedBox(
                    height: 20,
                  ),
                  SingleShoe(deviceWidth: deviceWidth)
                ],
              )),
        ));
  }
}



class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.deviceWidth,
  }) : super(key: key);

  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  icon: FaIcon(
                    FontAwesomeIcons.search,
                    size: 15,
                    color: HexColor('#A3A3A3'),
                  ),
                ),
                Text(
                  'Search items',
                  style: TextStyle(color: HexColor('#A3A3A3')),
                ),
              ],
            ),
          ),
        )
      ],
    );
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
          icon: FaIcon(
            FontAwesomeIcons.stream,
            color: HexColor('#A3A3A3'),
            size: 18,
          ),
        ),
        Spacer(),
        Text(
          'New Arrival',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: FaIcon(
            FontAwesomeIcons.filter,
            color: HexColor('#A3A3A3'),
            size: 18,
          ),
        ),
      ],
    );
  }
}


// create class
// create dummy data
// create list view