import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  final int answered, total;
  final List<String> arrAnswer;
  Results(
      {@required this.answered,
      @required this.total,
      @required this.arrAnswer});
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  // 0 = biasa saja , jaga kebugaran
  // 1 = pergi ke dokter
  // 2 = karantina mandiri
  // 3 = wajib rapid test
  int status_code;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.arrAnswer.elementAt(4) == "iya" ||
        widget.arrAnswer.elementAt(5) == "iya") {
      if (widget.arrAnswer.elementAt(0) == "iya" ||
          widget.arrAnswer.elementAt(1) == "iya" ||
          widget.arrAnswer.elementAt(2) == "iya" ||
          widget.arrAnswer.elementAt(3) == "iya") {
        status_code = 3;
      } else {
        status_code = 2;
      }
    } else {
      if (widget.arrAnswer.elementAt(0) == "iya" ||
          widget.arrAnswer.elementAt(1) == "iya" ||
          widget.arrAnswer.elementAt(2) == "iya" ||
          widget.arrAnswer.elementAt(3) == "iya") {
        status_code = 1;
      } else {
        status_code = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.width * .42),
              Text(
                "${widget.answered}/${widget.total}",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 12),
              Text(
                "Kamu menjawab ${widget.answered} pertanyaan dari ${widget.total} pertanyaan",
                style: TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * .1),
              Text(
                "Result",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * .05),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.7), width: 1.5),
                    borderRadius: BorderRadius.circular(30)),
                alignment: Alignment.center,
                child: Text(
                  status_code == 0
                      ? "Anda dalam keadaan sehat, jaga kondisi tubuh anda tetap fit dan tetap di rumah"
                      : status_code == 1
                          ? "Silahkan anda pergi ke dokter untuk mengobati penyakit anda"
                          : status_code == 2
                              ? "Anda wajib melakukan karantina mandiri dan waspadai apabila dalam 14 hari gejala batuk dan demam muncul"
                              : "Silahkan anda pergi ke rumah sakit/puskesmas terdekat, lakukan rapid test dan tidak keluar rumah",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  height: 50,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * .55,
                  child: Text(
                    "Back to Main menu",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
