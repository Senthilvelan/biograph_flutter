import 'package:flutter/material.dart';

import 'loaders/color_loader.dart';

Widget appLoader() {
  return ColorLoader(
    dotOneColor: bottomRightGradientColor,
    dotTwoColor: blueColor,
    dotThreeColor: bottomRightGradientColor,
    dotType: DotType.icon,
  );
}

abstract class CategoryColor {
  /*['athlete',
 'challenger',
 'champion',
 'goat',
 'olympian',
 'pro_athlete',
 'rookie']*/

  static const ROOKIE_ORANGE_1 = "Rookie";
  static const CHALLENGER_RED_2 = "Challenger";
  static const ATHLETE_PINK_3 = "Athlete";
  static const PROATHLETE_BLUE_4 = "Pro Athlete";
  static const CHAMPION_GREEN_5 = "Champion";
  static const LEGEND_PURPLE_6 = "Olympian";
  static const GOAT_GOLD_7 = "GOAT";

// static num per1Rookie = 0;
// static num per2Chal = 0;
// static num per3Athe = 0;
// static num per4Pro = 0;
// static num per5Champ = 0;
// static num per6Legend = 0;
// static num per7Goat = 0;
}

class SetCategoryColor {
  static String _selectedCategory = "";

  static Future<void> setCategoryColor(String category) async {
    // String category = App.playerData.category;
    if (_selectedCategory == category) {
      return;
    }
    _selectedCategory = category;
    print("category- $category");
    if (category != null) {
      switch (category) {
        case CategoryColor.ROOKIE_ORANGE_1:
          setThemeRookie1();
          break;

        case CategoryColor.CHALLENGER_RED_2:
          setThemeChanlengerRed();
          break;

        case CategoryColor.ATHLETE_PINK_3:
          setThemeAtheletePink();
          break;

        case CategoryColor.PROATHLETE_BLUE_4:
          setThemeProAtheleteBlue();
          break;

        case CategoryColor.CHAMPION_GREEN_5:
          setThemeChampGreen();
          break;

        case CategoryColor.LEGEND_PURPLE_6:
          setThemeLegendPurple();
          break;

        case CategoryColor.GOAT_GOLD_7:
          setThemeGoldGoat();
          break;
      }
    }
  }

  static getPreviousCategory(category) {
    // String category = App.playerData.category;

    if (category != null) {}
  }

  static getOneStepDownCategory(category) {
    // String category = App.playerData.category;

    if (category != null) {
      switch (category) {
        case CategoryColor.ROOKIE_ORANGE_1:
          return CategoryColor.ROOKIE_ORANGE_1;
          break;
        case CategoryColor.CHALLENGER_RED_2:
          return CategoryColor.ROOKIE_ORANGE_1;
          break;

        case CategoryColor.ATHLETE_PINK_3:
          return CategoryColor.CHALLENGER_RED_2;
          break;

        case CategoryColor.PROATHLETE_BLUE_4:
          return CategoryColor.ATHLETE_PINK_3;
          break;

        case CategoryColor.CHAMPION_GREEN_5:
          return CategoryColor.PROATHLETE_BLUE_4;
          break;

        case CategoryColor.LEGEND_PURPLE_6:
          return CategoryColor.CHAMPION_GREEN_5;
          break;

        case CategoryColor.GOAT_GOLD_7:
          return CategoryColor.LEGEND_PURPLE_6;
          break;
      }
    }
  }

  //1 is default
  static void setThemeRookie1() {
    categoryColor = rookieColor;
    categoryColor20Trans = rookie20Color;
    catImage = catImageRookie;
    catImage3D = catImageRookie3d;

    previousImage = catImageRookie;
    nextImage = catImageRookie3d;

    previousColor = rookieColor;
    previous20Color = rookie20Color;

    nextColor = challengerColor;
    next20Color = challenger20Color;
    categoryGradient = rookieGradient;
  }

  //2. THEME FOR RED
  static void setThemeChanlengerRed() {
    // categoryColor = challengerColor;
    categoryColor = Color(0xffDF742C);
    categoryColor20Trans = Color(0x30DF742C);
    catImage = catImageChallenger;
    catImage3D = catImage3DChaller;

    previousImage = catImageRookie3d;
    nextImage = catImage3DAthelete;

    previousColor = rookieColor;
    previous20Color = rookie20Color;

    nextColor = athleteColor;
    next20Color = athlete20Color;
    categoryGradient = challengerGradient;
  }

  //3. THEME FOR PINK
  static void setThemeAtheletePink() {
    categoryColor = Color(0xffDA4C66);
    categoryColor20Trans = Color(0x30DA4C66);
    catImage = catImageAthelete;
    catImage3D = catImage3DAthelete;
    previousImage = catImage3DChaller;
    nextImage = catImage3DProAthelete;

    previousColor = challengerColor;
    previous20Color = challenger20Color;

    nextColor = proAthleteColor;
    next20Color = proAthlete20Color;
    categoryGradient = athleteGradient;
  }

  //4. THEME FOR Blue
  static void setThemeProAtheleteBlue() {
    categoryColor = Color(0xff2C8BE8);
    categoryColor20Trans = Color(0x302C8BE8);
    catImage = catImageProAthelete;
    catImage3D = catImage3DProAthelete;
    previousImage = catImage3DAthelete;
    nextImage = catImage3DChamp;

    previousColor = athleteColor;
    previous20Color = athlete20Color;

    nextColor = championColor;
    next20Color = champion20Color;
    categoryGradient = proAthleteGradient;
  }

  //5. THEME FOR green
  static void setThemeChampGreen() {
    categoryColor = Color(0xff189944);
    categoryColor20Trans = Color(0x30189944);
    catImage = catImageChamp;
    catImage3D = catImage3DChamp;
    previousImage = catImage3DProAthelete;
    nextImage = catImage3DLegend;

    previousColor = proAthleteColor;
    previous20Color = proAthlete20Color;

    nextColor = legendColor;
    next20Color = legend20Color;
    categoryGradient = champGradient;
  }

  //6. THEME FOR Purple
  static void setThemeLegendPurple() {
    categoryColor = Color(0xff734FF4);
    categoryColor20Trans = Color(0x30734FF4);
    catImage = catImageLegend;
    catImage3D = catImage3DLegend;
    previousImage = catImage3DChamp;
    nextImage = catImage3DLegend;

    previousColor = championColor;
    previous20Color = champion20Color;

    nextColor = legendColor;
    next20Color = legend20Color;
    categoryGradient = olympGradient;
  }

  //7. THEME FOR GOAT
  static void setThemeGoldGoat() {
    //TODO:
    categoryColor = goatColor;
    categoryColor20Trans = goat20Color;
    catImage = catImageGoat;
    catImage3D = catImage3DGoat;
    previousImage = catImage3DLegend;
    nextImage = catImage3DGoat;

    previousColor = legendColor;
    previous20Color = legend20Color;
    categoryGradient = goatCategoryGradient;
  }
}

/*
  NEW default COLORS
 */
Color categoryColor = Color(0xFFE69C14);
Color categorLightColor = rookieLightColor;
Color categoryColor20Trans = Color(0x30E69C14);
LinearGradient categoryGradient = rookieGradient;
Color previousColor = rookieColor;
Color previous20Color = rookie20Color;

Color nextColor = championColor;
Color next20Color = champion20Color;

String catImage = catImageRookie;
String catImage3D = catImageRookie3d;
String previousImage = catImageRookie3d;
String nextImage = catImage3DChaller;

/**1.Rookie*/
const String catImageRookie = "assets/n_assets/ic_badge_rookie.png";
const String catImageRookie3d = "assets/n_assets/ic_badge_3d_rookie.png";
/**Eof Rookie*/

/**2. Challenger */
const String catImageChallenger = "assets/n_assets/ic_badge_challenger.png";
const String catImage3DChaller = "assets/n_assets/ic_badge_3d_challenger.png";
/** EOF Challenger */

/**3. Athelete */
const String catImageAthelete = "assets/n_assets/ic_badge_athlete.png";
const String catImage3DAthelete = "assets/n_assets/ic_badge_3d_athlete.png";
/** EOF Athelete */

/**4. ProAthelete*/
const String catImageProAthelete = "assets/n_assets/ic_badge_pro_athlete.png";
const String catImage3DProAthelete =
    "assets/n_assets/ic_badge_3d_pro_athlete.png";
/** EOF ProAthelete*/

/**5. Champ*/
const String catImageChamp = "assets/n_assets/ic_badge_champion.png";
const String catImage3DChamp = "assets/n_assets/ic_badge_3d_champion.png";

/**EOF Champ*/

/**6. olympian /  */
const String catImageOlympian = "assets/n_assets/ic_badge_olympian.png";
const String catImage3DOlympian = "assets/n_assets/ic_badge_3d_olympian.png";

/**6. Legend / GOAT */
const String catImageLegend = "assets/n_assets/ic_badge_olympian.png";
const String catImage3DLegend = "assets/n_assets/ic_badge_3d_olympian.png";
/* *EOF Legend*/

const String catImage3DGoat = "assets/n_assets/ic_badge_3d_goat.png";
const String catImageGoat = "assets/n_assets/ic_badge_3d_goat.png";

getColorLightened(Color color, double opacity) {
  var fgCol = {'r': color.red, 'g': color.green, 'b': color.blue};
  const bgCol = {'r': 254, 'g': 254, 'b': 254};
  // const opacity = op ? op : 0.5;

  var flattenedColor = {
    'r': ((opacity * fgCol['r']!) + ((1.0 - opacity) * bgCol['r']!)).toInt(),
    'g': ((opacity * fgCol['g']!) + ((1.0 - opacity) * bgCol['g']!)).toInt(),
    'b': ((opacity * fgCol['b']!) + ((1.0 - opacity) * bgCol['b']!)).toInt(),
  };
  // log('r: ${rookieColor.red} g: ${rookieColor.green} b: ${flattenedColor.toString()}');

  return Color.fromRGBO(
      flattenedColor['r']!, flattenedColor['g']!, flattenedColor['b']!, 1.0);
}

const Color rookieColor = Color(0xFFE69C14);
const Color rookieLightColor = Color(0xFFF2CE89);
const Color rookie20Color = Color(0x33E69C14);
const Color challengerColor = Color(0xFFDF742C);
const Color challengerLightColor = Color(0xFFEFB995);
const Color challenger20Color = Color(0x33DF742C);
const Color athleteColor = Color(0xFFDA4C66);
const Color athleteLightColor = Color(0xFFEDA5B2);
const Color athlete20Color = Color(0x30DA4C66);
const Color proAthleteColor = Color(0xFF2C8BE8);
const Color proAthleteLightColor = Color(0xFF95C5F3);
const Color proAthlete20Color = Color(0x302C8BE8);
const Color championColor = Color(0xFF189944);
const Color championLightColor = Color(0xFF8BCCA1);
const Color champion20Color = Color(0x30189944);
const Color legendColor = Color(0xFF734FF4);
const Color legend20Color = Color(0x30734FF4);
const Color olympianColor = Color(0xFF734FF4);
const Color olympianLightColor = Color(0xFFB9A7F9);
const Color olympian20Color = Color(0x30734FF4);
const Color goatColor = Color(0xFFFFDE8C);
const Color goatLightColor = Color(0xFFFBC34A);
const Color goat20Color = Color(0x30E4A928);

const Color primaryBlackColor = Color(0xFF2C2C2D);
const Color primaryBlackColor60 = Color(0x992C2C2D);
const Color secondaryBlackColor = Color(0x992C2C2D);
const Color secondaryBlackColor2 = Color(0xFFB5B5B5);
const Color secondaryBlackColor3 = Color(0x66B5B5B5);
const Color secondaryBlackColor4 = Color(0xFF808081);
const Color secondaryBlackColor5 = Color(0xFF959596);

const Color bgBlackColor = Color(0xFF141414);
const Color black60 = Color(0x99000000);
const Color greyShadow = Color(0x1A000000);
const Color greyShadow1 = Color(0xFF2C2C2D);
const Color greyShadow2 = Color(0x992C2C2D);

const Color primaryWhiteColor = Color(0xFFFFFFFF);
const Color primaryWhiteColor2 = Color(0x99FFFFFF);

const Color primaryWhiteColorMild = Color(0xF2FFFFFF);
const Color secondaryWhiteColor = Color(0x80FFFFFF);
const Color bgWhiteColor = Color(0xFFF2F2F2);
const Color bgGrayColor = Color(0xFFe6e6e6);
const Color buttonWhite = Color(0xFFEAEAEA);
const Color disableRookieColor = Color(0x99E69C14);
const Color disableCategoryColor = Color(0x99E69C14);
const Color shadedRookieColor = Color(0x80E69C14);
const Color secondaryBlack10Color = Color(0x1A2C2C2D);
const Color secondaryBlack40Color = Color(0x662C2C2D);
const Color secondaryBlack30Color = Color(0x4D2C2C2D);
const Color secondaryBlack50Color = Color(0x802C2C2D);
const Color secondaryBlack60Color = Color(0x992C2C2D);
const Color iconColor = Color(0xFF787878);
const Color dashColor = Color(0x40121212);
const Color notificationIndicatorColor = Color(0xFFEB5757);
const Color tabBgColor = Color(0xFFD9D9D9);
const Color tabLightBgColor = Color(0xFFf2f2f2);
const Color logoutButtonColor = Color(0xFFFF5E47);

const Color unusualColor = Color(0xFFDB8D70);
const Color pauseColor = Color(0xFFFFCA28);

const Color correctColor = Color(0xFF4CAF50);
const Color wrongColor = Color(0xFFF95131);

const LinearGradient primaryGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0xFFEBBF6D),
    Color(0xFFFFFFFF),
  ],
);

const LinearGradient goatTopDownGradient = LinearGradient(
  colors: [
    Color(0xFFFBC34A),
    Color(0xFFC79D4B),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const Color statusSuccessBgColor = Color(0x1430E42D);
const Color statusSuccessColor = Color(0xFF16C313);
const Color statusWarningBgColor = Color(0x1AFF5E47);
const Color statusWarningColor = Color(0xFFFF5E47);
const Color statusErrorBgColor = Color(0x14FDA636);
const Color statusErrorColor = Color(0xFFFC8F03);
const Color successColor = Color(0xFF34AC34);
const Color timeColor = Color(0xffE07379);

/*
 END NEW COLORS
 */

const Color buttonColor = Color(0xFF158ECB);
const Color textColorSemiWhite = Color(0xFFB5B7B8);
const Color bgBottomBar = Color(0xf2181818);
// const Color bgBottomBarActive = Color(0xf2100e0e);
const Color bgBottomBarActive = Color(0xFF0B6A9A);

const Color splashColor = Color(0xFF26B1FF);
const Color skipColor = Color(0xFF808082);
const Color backArrawColor = Color(0xFFCFCFCF);
const Color blueColor = Color(0xFF05DDFA);
const Color startGradientColor = Color(0xFF319BEE);
const Color bottomRightGradientColor = Color(0xFF078175);
const Color endGradientColor = Color(0xFF005CA5);
const Color Red = Color(0xFFFF4D57);
const Color introDotColor = Color(0xFFEBEBEB);
const Color useCameraSheetColor = Color(0xFF007AFF);
const Color deleteRedColor = Color(0xFFFF3B30);
const Color myHealthPopupColor = Color(0xffEDEDED);
const Color successDialogDescColor = Color(0xff3A3A3A);
const Color successDialogAllowedColor = Color(0xff00A500);
const Color successDialogNotAllowedColor = Color(0xffE31C53);
const Color signInPhoneColor = Color(0xff0082C6);
const Color strongPasswordColor = Color(0xff00A85F);
const Color White = Colors.white;
const Color Black = Colors.black;
const Color Grey = Colors.grey;
const Color Blue = Color(0x315BD6);
const Color TextFieldBlueBorderColor = Color(0xFF315BD6);
const Color textColorDim = Color(0xFF4B768B);

const Color GreyLight = Color(0xFFDCDCDC);
const Color greyHeader = Color(0xFFFAFAFA);
const Color blueFooter = Color(0xFF0082C6);

const Color primaryColor = Color(0xFF158ECB);
const Color primaryColor25 = Color(0x40158ECB);
const Color primaryDisabledColor = Color(0xFF105072);
const Color primaryDarkColor = Color(0xFF115295);
const Color textColorMain = Color(0xFF3BB7F6);
const Color mintBoxColor = Color(0x26b7b7b7);
const Color mintBoxBorderColor = Color(0x26ffffff);
const Color lightWhiteColor = Color(0x80ffffff);
const Color transperentColor = Color(0x302A2A2A);
const Color missedPartColor = Color(0xFFFF6D75);
const Color greyBlack = Color(0xFF18212B);
const Color transparentBlack = Color(0x13B7B7B7);
const Color bottomSheetBackground = Color(0xFF212121);
const Color greyTextColor = Color(0xFF9E9E9E);
const Color greyLightTextColor = Color(0xFFB6B7B8);
const Color greyLighterTextColor = Color(0x35B6B7B8);
const Color white60 = Color(0xEBFFFFFF);
const Color white30 = Color(0x4DFFFFFF);

const Color greyBlackText = Color(0xFF515151);
const Color pausedColor = Color(0xFFFFC700);
const Color inProgressColor = Color(0xFF9AE774);
const Color yellowishGreen = Color(0xFFBEFF18);
const Color whiteBlue = Color(0xFF02FCFA);
const Color redOrange = Color(0xFFFF5B02);
const Color statusBarColor = Color(0xFF000000);

const Color orange = Color(0xFFFFC700);
const Color red = Color(0xFFF65C50);
const Color green = Color(0xFF3DD64D);
const Color green_neon = Color(0xFF9AE774);
const Color divider_color = Color(0x0DC4C4C4);

const Color backgroundColor = Color(0xFF18212B);
const Color backgroundColorTrans = Color(0x18212B);

const Color backgroundColor50 = Color(0x8018212B);
const Color primaryLightColor = Color(0xFF99E675);
const Color cardBorderColor = Color(0x40375767);
const Color cardBorderColorTrans = Color(0x80375767);
const Color transparent = Color(0xF8F8F8);

const Color inputBorderColor = Color(0xFF375767);
const Color cardHeading = Color(0xFF6FAFCF);
const Color cardHeadingSemi = Color(0x80375767);

const Color bottomSheetBar = Color(0xFF5D8EA8);
const Color cardHeadingLight = Color(0xFF56879F);
const Color bottomSheetBar50 = Color(0x37576740);
const Color bottomSheetBgNoTrans = Color(0xFF0B1119);
const Color bottomSheetBg = Color(0xFf0B1119);
const Color bottomSheetBg50 = Color(0x800B1119);
const Color inActiveColor = Color(0xCC4A515A);
const Color mintingBgColor = Color(0xFF0F141A);
const Color blue_border = Color(0xFF158ECB);
const Color bottomBarIconsGlow = Color(0xFF86EA56);
const Color redWhite = Color(0xFFFFB998);
const Color darkOrange = Color(0xFFD56C36);
const Color redWarning = Color(0xffE07379);
const Color dividerColor = Color(0xFFF2F2F2);

const Color activeColor = Color(0xFFE1EAEF);
const Color subText = Color(0xB3E1EAEF);
const Color expiresSoonBorderColor = Color(0x66D56C36);

const Color darkGreen = Color(0xFF4FAE6F);
const Color darkRed = Color(0xFFD63A52);

const Color highSneaker = Color(0xFF51FD01);
const Color lowSneaker = Color(0xFF7BE7FF);
const Color unusedSneaker = Color(0xFFE07379);

const LinearGradient mainGradient = LinearGradient(
  colors: [
    primaryColor,
    primaryLightColor,
  ],
);
const LinearGradient discordGrad = LinearGradient(
  colors: [
    Color(0xff0683E3),
    Color(0xffCF535A),
  ],
);
const LinearGradient highIntensityTextGrad = LinearGradient(
  colors: [
    Color(0xffFFF598),
    Color(0xff158ECB),
  ],
);
const LinearGradient readTheGuideGrad = LinearGradient(
  colors: [
    Color(0xff5CE5EB),
    Color(0xff99E675),
  ],
);
const LinearGradient stakingCardHeaderGrad = LinearGradient(
  colors: [
    Color(0xff158ECB),
    Color(0xff3DE8FF),
  ],
);
const LinearGradient lowIntensityTextGrad = LinearGradient(
  colors: [
    Color(0xff9FEEFF),
    Color(0xff1E83EB),
  ],
);
const LinearGradient nonIntensityTextGrad = LinearGradient(
  colors: [
    Color(0xffF0737B),
    Color(0xffF0737B),
    Color(0xff42B9F4),
  ],
);
const LinearGradient inventoryTabBgGrad = LinearGradient(
  colors: [
    Color(0xff6097B3),
    Color(0xff355463),
  ],
);
const LinearGradient inventoryTabTextGrad = LinearGradient(
  colors: [
    Color(0xffE1E1E1),
    Color(0x80e1e1e1),
  ],
);
const LinearGradient swapLoaderGradient = LinearGradient(
  colors: [
    Color(0xff4B768B),
    Color(0xff4B768B),
  ],
);
const LinearGradient blueBorderGradient = LinearGradient(
  colors: [
    Color(0xff3DE8FF),
    Color(0xff158ECB),
  ],
);
const LinearGradient redLowBalanceGradient = LinearGradient(
  colors: [
    Color(0xffE07379),
    Color(0xffE07379),
    Color(0xffE07379),
    Color(0xffE07379),
  ],
);

const LinearGradient redGreenGradient = LinearGradient(
  colors: [
    redWhite,
    Color(0xffA3ED6D),
  ],
);

const LinearGradient borderGradient = LinearGradient(
  colors: [
    Color(0x80FFE600),
    Color(0x80B469FF),
  ],
);

const LinearGradient borderCraftingGradient = LinearGradient(
  colors: [
    Color(0xFFEAFCFD),
    Color(0xFF42899D),
    Color(0xFF5CE5EB),
    Color(0xFFFFFFFF),
    Color(0xFF65ECF1),
    Color(0xFFCBF9FA),
  ],
);
const LinearGradient borderCraftingGradientUp = LinearGradient(
  begin: Alignment(0.0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0xFFEAFCFD),
    Color(0xFF42899D),
    Color(0xFF5CE5EB),
    Color(0xFF65ECF1),
    Color(0xFFFFFFFF),
    Color(0xFFCBF9FA),
  ],
);

const LinearGradient craftingLabHeadingGradient = LinearGradient(
  colors: [
    Color(0xFF8177DB),
    Color(0xFFBE86C5),
    Color(0xFFEA90B6),
    Color(0xFFFC95B1),
    Color(0xFFFCA0B1),
    Color(0xFFFCC0B1),
    Color(0xFFFEEFB1),
  ],
);

const LinearGradient craftingGlideTextGradient = LinearGradient(
  colors: [
    Color(0xFFB3FFAB),
    Color(0xFF12FFF7),
  ],
);

const LinearGradient wFitmintGradient = LinearGradient(
  colors: [
    Color(0x4A18212B),
    Color(0x4A18212B),
    Color(0xFF043B57),
  ],
);
const LinearGradient wTFitmintGradient = LinearGradient(
  colors: [
    Color(0xFF29C3F4),
    Color(0xFF0FECC0),
  ],
);

const LinearGradient wTUSDCGradient = LinearGradient(
  colors: [
    Color(0xff29C3F4),
    Color(0xff2775CA),
  ],
);

const LinearGradient wPolygonGradient = LinearGradient(
  colors: [
    Color(0xFF18212B),
    Color(0xFF18212B),
    Color(0x47341C5E),
  ],
);

const LinearGradient wTPolygonGradient = LinearGradient(
  colors: [
    Color(0xFF29C3F4),
    Color(0xFF0BA90FF),
  ],
);
const LinearGradient centerBlack = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0x1A000000),
    Color(0x33000000),
    Color(0x4D000000),
    Color(0x80000000),
    Color(0xb3000000),
    Color(0xcc000000),
    Color(0xff000000),
    Color(0xe6000000),
    Color(0xcc000000),
    Color(0xb3000000),
    Color(0x80000000),
    Color(0x4D000000),
    Color(0x00000000),
    // Color(0x00000000),
  ],
);

const LinearGradient craftingItemGradient = LinearGradient(
  begin: Alignment(-1.0, -1),
  end: Alignment(1, 1),
  colors: [
    Color(0xFF2A3A4B),
    Color(0xFF070B0D),
  ],
);

const LinearGradient craftingItemTransGradient = LinearGradient(
  begin: Alignment(-1.0, -1),
  end: Alignment(1, 1),
  colors: [
    Color(0xBF2A3A4B),
    Color(0xCC070B0D),
  ],
);

const LinearGradient craftingMissedBannerGradient = LinearGradient(
  begin: Alignment(1.0, 0),
  end: Alignment(-1, 0),
  colors: [
    Color(0xA6000000),
    Color(0x80000000),
    Color(0x66000000),
    Color(0x00000000),
  ],
);

const LinearGradient craftingBannerGradient = LinearGradient(
  begin: Alignment(-1.0, -1),
  end: Alignment(1, 1),
  colors: [
    Color(0xFF304058),
    Color(0xFF19212B),
  ],
);

const LinearGradient warningGradient = LinearGradient(
  colors: [
    Color(0xFFA1EC6F),
    Color(0xFFD56C36),
  ],
);

const LinearGradient rewardGradient = LinearGradient(
  begin: Alignment(-1.0, 1),
  end: Alignment(-1, -1),
  colors: [
    Color(0xFFFFB998),
    Color(0xFFA3ED6D),
  ],
);
const LinearGradient whiteOrangeGrad = LinearGradient(
  begin: Alignment(-1.0, 1),
  end: Alignment(-1, -1),
  colors: [
    Color(0xffF8D9BA),
    Color(0xffC2D9FF),
  ],
);

const LinearGradient rewardBgGradient = LinearGradient(
  begin: Alignment(-1.0, 1),
  end: Alignment(-1, -1),
  colors: [
    Color(0xFF000000),
    Color(0x33007AA2),
  ],
);

const LinearGradient energyMultiplierGradient = LinearGradient(
  colors: [
    Color(0xFFFFFFFF),
    Color(0xFF2D9AC1),
  ],
);

const LinearGradient rewardSneakerGradient = LinearGradient(
  begin: Alignment(-1.0, 1),
  end: Alignment(-1, -1),
  colors: [
    Color(0xFFFFFFFF),
    Color(0xFF99E675),
  ],
);

const LinearGradient rewardsCraftingGradient = LinearGradient(
  begin: Alignment(-1.0, 1),
  end: Alignment(-1, -1),
  colors: [
    Color(0XFFEAFCFD),
    Color(0XFF42899D),
    Color(0XFF5CE5EB),
    Color(0XFF65ECF1),
    Color(0XFFFFFFFF),
    Color(0XFFCBF9FA),
  ],
);

const LinearGradient expiresSoonGradient = LinearGradient(
  begin: Alignment(-1.0, -1),
  end: Alignment(-1, 1),
  colors: [
    Color(0x00000000),
    Color(0x33D56C36),
  ],
);

const LinearGradient blackGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0x00000000),
    Color(0xFF000000),
  ],
);

const LinearGradient blackGradientUp = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0x00000000),
    Color(0xA4000000),
    Color(0xD8000000),
    Color(0xFF000000),
  ],
);

const LinearGradient blackGradientDown = LinearGradient(
  begin: Alignment(0, 0),
  end: Alignment(0, -1),
  colors: [
    Color(0x00000000),
    Color(0xCC000000),
    Color(0xE6000000),
    Color(0xFF000000),
  ],
);
const LinearGradient blackDarkGradientDown = LinearGradient(
  begin: Alignment(0, 0),
  end: Alignment(0, -1),
  colors: [
    Color(0x00000000),
    Color(0xCC000000),
    Color(0xCC000000),
    Color(0xE6000000),
    Color(0xE6000000),
    Color(0xFF000000),
    Color(0xFF000000),
  ],
);

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

const LinearGradient horizontalLineGradient = LinearGradient(
  begin: Alignment(0, 0),
  end: Alignment(0, -1),
  colors: [
    Color(0x00375767),
    Color(0xFF375767),
    Color(0x00375767),
  ],
);
const LinearGradient blueGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0xB33BB7F6),
    Color(0x00375767),
  ],
);

const LinearGradient redGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0xFFFFB998),
    Color(0x00375767),
  ],
);

const LinearGradient greenGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0xB299E675),
    Color(0x00375767),
  ],
);
const LinearGradient greenDarkGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0xB28AFC59),
    Color(0xB276F138),
  ],
);
const LinearGradient orangeDarkGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0xffFA7A34),
    Color(0xffcb632a),
  ],
);
const LinearGradient yellowDarkGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0xffFF9C07),
    Color(0xffcb7c05),
  ],
);
const LinearGradient redDarkGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0xffD64D66),
    Color(0xffbb4359),
  ],
);
const LinearGradient trackerButtonsGradient = LinearGradient(
  begin: Alignment(0, -1),
  end: Alignment(0, 0),
  colors: [
    Color(0x000B1119),
    Color(0X690B1119),
    Color(0XE80B1119),
    Color(0xFF0B1119),
    Color(0xFF0B1119),
  ],
);

const LinearGradient rookieCategoryGradient = LinearGradient(
  colors: [
    Color(0xFFEBB043),
    Color(0xFFDE9918),
  ],
);

const LinearGradient challengerCategoryGradient = LinearGradient(
  colors: [
    Color(0xFFDF742C),
    Color(0xFFC8591B),
  ],
);

const LinearGradient athleteCategoryGradient = LinearGradient(
  colors: [
    Color(0xFFDA4C66),
    Color(0xFFB9252E),
  ],
);

const LinearGradient proAthleteCategoryGradient = LinearGradient(
  colors: [
    Color(0xFF2C8BE8),
    Color(0xFF1F62C7),
  ],
);

const LinearGradient champCategoryGradient = LinearGradient(
  colors: [
    Color(0xFF189944),
    Color(0xFF0C7810),
  ],
);

const LinearGradient olympCategoryGradient = LinearGradient(
  colors: [
    Color(0xFF734FF4),
    Color(0xFF4F2AD6),
  ],
);

const LinearGradient goatCategoryGradient = LinearGradient(
  colors: [
    Color(0xFFFBC34A),
    Color(0xFFC79D4B),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const LinearGradient rookieGradient = LinearGradient(
  colors: [rookieColor, rookieColor],
);

const LinearGradient challengerGradient = LinearGradient(
  colors: [challengerColor, challengerColor],
);

const LinearGradient athleteGradient = LinearGradient(
  colors: [athleteColor, athleteColor],
);

const LinearGradient proAthleteGradient = LinearGradient(
  colors: [proAthleteColor, proAthleteColor],
);

const LinearGradient champGradient = LinearGradient(
  colors: [championColor, championColor],
);

const LinearGradient olympGradient = LinearGradient(
  colors: [olympianColor, olympianColor],
);

const LinearGradient goatGradient = LinearGradient(
  colors: [
    Color(0xFFE8B518),
    Color(0xFFBB8113),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
LinearGradient goat20Gradient = LinearGradient(
  colors: [
    Color(0xFFC99E4B).withOpacity(0.2),
    Color(0xFFFCC44B).withOpacity(0.2),
  ],
  begin: Alignment(0.00, -1.00),
  end: Alignment(0, 1),
);
