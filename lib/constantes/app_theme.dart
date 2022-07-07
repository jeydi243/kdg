part of values;

class KDGTheme {
  static ThemeData light(context) {
    var theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: AppColors.primary,
      errorColor: AppColors.error,
      platform: TargetPlatform.android,
      useMaterial3: false,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          error: AppColors.error,
          primary: AppColors.primary,
          brightness: Brightness.light),
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
        color: AppColors.text,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        titleTextStyle: GoogleFonts.k2d(
          color: AppColors.textDark,
          fontSize: 19,
        ),
      ),
      dataTableTheme: theme.dataTableTheme.copyWith(
          dataRowHeight: 15,
          dataTextStyle: GoogleFonts.k2d(),
          dividerThickness: 1,
          horizontalMargin: 5,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            border: Border.all(
              color: Colors.black,
              width: 8,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          dataRowColor: MaterialStateProperty.all(Colors.red),
          headingRowColor: MaterialStateProperty.all(AppColors.textDark)),
      textTheme: GoogleFonts.k2dTextTheme().copyWith(
        bodyText1: TextStyle(
          color: AppColors.textDark,
        ),
        bodyText2: TextStyle(
          color: AppColors.textDark,
        ),
        subtitle1: TextStyle(
          color: AppColors.textDark,
        ),
        headline1: TextStyle(
            fontWeight: FontWeight.w100,
            color: AppColors.textDark,
            fontSize: 30),
        headline2: TextStyle(
            fontWeight: FontWeight.w200,
            color: AppColors.textDark,
            fontSize: 26),
        headline3: TextStyle(
            fontWeight: FontWeight.w300,
            color: AppColors.textDark,
            fontSize: 24),
        headline4: TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.textDark,
            fontSize: 20),
        headline5: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
            fontSize: 18),
        button: theme.textTheme.button?.copyWith(
            fontSize: 14, color: AppColors.text, fontWeight: FontWeight.normal),
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
                TextStyle(color: AppColors.text))),
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
    var theme = ThemeData.dark();

    return theme.copyWith(
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
          fillColor: AppColors.accent,
          focusColor: AppColors.accent,
          isDense: true,
          labelStyle: TextStyle(color: AppColors.textDark),
          hintStyle: GoogleFonts.k2d(color: AppColors.textDark),
          helperStyle: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(style: BorderStyle.solid, color: AppColors.error)),
          errorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(style: BorderStyle.solid, color: AppColors.error)),
          errorStyle: TextStyle(color: AppColors.error, fontSize: 10)),
      appBarTheme: theme.appBarTheme.copyWith(
        color: AppColors.backgroundDark,
        // backgroundColor: AppColors.backgroundDark,
        iconTheme: IconThemeData(color: AppColors.accent),
        titleTextStyle: GoogleFonts.k2d(
          color: AppColors.primary,
          fontSize: 15,
        ),
      ),
      textTheme: GoogleFonts.k2dTextTheme().copyWith(
        bodyText1: TextStyle(
          color: AppColors.text,
        ),
        bodyText2: TextStyle(
          color: AppColors.text,
        ),
        subtitle1: TextStyle(
          color: AppColors.text,
        ),
        subtitle2: TextStyle(
          color: AppColors.text,
        ),
        headline1: GoogleFonts.k2d(
            fontWeight: FontWeight.w100,
            color: AppColors.primary,
            fontSize: 30),
        headline2: TextStyle(
            fontWeight: FontWeight.w200, color: AppColors.text, fontSize: 26),
        headline3: TextStyle(
            fontWeight: FontWeight.w300, color: AppColors.text, fontSize: 24),
        headline4: TextStyle(
            fontWeight: FontWeight.w400, color: AppColors.text, fontSize: 20),
        headline5: TextStyle(
            fontWeight: FontWeight.w500, color: AppColors.text, fontSize: 18),
        button: theme.textTheme.button?.copyWith(
            fontSize: 14, color: AppColors.text, fontWeight: FontWeight.normal),
        caption: theme.textTheme.caption?.copyWith(
            fontSize: 34,
            color: AppColors.primary,
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
                TextStyle(color: AppColors.text))),
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
