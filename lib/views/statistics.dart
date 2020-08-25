import 'package:basmicorona/helper/consts.dart';
import 'package:basmicorona/helper/flutter_icons.dart';
import 'package:basmicorona/models/api_model.dart';
import 'package:basmicorona/services/api_services.dart';
import 'package:basmicorona/widgets/chart_widget.dart';
import 'package:basmicorona/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

final nf = NumberFormat("#,###");

class _StatisticPageState extends State<StatisticPage> {
  Future<DataModel> globalCase;
  Future<DetailCountry> indonesiaCase;
  Future<Province> provinceCase;
  Future<List<Province>> provinceList;
  int fidProvince;

  // Future<CountryList> indonesiaCase;
  // Future<GlobalPositive> globalPositive;
  // Future<GlobalRecovered> globalRecovered;
  // Future<GlobalDeath> globalDeath;

  @override
  void initState() {
    super.initState();
    globalCase = fetchDataModel();
    indonesiaCase = fetchIndonesiaData();
    provinceCase = fetchProvinceData();
    provinceList = fetchListProvince();
    fidProvince = 11;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 275,
              decoration: BoxDecoration(
                // color: AppColors.mainColor,
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.only(top: 25),
              child: Image.asset("assets/images/virus2.png"),
            ),
            Container(
              padding: EdgeInsets.only(top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomAppBarWidget(
                    iconText: "back",
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "STATISTIK INDONESIA",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  _buildStatistic(),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 2.0,
                      width: MediaQuery.of(context).size.width - 20,
                      color: Colors.black,
                    ),
                  ),
                  FutureBuilder<List<Province>>(
                    future: provinceList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Pilih Provinsi: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                DropdownButton(
                                  value: fidProvince,
                                  items: snapshot.data.map((value) {
                                    return DropdownMenuItem(
                                        child: Text(value.provinsi),
                                        value: value.fid);
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      fidProvince = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height: 2.0,
                                width: MediaQuery.of(context).size.width - 20,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 8),
                                  Text(
                                    "Kasus Corona",
                                    style: TextStyle(
                                      color: Colors.black,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    snapshot.data
                                        .elementAt(fidProvince - 1)
                                        .provinsi,
                                    style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(11),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: _buildReport(
                                        FlutterIcons.male,
                                        AppColors.txr,
                                        "POSITIF AKTIF",
                                        nf.format(snapshot.data
                                            .elementAt(fidProvince - 1)
                                            .positif)),
                                  ),
                                  SizedBox(width: 2),
                                  Expanded(
                                    child: _buildReport(
                                        FlutterIcons.male,
                                        AppColors.txb,
                                        "SEMBUH",
                                        nf.format(snapshot.data
                                            .elementAt(fidProvince - 1)
                                            .sembuh)),
                                  ),
                                  SizedBox(width: 2),
                                  Expanded(
                                    child: _buildReport(
                                        FlutterIcons.male,
                                        AppColors.txbl,
                                        "MENINGGAL",
                                        nf.format(snapshot.data
                                            .elementAt(fidProvince - 1)
                                            .meninggal)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 2.0,
                      width: MediaQuery.of(context).size.width - 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                      text: TextSpan(
                        text: "Kasus Global ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black87,
                        ),
                        children: [
                          TextSpan(
                            text: "COVID 19",
                            style: TextStyle(
                              color: AppColors.mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(11),
                    child: Row(
                      children: <Widget>[
                        FutureBuilder<DataModel>(
                          future: globalCase,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: _buildReport(
                                    FlutterIcons.male,
                                    AppColors.txr,
                                    "POSITIF AKTIF",
                                    nf.format(snapshot.data.confirmed.value)),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                        SizedBox(width: 2),
                        FutureBuilder<DataModel>(
                          future: globalCase,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: _buildReport(
                                    FlutterIcons.male,
                                    AppColors.txb,
                                    "SEMBUH",
                                    nf.format(snapshot.data.recovered.value)),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                        SizedBox(width: 2),
                        FutureBuilder<DataModel>(
                          future: globalCase,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: _buildReport(
                                    FlutterIcons.male,
                                    AppColors.txbl,
                                    "MENINGGAL",
                                    nf.format(snapshot.data.deaths.value)),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: <Widget>[
                        FutureBuilder<DataModel>(
                          future: globalCase,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: _buildGender(FlutterIcons.male,
                                    Colors.orangeAccent, "PRIA", "59.5%"),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                        SizedBox(width: 16),
                        FutureBuilder<DataModel>(
                          future: globalCase,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: _buildGender(FlutterIcons.female,
                                    Colors.pinkAccent, "WANITA", "40.5%"),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      height: 170,
                      child:
                          Center(child: Image.asset("assets/images/map.png")),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGender(IconData icon, Color color, String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                size: 60,
                color: color,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Kasus\nTerkonfirmasi",
                    style: TextStyle(
                      color: Colors.black38,
                      height: 1.5,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatistic() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(24),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FutureBuilder<DataModel>(
              future: globalCase,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 150,
                        child: DonutPieChart.withSampleData(),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
            // Container(
            //   width: 150,
            //   height: 150,
            //   child: DonutPieChart.withSampleData(),
            // ),
            SizedBox(width: 25),
            FutureBuilder<DetailCountry>(
              future: indonesiaCase,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildStatisticItem(AppColors.txr, "Positif",
                          nf.format(snapshot.data.confirmed.value)),
                      _buildStatisticItem(AppColors.txb, "Sembuh",
                          nf.format(snapshot.data.recovered.value)),
                      _buildStatisticItem(AppColors.txbl, "Meninggal",
                          nf.format(snapshot.data.deaths.value)),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem(Color color, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Icon(
          FlutterIcons.label,
          size: 50,
          color: color,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
            SizedBox(height: 5),
            Text(value),
          ],
        ),
      ],
    );
  }

  Widget _buildReport(IconData icon, Color color, String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 45,
            color: color,
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          //   ],
          // ),
          SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}
