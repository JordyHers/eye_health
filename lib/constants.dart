import 'package:flutter/material.dart';
import 'package:eye_test/size_config.dart';

const kPrimaryColor = Color(0xFF66BB6A);
const kPrimaryLightColor = Color(0xFF98EE99);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF66BB6A), Color(0xFF338a3e)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Lütfen Email Giriniz";
const String kInvalidEmailError = "Lütfen Email Doğrulayınız";
const String kPassNullError = "Lütfen Parola Giriniz";
const String kShortPassError = "Parolanız Kısa";
const String kMatchPassError = "Parolanız Eşleşmiyor";
const String kNamelNullError = "Lütfen İsminizi Girin";
const String kPhoneNumberNullError = "Lütfen Telefon Numaranızı Girin";
const String kAddressNullError = "Lütfen Adres Bilginizi Girin";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
