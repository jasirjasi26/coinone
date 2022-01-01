// To parse this JSON data, do
//
//     final coinone = coinoneFromJson(jsonString);

import 'dart:convert';

List<Coinone> coinoneFromJson(String str) => List<Coinone>.from(json.decode(str).map((x) => Coinone.fromJson(x)));

String coinoneToJson(List<Coinone> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Coinone {
  Coinone({
     this.chartData,
     this.freeTimeMaxUsage,
     this.deviceUsage,
  });

  ChartData chartData;
  int freeTimeMaxUsage;
  DeviceUsage deviceUsage;

  factory Coinone.fromJson(Map<String, dynamic> json) => Coinone(
    chartData: ChartData.fromJson(json["chartData"]),
    freeTimeMaxUsage: int.parse(json["freeTimeMaxUsage"] ) ,
    deviceUsage: DeviceUsage.fromJson(json["deviceUsage"]),
  );

  Map<String, dynamic> toJson() => {
    "chartData": chartData.toJson(),
    "freeTimeMaxUsage": freeTimeMaxUsage,
    "deviceUsage": deviceUsage.toJson(),
  };
}

class ChartData {
  ChartData({
     this.totalTime,
     this.studyTime,
    this.classTime,
     this.freeTime,
  });

  ChartDataClassTime totalTime;
  ChartDataClassTime studyTime;
  ChartDataClassTime classTime;
  ChartDataClassTime freeTime;

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
    totalTime: ChartDataClassTime.fromJson(json["totalTime"]),
    studyTime: ChartDataClassTime.fromJson(json["studyTime"]),
    classTime: ChartDataClassTime.fromJson(json["classTime"]),
    freeTime: ChartDataClassTime.fromJson(json["freeTime"]),
  );

  Map<String, dynamic> toJson() => {
    "totalTime": totalTime.toJson(),
    "studyTime": studyTime.toJson(),
    "classTime": classTime.toJson(),
    "freeTime": freeTime.toJson(),
  };
}

class ChartDataClassTime {
  ChartDataClassTime({
    this.total,
  });

  String total;

  factory ChartDataClassTime.fromJson(Map<String, dynamic> json) => ChartDataClassTime(
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
  };
}

class DeviceUsage {
  DeviceUsage({
    this.totalTime,
    this.studyTime,
    this.classTime,
    this.freeTime,
  });

  DeviceUsageClassTime totalTime;
  DeviceUsageClassTime studyTime;
  DeviceUsageClassTime classTime;
  DeviceUsageClassTime freeTime;

  factory DeviceUsage.fromJson(Map<String, dynamic> json) => DeviceUsage(
    totalTime: DeviceUsageClassTime.fromJson(json["totalTime"]),
    studyTime: DeviceUsageClassTime.fromJson(json["studyTime"]),
    classTime: DeviceUsageClassTime.fromJson(json["classTime"]),
    freeTime: DeviceUsageClassTime.fromJson(json["freeTime"]),
  );

  Map<String, dynamic> toJson() => {
    "totalTime": totalTime.toJson(),
    "studyTime": studyTime.toJson(),
    "classTime": classTime.toJson(),
    "freeTime": freeTime.toJson(),
  };
}

class DeviceUsageClassTime {
  DeviceUsageClassTime({
    this.mobile,
    this.laptop,
  });

  int mobile;
  int laptop;

  factory DeviceUsageClassTime.fromJson(Map<String, dynamic> json) => DeviceUsageClassTime(
    mobile: int.parse(json["mobile"]),
    laptop: int.parse(json["laptop"]),
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "laptop": laptop,
  };
}
