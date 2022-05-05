part of values;

class KDGTheme {
  static ThemeData light(context) {
    var theme = Get.theme;
    return theme.copyWith(
      primaryColor: AppColors.primary,
      errorColor: AppColors.error,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          error: AppColors.error,
          primary: AppColors.primary,
          brightness: Brightness.light),
      primaryColorDark: AppColors.primary,
      tabBarTheme: TabBarTheme(
          labelColor: Colors.teal,
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: EdgeInsets.all(5),
          labelStyle: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.k2d(color: Colors.teal[50])),
      dividerColor: AppColors.accent,
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          helperStyle: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(style: BorderStyle.solid, color: AppColors.error)),
          errorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(style: BorderStyle.solid, color: AppColors.error)),
          errorStyle: TextStyle(color: AppColors.error, fontSize: 10)),
      appBarTheme: theme.appBarTheme.copyWith(
        color: AppColors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: GoogleFonts.k2d(
          color: AppColors.primary,
          fontSize: 19,
        ),
      ),
      textTheme: GoogleFonts.k2dTextTheme().copyWith(
        headline1: TextStyle(
            fontWeight: FontWeight.w100, color: Colors.black, fontSize: 30),
        headline2: TextStyle(
            fontWeight: FontWeight.w200, color: Colors.black, fontSize: 26),
        headline3: TextStyle(
            fontWeight: FontWeight.w300, color: Colors.black, fontSize: 24),
        headline4: TextStyle(
            fontWeight: FontWeight.w400, color: Colors.black, fontSize: 20),
        headline5: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black, fontSize: 18),
        button: theme.textTheme.button?.copyWith(
            fontSize: 14,
            color: AppColors.white,
            fontWeight: FontWeight.normal),
        caption: theme.textTheme.caption?.copyWith(
            fontSize: 34,
            color: AppColors.primary,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.normal),
      ),
      buttonTheme: theme.buttonTheme.copyWith(
        minWidth: 50,
        buttonColor: AppColors.primary,
      ),
      iconTheme: theme.iconTheme.copyWith(color: AppColors.primary, size: 24),
      primaryIconTheme: IconThemeData(color: AppColors.accent, size: 24),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            enableFeedback: true,
            backgroundColor: MaterialStateProperty.all<Color?>(
                Color.fromARGB(255, 243, 248, 248)),
            minimumSize: MaterialStateProperty.all<Size>(
                Size(Get.width / 4, Get.height * .02)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: AppColors.white))),
      ),
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(color: AppColors.accent),
          unselectedIconTheme: IconThemeData(color: Colors.black),
          selectedLabelStyle: GoogleFonts.k2d(),
          selectedItemColor: AppColors.accent),
    );
  }

  static ThemeData dark(context) {
    var theme = Get.theme;

    return theme.copyWith(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      errorColor: AppColors.error,
      dividerTheme: DividerThemeData(color: AppColors.accent),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.accent,
          error: AppColors.error,
          primary: AppColors.primary,
          shadow: Color.fromARGB(255, 252, 252, 252),
          brightness: Brightness.dark),
      primaryColorDark: AppColors.primary[900],
      tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: EdgeInsets.all(5),
          labelStyle: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Get.theme.scaffoldBackgroundColor,
              fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.k2d(color: Colors.teal[50])),
      bottomAppBarColor: AppColors.primary[900],
      dividerColor: AppColors.primary,
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          helperStyle: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(style: BorderStyle.solid, color: AppColors.error)),
          errorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(style: BorderStyle.solid, color: AppColors.error)),
          errorStyle: TextStyle(color: AppColors.error, fontSize: 10)),
      appBarTheme: theme.appBarTheme.copyWith(
        color: AppColors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: GoogleFonts.k2d(
          color: AppColors.primary,
          fontSize: 19,
        ),
      ),
      textTheme: GoogleFonts.k2dTextTheme().copyWith(
        headline1: TextStyle(
            fontWeight: FontWeight.w100, color: Colors.black, fontSize: 30),
        headline2: TextStyle(
            fontWeight: FontWeight.w200, color: Colors.black, fontSize: 26),
        headline3: TextStyle(
            fontWeight: FontWeight.w300, color: Colors.black, fontSize: 24),
        headline4: TextStyle(
            fontWeight: FontWeight.w400, color: Colors.black, fontSize: 20),
        headline5: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black, fontSize: 18),
        button: theme.textTheme.button?.copyWith(
            fontSize: 14,
            color: AppColors.white,
            fontWeight: FontWeight.normal),
        caption: theme.textTheme.caption?.copyWith(
            fontSize: 34,
            color: AppColors.primary,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.normal),
      ),
      buttonTheme: theme.buttonTheme.copyWith(
        minWidth: 50,
        buttonColor: AppColors.primary,
      ),
      iconTheme:
          theme.iconTheme.copyWith(color: AppColors.backgroundDark, size: 24),
      primaryIconTheme: IconThemeData(color: AppColors.accent, size: 24),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            enableFeedback: true,
            backgroundColor: MaterialStateProperty.all<Color?>(
                Colors.teal[50]?.withOpacity(.2)),
            minimumSize: MaterialStateProperty.all<Size>(
                Size(Get.width / 4, Get.height * .02)),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: AppColors.white))),
      ),
      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(color: AppColors.accent),
          unselectedIconTheme: IconThemeData(color: Colors.black),
          selectedLabelStyle: GoogleFonts.k2d(),
          selectedItemColor: AppColors.accent),
    );
  }
}
