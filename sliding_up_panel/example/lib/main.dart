/*
Name: Akshath Jain
Date: 3/18/2019 - 1/25/2020
Purpose: Example app that implements the package: sliding_up_panel
Copyright: © 2020, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



void main() => runApp(SlidingUpPanelExample());

class SlidingUpPanelExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[200],
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.black,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SlidingUpPanel Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 95.0;

  @override
  void initState(){
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context){
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
//          SlidingUpPanel(
//            maxHeight: _panelHeightOpen,
//            minHeight: _panelHeightClosed,
//            parallaxEnabled: true,
//            parallaxOffset: .5,
//            body: Container(),
//            panelBuilder: (sc) => _panel(sc),
//            borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
//            onPanelSlide: (double pos) => setState((){
//              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
//            }),
//          ),

          // the fab
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.gps_fixed,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: (){},
              backgroundColor: Colors.white,
            ),
          ),

          Positioned(
            top: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).padding.top,
                  color: Colors.transparent,
                )
              )
            )
          ),

          //the SlidingUpPanel Title
          Positioned(
            top: 52.0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
              child: Text(
                "SlidingUpPanel Example",
                style: TextStyle(
                  fontWeight: FontWeight.w500
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, .25),
                  blurRadius: 16.0
                )],
              ),
            ),
          ),


        ],
      ),
    );
  }

  Widget _panel(ScrollController sc){
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(height: 12.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
              ),
            ],
          ),

          SizedBox(height: 18.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Explore Pittsburgh",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),

          SizedBox(height: 36.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _button("Popular", Icons.favorite, Colors.blue),
              _button("Food", Icons.restaurant, Colors.red),
              _button("Events", Icons.event, Colors.amber),
              _button("More", Icons.more_horiz, Colors.green),
            ],
          ),

          SizedBox(height: 36.0,),

          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text("Images", style: TextStyle(fontWeight: FontWeight.w600,)),

                SizedBox(height: 12.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

//                      CachedNetworkImage(
//                        imageUrl: "https://images.fineartamerica.com/images-medium-large-5/new-pittsburgh-emmanuel-panagiotakis.jpg",
//                        height: 120.0,
//                        width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
//                        fit: BoxFit.cover,
//                      ),
//
//                      CachedNetworkImage(
//                        imageUrl: "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
//                        width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
//                        height: 120.0,
//                        fit: BoxFit.cover,
//                      ),

                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 36.0,),

          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("About", style: TextStyle(fontWeight: FontWeight.w600,)),

                SizedBox(height: 12.0,),

                Text(
                  """Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county seat of Allegheny County. A population of about 302,407 (2018) residents live within the city limits, making it the 66th-largest city in the U.S. The metropolitan population of 2,324,743 is the largest in both the Ohio Valley and Appalachia, the second-largest in Pennsylvania (behind Philadelphia), and the 27th-largest in the U.S.\n\nPittsburgh is located in the southwest of the state, at the confluence of the Allegheny, Monongahela, and Ohio rivers. Pittsburgh is known both as "the Steel City" for its more than 300 steel-related businesses and as the "City of Bridges" for its 446 bridges. The city features 30 skyscrapers, two inclined railways, a pre-revolutionary fortification and the Point State Park at the confluence of the rivers. The city developed as a vital link of the Atlantic coast and Midwest, as the mineral-rich Allegheny Mountains made the area coveted by the French and British empires, Virginians, Whiskey Rebels, and Civil War raiders.\n\nAside from steel, Pittsburgh has led in manufacturing of aluminum, glass, shipbuilding, petroleum, foods, sports, transportation, computing, autos, and electronics. For part of the 20th century, Pittsburgh was behind only New York City and Chicago in corporate headquarters employment; it had the most U.S. stockholders per capita. Deindustrialization in the 1970s and 80s laid off area blue-collar workers as steel and other heavy industries declined, and thousands of downtown white-collar workers also lost jobs when several Pittsburgh-based companies moved out. The population dropped from a peak of 675,000 in 1950 to 370,000 in 1990. However, this rich industrial history left the area with renowned museums, medical centers, parks, research centers, and a diverse cultural district.\n\nAfter the deindustrialization of the mid-20th century, Pittsburgh has transformed into a hub for the health care, education, and technology industries. Pittsburgh is a leader in the health care sector as the home to large medical providers such as University of Pittsburgh Medical Center (UPMC). The area is home to 68 colleges and universities, including research and development leaders Carnegie Mellon University and the University of Pittsburgh. Google, Apple Inc., Bosch, Facebook, Uber, Nokia, Autodesk, Amazon, Microsoft and IBM are among 1,600 technology firms generating \$20.7 billion in annual Pittsburgh payrolls. The area has served as the long-time federal agency headquarters for cyber defense, software engineering, robotics, energy research and the nuclear navy. The nation's eighth-largest bank, eight Fortune 500 companies, and six of the top 300 U.S. law firms make their global headquarters in the area, while RAND Corporation (RAND), BNY Mellon, Nova, FedEx, Bayer, and the National Institute for Occupational Safety and Health (NIOSH) have regional bases that helped Pittsburgh become the sixth-best area for U.S. job growth.
                  """,
                  softWrap: true,
                ),
              ],
            ),
          ),

          SizedBox(height: 24,),
        ],
      )
    );
  }

  Widget _button(String label, IconData icon, Color color){
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )]
          ),
        ),

        SizedBox(height: 12.0,),

        Text(label),
      ],

    );
  }

//  Widget _body(){
//    return FlutterMap(
//      options: MapOptions(
//        center: LatLng(40.441589, -80.010948),
//        zoom: 13,
//        maxZoom: 15,
//      ),
//      layers: [
//        TileLayerOptions(
//          urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"
//        ),
//
//        MarkerLayerOptions(
//          markers: [
//            Marker(
//              point: LatLng(40.441753, -80.011476),
//              builder: (ctx) => Icon(
//                Icons.location_on,
//                color: Colors.blue,
//                size: 48.0,
//              ),
//              height: 60
//            ),
//          ]
//        ),
//      ],
//    );
//  }
}
