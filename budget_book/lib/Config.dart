import 'package:flutter/material.dart';

class Config {

  static const String APP_NAME = "BudgetP";
  static const String VERSION = "1.0.0";
  static const String APP_ICON = "assets/images/appIcon_round.png";
  static const String APP_LEGALESE = "";
  static const String BUDGET_P_WEBSITE = "https://kellojo.github.io/Budget-Book/";
  static const String SUPPORT_EMAIL = "kellojo1@gmail.com";


static const int MIN_PASSWORD_LENGTH = 6;

  static const String TRANSACTION_TYPE_EXPENSE = "expense";
  static const String TRANSACTION_TYPE_INCOME = "income";

  static const String DEFAULT_CURRENCY = "EUR";
  static const String DEFAULT_CURRENCY_SYMBOL = "€";

  static const Color MainBrandColor = Color(0xff514a9d);
  static const Color SecondaryBrandColor = Color(0xff005575);

  static const LinearGradient BrandGradient = LinearGradient(
    colors: [MainBrandColor, SecondaryBrandColor],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient BrandGradientInverted = LinearGradient(
    colors: [SecondaryBrandColor, MainBrandColor],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

final Config config = Config();