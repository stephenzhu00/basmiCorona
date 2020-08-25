import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, description, optionSelected;
  OptionTile(
      {@required this.optionSelected,
      @required this.description,
      @required this.option});
  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
                color: widget.optionSelected == widget.description
                    ? Colors.green.withOpacity(0.7)
                    : Colors.white,
                border: Border.all(
                    color: widget.optionSelected == widget.description
                        ? Colors.green.withOpacity(0.7)
                        : Colors.grey.withOpacity(0.7),
                    width: 1.5),
                borderRadius: BorderRadius.circular(30)),
            alignment: Alignment.center,
            child: Text(
              "${widget.option}",
              style: TextStyle(
                  color:
                      // widget.optionSelected == widget.description
                      //     ? Colors.green.withOpacity(0.7)
                      //     :
                      Colors.black),
            ),
          ),
          SizedBox(width: 8),
          Text(
            widget.description,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
