import 'package:flutter/material.dart';

import '../constants/colors.dart';

Widget textField(
        {double width = 250.0,
        double height = 90.0,
        TextInputType textType = TextInputType.emailAddress,
        TextEditingController? textFormController,
        Color fillColor = const Color.fromARGB(38, 255, 164, 89),
        double textSize = 20.0,
        String hintText = '',
        Color hintColor = AppColors.lightGrey,
        double hintSize = 20.0,
        int maxLetters = 11,
        bool needMax = false,
        bool needSuffix = false,
        IconData iconLead = Icons.add,
        IconData iconSuffix = Icons.add,
        Color iconColor = AppColors.orange,
        double iconSize = 35.0,
        String labelText = '',
        Color labelColor = AppColors.orange,
        double labelSize = 20.0,
        int inputLength = 8,
        bool isPassword = false,
        int minlines = 1,
        int maxlines = 1,
        Function()? function,
        Function()? onTapFunction,
        Function(String?)? onSave,
        Function(String)? onChangeFunction,
        Function()? validateFunction,
        Function(String)? onSubmit,
        dynamic focusNode,
        bool readOnly = false,
        bool isLength = false,
        bool isRegex = false,
        bool isMatch = false,
        FloatingLabelBehavior labelFloating = FloatingLabelBehavior.auto,
        String passwordNotBigText = 'Password must be 8 characters or more',
        String passwordNotMatchText = 'Passwords not match each other',
        String passwordRegexText =
            'Password must contains big letter and symbols',
        String? matchPassword = '',
        String? thisPasssword = '',
        String validatText = "This field can't be empty",
        String helperText = ''}) =>
    SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTapFunction,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onFieldSubmitted: onSubmit,
        onChanged: onChangeFunction,
        onSaved: onSave,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatText;
          } else if (isLength == true && value.length < inputLength) {
            return passwordNotBigText;
          } else if (isRegex == true && !validatePassword(value)) {
            return passwordRegexText;
          } else if (isMatch == true && thisPasssword != matchPassword) {
            return passwordNotMatchText;
          }
          return null;
        },
        focusNode: focusNode,
        keyboardType: textType,
        obscureText: isPassword,
        controller: textFormController,
        cursorColor: AppColors.orange,
        minLines: minlines,
        maxLines: maxlines,
        style: TextStyle(
          fontSize: textSize,
        ),
        maxLength: needMax == true ? maxLetters : null,
        decoration: InputDecoration(
          floatingLabelBehavior: labelFloating,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: AppColors.orange,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          suffixIcon: needSuffix == true
              ? IconButton(
                  icon: Icon(
                    iconSuffix,
                    color: iconColor,
                    size: 28,
                  ),
                  onPressed: function,
                )
              : null,
          filled: true,
          fillColor: fillColor,
          prefixIcon: Icon(
            iconLead,
            color: iconColor,
            size: iconSize,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: hintSize,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelColor,
            fontSize: labelSize,
          ),
          helperText: helperText,
        ),
      ),
    );

bool validatePassword(String password) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(password);
}
