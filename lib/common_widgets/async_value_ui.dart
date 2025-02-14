import 'package:donatelife/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  /// Show a snackbar for errors if [AsyncValue] is in an error state
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      if (ModalRoute.of(context)?.isCurrent == false) {
        return;
      }
      final message = _errorMessage(error);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          icon: const Icon(
            Icons.error,
            color: Color(0xFF680c07),
            size: 40,
          ),
          title: Text(
            message,
            style: TextStyle(
              fontSize: SizeConfig.getProportionteHeight(15),
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF680c07)
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, 
                  child:  Text('Close',style: TextStyle(
              fontSize: SizeConfig.getProportionteHeight(15),
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),))
              ],
            )
          ],
        ),
      );
    }
  }

}
String _errorMessage(Object? error){
  if(error is FirebaseAuthException){
    return error.message ?? error.toString();
  }else{
    return error.toString();
  }
}
