import 'package:flutter/material.dart';
class UtilityClass
{
 void onLoading(var context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
          child:  
            new LinearProgressIndicator(backgroundColor: Color.fromRGBO(74, 186, 173, 0.3),
            //strokeWidth: 6,
            valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(74, 186, 173, 1))),
      );  
    },
  );
}
}
