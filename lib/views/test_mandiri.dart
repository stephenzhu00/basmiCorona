import 'package:basmicorona/models/question_model.dart';
import 'package:basmicorona/views/results.dart';
import 'package:basmicorona/widgets/quiz.dart';
import 'package:basmicorona/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TestMandiriPage extends StatefulWidget {
  @override
  _TestMandiriPageState createState() => _TestMandiriPageState();
}

int total = 6;
int _answered = 0;
int _notAttempted = 6;

List<String> arrAnswer = new List(6);
List<QuestionModel> listQuestion = [
  new QuestionModel(
      question: "Apakah anda sedang merasakan demam?",
      option1: "iya",
      option2: "tidak",
      option3: "mungkin",
      answered: false),
  new QuestionModel(
      question: "Apakah anda sedang merasa batuk/pilek?",
      option1: "iya",
      option2: "tidak",
      option3: "mungkin",
      answered: false),
  new QuestionModel(
      question: "Apakah anda merasa kesulitan bernafas/sesak nafas?",
      option1: "iya",
      option2: "tidak",
      option3: "mungkin",
      answered: false),
  new QuestionModel(
      question: "Apakah anda mengalami nyeri tenggorokan?",
      option1: "iya",
      option2: "tidak",
      option3: "mungkin",
      answered: false),
  new QuestionModel(
      question:
          "Apakah anda memiliki riwayat kontak erat dengan penderita terkonfrimasi covid-19?",
      option1: "iya",
      option2: "tidak",
      option3: "mungkin",
      answered: false),
  new QuestionModel(
      question: "Apakah anda memiliki riwayat perjalanan ke zona merah?",
      option1: "iya",
      option2: "tidak",
      option3: "mungkin",
      answered: false),
];

class _TestMandiriPageState extends State<TestMandiriPage> {
  // QuestionModel getQuestionModelFromDataSnapShot(int index) {
  //   return listQuestion[index];
  // }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Pemberitahuan"),
      content: Text("Harap mengisi keseluruhan pertanyaan"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    total = 6;
    _notAttempted = 6;
    _answered = 0;
    listQuestion.elementAt(0).answered = false;
    listQuestion.elementAt(1).answered = false;
    listQuestion.elementAt(2).answered = false;
    listQuestion.elementAt(3).answered = false;
    listQuestion.elementAt(4).answered = false;
    listQuestion.elementAt(5).answered = false;
    arrAnswer = new List(6);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black54,
        ),
        brightness: Brightness.light,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return QuizPlayTile(
                    questionModel: listQuestion[index], index: index);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _answered != 6
              ? showAlertDialog(context)
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Results(
                            total: total,
                            answered: _answered,
                            arrAnswer: arrAnswer,
                          )));
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Q${widget.index + 1}: ${widget.questionModel.question}",
            style: TextStyle(fontSize: 17, color: Colors.black87),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                _notAttempted = _notAttempted - 1;
                setState(() {
                  _answered = _answered + 1;
                  arrAnswer[widget.index] = optionSelected;
                });
              }
            },
            child: OptionTile(
              description: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                optionSelected = widget.questionModel.option2;
                widget.questionModel.answered = true;
                _notAttempted = _notAttempted - 1;
                setState(() {
                  arrAnswer[widget.index] = optionSelected;
                  _answered = _answered + 1;
                });
              }
            },
            child: OptionTile(
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                _notAttempted = _notAttempted - 1;
                setState(() {
                  arrAnswer[widget.index] = optionSelected;
                  _answered = _answered + 1;
                });
              }
            },
            child: OptionTile(
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
