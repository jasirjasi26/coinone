import 'package:coinone/blocks/data_block.dart';
import 'package:coinone/models/coinone_data.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DataList extends StatefulWidget {
  const DataList({Key key}) : super(key: key);

  @override
  DataListState createState() => DataListState();
}

class DataListState extends State<DataList> {
  int key = 0;

  final dataMap = <String, double>{
    "Flutter": 80,
    "React": 20,
    "Xamarin": 30,
  };
  final colorList = <Color>[
    const Color(0xffe17055),
    const Color(0xff0984e3),
    const Color(0xfffdcb6e),
  ];

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
          child: Container(
            child: Image.asset(
              'assets/appbarround.png',
              height: 25,
            ),
          ),
        ),
        title: const Text(
          'Mickel',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 5,
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: Container(
              child: Image.asset(
                'assets/settings.png',
                height: 25,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const Center(
              child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              "Dashboard",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          )),
          Center(
            child: StreamBuilder(
              stream: bloc.allData,
              builder: (context, AsyncSnapshot<Coinone> snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot, context);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildList(AsyncSnapshot<Coinone> snapshot, BuildContext context) {
    return Column(
      children: [
        PieChart(
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: false,
            //showChartValuesInPercentage: _showChartValuesInPercentage,
            //showChartValuesOutside: _showChartValuesOutside,
          ),
          key: ValueKey(key),
          dataMap: <String, double>{
            "Study": double.parse(snapshot.data.chartData.studyTime.total),
            "Class": double.parse(snapshot.data.chartData.classTime.total),
            "Free": double.parse(snapshot.data.chartData.freeTime.total),
          },
          animationDuration: const Duration(milliseconds: 800),
          //chartLegendSpacing: _chartLegendSpacing,
          chartRadius: 150,
          centerText: "Total\n2h 40m",
          ringStrokeWidth: 10,
          legendOptions: const LegendOptions(
            showLegends: false,
            showLegendsInRow: false,
          ),
          centerTextStyle: const TextStyle(color: Colors.black, fontSize: 22),
          chartType: ChartType.ring,
          initialAngleInDegree: 0,
          emptyColor: Colors.grey,
          emptyColorGradient: const [
            Color(0xff6c5ce7),
            Colors.blue,
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    const Text("  Class"),
                  ],
                ),
                Text(snapshot.data.chartData.classTime.total.toString()),
              ],
            )),
            Container(
                child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    const Text("  Study"),
                  ],
                ),
                Text(snapshot.data.chartData.studyTime.total.toString()),
              ],
            )),
            Container(
                child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    const Text("  Free-time"),
                  ],
                ),
                Text(snapshot.data.chartData.freeTime.total.toString()),
              ],
            )),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Divider(thickness: 1),
        ),
        const Center(
            child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(
            "Free-time Usage",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        )),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "Used",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  snapshot.data.deviceUsage.freeTime.mobile.toString() + "m",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                )
              ],
            ),
            const SizedBox(
              width: 50,
            ),
            Column(
              children: [
                Text(
                  "Max",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  snapshot.data.freeTimeMaxUsage.toString() + "m",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 35,
          child: const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: LinearProgressIndicator(
              value: 0.3,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
              backgroundColor: Color(0xffD6D6D5),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 45,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/button_background.png',
                ),
                fit: BoxFit.fill,
              ),
              //shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "Extend Free-time",
                textAlign: TextAlign.left,
                // overflow: TextOverflow.ellipsis,
                // maxLines: 1,
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    //height: 1.6,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
        const Center(
          child: Text(
            "Change Time Restrictions",
            textAlign: TextAlign.left,
            // overflow: TextOverflow.ellipsis,
            // maxLines: 1,
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
                //height: 1.6,
                fontWeight: FontWeight.normal),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Divider(thickness: 1),
        ),
        const Center(
          child: Text(
            "By Devices",
            textAlign: TextAlign.left,
            // overflow: TextOverflow.ellipsis,
            // maxLines: 1,
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                //height: 1.6,
                fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              width: 70,
              height: 50,
              child: Center(
                child: Container(
                  width: 30,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/mobile.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                    //shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Adi's Phone",
                      textAlign: TextAlign.left,
                      // overflow: TextOverflow.ellipsis,
                      // maxLines: 1,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          //height: 1.6,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Center(
                    child: Text(
                      snapshot.data.deviceUsage.totalTime.mobile.toString() +
                          "m",
                      textAlign: TextAlign.left,
                      // overflow: TextOverflow.ellipsis,
                      // maxLines: 1,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                          //height: 1.6,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
              width: 70,
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/laptop.png',
                  ),
                  fit: BoxFit.fill,
                ),
                //shape: BoxShape.circle,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Adi's Laptop",
                      textAlign: TextAlign.left,
                      // overflow: TextOverflow.ellipsis,
                      // maxLines: 1,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          //height: 1.6,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Center(
                    child: Text(
                      snapshot.data.deviceUsage.totalTime.laptop.toString() +
                          "m",
                      textAlign: TextAlign.left,
                      // overflow: TextOverflow.ellipsis,
                      // maxLines: 1,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                          //height: 1.6,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            "See All Devices",
            textAlign: TextAlign.left,
            // overflow: TextOverflow.ellipsis,
            // maxLines: 1,
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
                //height: 1.6,
                fontWeight: FontWeight.normal),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
