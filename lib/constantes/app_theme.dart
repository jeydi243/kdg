part of values;

final emptyState = new Container(
    child: new Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    new Image.asset("assets/nothing_here.png"),
    new Padding(
        padding: new EdgeInsets.only(top: 8.0),
        child: new Text('Nothing here. Come back soon!',
            textAlign: TextAlign.center))
  ],
));

class MadiaTheme {
  static ThemeData of(context) {
    var theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: AppColors.white,
        primaryColorDark: AppColors.black,
        bottomAppBarColor: AppColors.white,
        scaffoldBackgroundColor: AppColors.background,
        errorColor: AppColors.warning,
        dividerColor: Colors.transparent,
        appBarTheme: theme.appBarTheme.copyWith(
          color: AppColors.white,
          iconTheme: IconThemeData(color: AppColors.black),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(theme.textTheme)
            .copyWith(
              // bodyText1: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     color: AppColors.black,
              //     fontSize: 30),
              headline1: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: AppColors.black,
                  fontSize: 30),
              headline2: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: AppColors.black,
                  fontSize: 26),
              headline3: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                  fontSize: 24),
              headline4: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  fontSize: 20),
              headline5: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  fontSize: 18),
              button: theme.textTheme.button!.copyWith(
                  fontSize: 14,
                  color: AppColors.white,
                  fontWeight: FontWeight.normal),
              caption: theme.textTheme.caption!.copyWith(
                  fontSize: 34,
                  color: AppColors.primary,
                  fontFamily: 'Metropolis',
                  fontWeight: FontWeight.normal),
            )
            .apply(fontFamily: 'Metropolis'),
        buttonTheme: theme.buttonTheme.copyWith(
          minWidth: 50,
          buttonColor: AppColors.black,
        ),
        iconTheme: theme.iconTheme.copyWith(color: AppColors.black, size: 24),
        primaryIconTheme: IconThemeData(color: AppColors.second, size: 24),
        bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedIconTheme: IconThemeData(color: AppColors.second),
            unselectedIconTheme: IconThemeData(color: AppColors.black),
            selectedLabelStyle: GoogleFonts.poppins(),
            selectedItemColor: AppColors.second));
  }
}
