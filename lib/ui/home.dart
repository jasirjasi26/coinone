import 'package:coinone/blocks/data_block.dart';
import 'package:coinone/models/coinone_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int key = 0;

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padRight(2, 'h')} ${parts[1].padLeft(2, '0')}';
  }


  @override
  Widget build(BuildContext context) {
    ///Fetch all informations
    ///
    bloc.fetchAllData();
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        children: [
          StreamBuilder(
                  stream: bloc.allData,
                  builder: (context, AsyncSnapshot<Coinone> snapshot) {
                    if (snapshot.hasData) {
                      return buildData(snapshot, context);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
        ],
      ),
    );
  }

  ///AppBar
  ///
  buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
        child: Image.asset(
          'assets/appbarround.png',
          height: 25,
        ),
      ),
      title: const Text(
        'John',
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      ),
      elevation: 5,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: Image.asset(
            'assets/settings.png',
            height: 25,
          ),
        ),
      ],
    );
  }

  Widget buildData(AsyncSnapshot<Coinone> snapshot, BuildContext context) {
    return Column(
      children: [
        const Center(
            child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Text(
            "Dashboard",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        )),

        ///piChart widget
        ///
        buildPiChart(snapshot, context),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Divider(thickness: 0.5),
        ),
        ///ProgressBar
        ///widget
        buildProgressBar(snapshot, context),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Divider(thickness: 0.5),
        ),
        const Center(
          child: Text(
            "By Devices",
            textAlign: TextAlign.left,
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
            Column(
              children: [
                const Center(
                  child: Text(
                    "Adi's Phone",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        //height: 1.6,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Center(
                  child: Text(
                    durationToString(
                            snapshot.data.deviceUsage.totalTime.mobile).replaceAll("0h", "") +
                        "m",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        //height: 1.6,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              width: 70,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/laptop.png',
                  ),
                  fit: BoxFit.fill,
                ),
                //shape: BoxShape.circle,
              ),
            ),
            Column(
              children: [
                const Center(
                  child: Text(
                    "Adi's Laptop",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        //height: 1.6,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Center(
                  child: Text(
                    durationToString(
                            snapshot.data.deviceUsage.totalTime.laptop).replaceAll("0h", "") +
                        "m",
                    textAlign: TextAlign.left,
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 1,
                    style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        //height: 1.6,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
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


 Widget buildPiChart(AsyncSnapshot<Coinone> snapshot, BuildContext context) {
    return Column(
      children: [
        PieChart(
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: false,
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
          centerText: "Total\n"+durationToString(int.parse(snapshot.data.chartData.totalTime.total))+"m",
          ringStrokeWidth: 8,
          legendOptions: const LegendOptions(
            showLegends: false,
            showLegendsInRow: false,
          ),
          centerTextStyle: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
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
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: const Color(0xff0984e3),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    const Text("  Class"),
                  ],
                ),
                Text("     "+durationToString(
                    int.parse(snapshot.data.chartData.classTime.total)).replaceAll("0h", "")+"m",style: const TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: const Color(0xffe17055),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        const Text("  Study"),
                      ],
                    ),
                    Text("      "+durationToString(
                        int.parse(snapshot.data.chartData.studyTime.total)).replaceAll("0h", "")+"m",style: const TextStyle(fontWeight: FontWeight.bold),),
                  ],
                )),
            Column(
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
                Text("    "+durationToString(
                    int.parse(snapshot.data.chartData.freeTime.total)).replaceAll("0h", "")+"m",style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          ],
        ),
      ],
    );
  }


 Widget buildProgressBar(AsyncSnapshot<Coinone> snapshot, BuildContext context){
    return Column(
      children: [
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
                const Text(
                  "Used",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  durationToString(snapshot.data.deviceUsage.freeTime.mobile).replaceAll("0h", "") +
                      "m",
                  style: const TextStyle(
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
                const Text(
                  "Max",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  durationToString(snapshot.data.freeTimeMaxUsage) + "m",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width * 0.85,
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
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            width: MediaQuery.of(context).size.width * 0.85,
            height: 45,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/button_background.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: const Center(
              child: Text(
                "Extend Free-time",
                textAlign: TextAlign.left,
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
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
                //height: 1.6,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
