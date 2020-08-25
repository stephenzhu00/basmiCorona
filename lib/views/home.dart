import 'dart:ui';
import 'package:basmicorona/helper/consts.dart';
import 'package:basmicorona/models/api_model.dart';
import 'package:basmicorona/services/api_services.dart';
import 'package:basmicorona/views/news.dart';
import 'package:basmicorona/views/statistics.dart';
import 'package:basmicorona/views/test_mandiri.dart';
import 'package:basmicorona/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<GlobalPositive> futureGlobalPositive;
  Future<DataModel> futureHome;

  @override
  void initState() {
    super.initState();
    // futureGlobalPositive = fetchGlobalPositive();
    futureHome = fetchDataModel();
  }

  @override
  Widget build(BuildContext context) {
    final nf = NumberFormat("#,###");
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                // color: AppColors.mainColor,
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.only(top: 25, bottom: 30),
              child: Stack(
                children: <Widget>[
                  Image.asset("assets/images/virus2.png"),
                  _buildHeader(),
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                text: TextSpan(
                  text: "Gejala ",
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
            SizedBox(height: 25),
            Container(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16),
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  _buildSymptomItem("assets/images/1.png", "Demam"),
                  _buildSymptomItem("assets/images/2.png", "Batuk Kering"),
                  _buildSymptomItem("assets/images/3.png", "Sakit Kepala"),
                  _buildSymptomItem("assets/images/4.png", "Sesak Nafas"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Cara Mencegah",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16),
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  _buildPrevention("assets/images/a10.png", "CUCI TANGAN",
                      "setiap 15 menit"),
                  _buildPrevention(
                      "assets/images/a4.png", "TUTUP MULUT", "saat batuk"),
                  _buildPrevention(
                      "assets/images/a6.png", "BERSIHKAN", "rumah berkala"),
                  _buildPrevention(
                      "assets/images/a9.png", "PAKAI MASKER", "yang benar"),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StatisticPage(),
                  ),
                );
              },
              child: Container(
                height: 90,
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
                    )
                  ],
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/map.png"),
                    SizedBox(width: 25),
                    FutureBuilder<DataModel>(
                      future: futureHome,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return RichText(
                            text: TextSpan(
                              text: "Kasus\n",
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                              children: [
                                TextSpan(
                                  text: "Seluruh Dunia\n",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      nf.format(snapshot.data.confirmed.value),
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          );
                          // return Text(snapshot.data.value);
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                    Expanded(child: SizedBox()),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: null,
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPrevention(String path, String text1, String text2) {
    return Column(
      children: <Widget>[
        Container(
          width: 185,
          height: 80,
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
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Image.asset(path),
              SizedBox(width: 10),
              RichText(
                text: TextSpan(
                    text: "$text1\n",
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: text2,
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ]),
              )
            ],
          ),
          margin: EdgeInsets.only(right: 20),
        ),
        SizedBox(height: 7),
      ],
    );
  }

  Widget _buildSymptomItem(String path, String text) {
    return Column(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            gradient: LinearGradient(
              colors: [
                AppColors.backgroundColor,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 3,
              )
            ],
          ),
          padding: EdgeInsets.only(top: 15),
          child: Image.asset(path),
          margin: EdgeInsets.only(right: 20),
        ),
        SizedBox(height: 7),
        Text(
          text,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomAppBarWidget(
          iconText: "exit",
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Basmi Corona",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
        SizedBox(height: 25),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Virus Corona (Covid-19)",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Virus Corona adalah sebuah keluarga virus yang ditemukan pada manusia dan hewan. Virus ini dapat menular melalui droplet.",
            style: TextStyle(
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 25),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => new TestMandiriPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1, 1),
                        spreadRadius: 1,
                        blurRadius: 3,
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * .42,
                  height: 60,
                  child: Center(
                    child: Text(
                      "Test Mandiri",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => NewsListPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1, 1),
                        spreadRadius: 1,
                        blurRadius: 3,
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * .42,
                  height: 60,
                  child: Center(
                    child: Text(
                      "Berita Terbaru",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
