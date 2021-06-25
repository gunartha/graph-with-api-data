import 'package:flutter/material.dart';
import 'package:fungsi_tanggal/ahlStatusController.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph Data API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Graph Data API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StatusFileController _controller = Get.put(StatusFileController());

  @override
  Widget build(BuildContext context) {
    List food = [];
    String _status;
    int _frekuensi;

    for (var i = 0; i < _controller.dataFrekuansi.value.data.length; i++) {
      _status = _controller.dataFrekuansi.value.data[i].ahlStatus;

      _frekuensi = int.parse(_controller.dataFrekuansi.value.data[i].jml);

      food = [
        Sales(_status, _frekuensi),
      ];
    }

    var series = [
      charts.Series(
        domainFn: (Sales sales, _) => sales.day,
        measureFn: (Sales sales, _) => sales.sold,
        id: 'Penjualan',
        data: food,
        labelAccessorFn: (Sales sales, _) =>
            '${sales.day} : ${sales.sold.toString()}',
      ),
    ];

    var chart = charts.BarChart(
      series,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Data Compare",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 350, child: chart),
          ],
        ),
      ),
    );
  }
}

class Sales {
  final String day;
  final int sold;

  Sales(this.day, this.sold);
}
