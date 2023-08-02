part of values;

class KDGTheme {
  static ThemeData light(context) {
    var theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: AppColors.primary,
      platform: TargetPlatform.android,
      useMaterial3: false,
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
        backgroundColor: AppColors.background,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        titleTextStyle: GoogleFonts.k2d(
          color: AppColors.textDark,
          fontSize: 19,
        ),
      ),
      dataTableTheme: theme.dataTableTheme.copyWith(
          dataRowMinHeight: 15,
          dataRowMaxHeight: 20,
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
        bodyLarge: TextStyle(
          color: AppColors.textDark,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textDark,
        ),
        titleMedium: TextStyle(
          color: AppColors.textDark,
        ),
        displayLarge: TextStyle(
            fontWeight: FontWeight.w100,
            color: AppColors.textDark,
            fontSize: 30),
        displayMedium: TextStyle(
            fontWeight: FontWeight.w200,
            color: AppColors.textDark,
            fontSize: 26),
        displaySmall: TextStyle(
            fontWeight: FontWeight.w300,
            color: AppColors.textDark,
            fontSize: 24),
        headlineMedium: TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.textDark,
            fontSize: 20),
        headlineSmall: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
            fontSize: 18),
        labelLarge: theme.textTheme.labelLarge?.copyWith(
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
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(
              error: AppColors.error,
              primary: AppColors.primary,
              brightness: Brightness.light)
          .copyWith(error: AppColors.error),
    );
  }

  static ThemeData dark(context) {
    var theme = ThemeData.dark();

    return theme.copyWith(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      dividerTheme: DividerThemeData(color: AppColors.accent),
      expansionTileTheme: ExpansionTileThemeData(
          tilePadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.primary,
          collapsedTextColor: AppColors.accent,
          collapsedBackgroundColor: Colors.transparent),
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
      dividerColor: AppColors.primary,
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.amber[50]!.withOpacity(.3),
          // focusColor: AppColors.accent,
          isDense: true,
          contentPadding: EdgeInsets.all(5),
          alignLabelWithHint: true,
          labelStyle:
              TextStyle(color: AppColors.text, fontStyle: FontStyle.italic),
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
        // color: AppColors.backgroundDark,
        backgroundColor: AppColors.backgroundDark,
        iconTheme: IconThemeData(color: AppColors.accent),
        titleTextStyle: GoogleFonts.k2d(
          color: AppColors.primary,
          fontSize: 15,
        ),
      ),
      textTheme: GoogleFonts.k2dTextTheme().copyWith(
        bodyLarge: TextStyle(
          color: AppColors.text,
        ),
        bodyMedium: TextStyle(
          color: AppColors.text,
        ),
        titleMedium: TextStyle(
          color: AppColors.text,
        ),
        titleSmall: TextStyle(
          color: AppColors.text,
        ),
        displayLarge: GoogleFonts.k2d(
            fontWeight: FontWeight.w100,
            color: AppColors.primary,
            fontSize: 30),
        displayMedium: TextStyle(
            fontWeight: FontWeight.w200, color: AppColors.text, fontSize: 26),
        displaySmall: TextStyle(
            fontWeight: FontWeight.w300, color: AppColors.text, fontSize: 24),
        headlineMedium: TextStyle(
            fontWeight: FontWeight.w400, color: AppColors.text, fontSize: 20),
        headlineSmall: TextStyle(
            fontWeight: FontWeight.w500, color: AppColors.text, fontSize: 18),
        labelLarge: theme.textTheme.labelLarge?.copyWith(
            fontSize: 14, color: AppColors.text, fontWeight: FontWeight.normal),
        bodySmall: theme.textTheme.bodySmall?.copyWith(
            fontSize: 34,
            color: AppColors.primary,
            fontWeight: FontWeight.normal),
      ),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.backgroundDark, elevation: 10),
      buttonTheme: theme.buttonTheme.copyWith(
        minWidth: 40,
        textTheme: ButtonTextTheme.primary,
        disabledColor: HexColor.fromHex("#1CBFE2"),
        buttonColor: AppColors.primary,
      ),
      iconTheme: theme.iconTheme.copyWith(color: AppColors.accent, size: 24),
      primaryIconTheme: IconThemeData(color: AppColors.accent, size: 24),
      dialogBackgroundColor: AppColors.backgroundDark,
      dialogTheme: DialogTheme(
          backgroundColor: AppColors.backgroundDark,
          titleTextStyle: GoogleFonts.k2d(),
          alignment: Alignment.center),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            enableFeedback: true,
            backgroundColor: MaterialStateProperty.all<Color?>(
                Colors.teal[50]?.withOpacity(.2)),
            minimumSize: MaterialStateProperty.all<Size>(
                Size(Get.width, Get.height * .02)),
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
      bottomAppBarTheme: BottomAppBarTheme(color: AppColors.primary[900]),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(
              secondary: AppColors.accent,
              error: AppColors.error,
              primary: AppColors.primary,
              surface: Colors.limeAccent,
              onPrimary: Colors.white,
              background: Colors.amber,
              primaryContainer: AppColors.backgroundDark,
              onSurface: Color.fromARGB(255, 0, 255, 47),
              shadow: Color.fromARGB(255, 252, 252, 252),
              brightness: Brightness.light)
          .copyWith(error: AppColors.error),
    );
  }
}
