import 'package:flutter/material.dart';

// class AppLogo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       text: TextSpan(
//         style: TextStyle(fontSize: 22),
//         children: <TextSpan>[
//           TextSpan(
//               text: 'Basmi',
//               style: TextStyle(
//                   fontWeight: FontWeight.w600, color: Colors.black54)),
//           TextSpan(
//               text: 'Corona',
//               style:
//                   TextStyle(fontWeight: FontWeight.w600, color: Colors.blue)),
//         ],
//       ),
//     );
//   }
// }

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
            text: 'Basmi',
            style:
                TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
        TextSpan(
            text: 'Corona',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue)),
      ],
    ),
  );
}
