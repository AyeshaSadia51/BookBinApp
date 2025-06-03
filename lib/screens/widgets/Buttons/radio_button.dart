import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RadioButton extends StatelessWidget {
  final String nameOption1;
  final String nameOption2;

  RadioButton({super.key,
    required this.nameOption1,
    required this.nameOption2,
  });

  final RadioButtonController radioButtonController = Get.put(RadioButtonController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio<String>(
            value: nameOption1,
            groupValue: radioButtonController.selectedOption.value,
            onChanged: (value) {
              radioButtonController.updateSelection(value!);
            },
          ),
          Text(nameOption1, style: TextStyle(fontSize: 18.sp),),
          SizedBox(width: 20.w),
          Radio<String>(
            value: nameOption2,
            groupValue: radioButtonController.selectedOption.value,
            onChanged: (value) {
              radioButtonController.updateSelection(value!);
            },
          ),
          Text(nameOption2, style: TextStyle(fontSize: 18.sp),),
        ],
      );
    });
  }
}


class RadioButtonController extends GetxController{
  var selectedOption = ''.obs;

  void updateSelection(String value) {
    selectedOption.value = value;
  }

}