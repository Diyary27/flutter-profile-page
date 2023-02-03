import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = Locale('en');

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Color(0x0dffffff);
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleTheme: () {
          setState(() {
            if (_themeMode == ThemeMode.dark)
              _themeMode = ThemeMode.light;
            else
              _themeMode = ThemeMode.dark;
          });
        },
        selectedLanguageChanged: (_Language newSelectedLanguageByUser) {
          setState(() {
            _locale = newSelectedLanguageByUser == _Language.en
                ? Locale('en')
                : Locale('fa');
          });
        },
      ),
    );
  }
}

class MyAppThemeConfig {
  static const String faPrimaryFontFamily = 'B Mitra';
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        surfaceColor = Color(0x0dffffff),
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  TextTheme get enPrimaryTextTheme => GoogleFonts.latoTextTheme(
        TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w900,
            color: primaryTextColor,
          ), // former headline6
          bodyLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: primaryTextColor,
          ),
          bodyMedium: TextStyle(
            color: secondaryTextColor,
            fontSize: 13,
          ),
        ),
      );
  TextTheme get faPrimaryTextTheme => TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.w900,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily,
        ), // former headline6
        bodyLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily,
        ),
        bodyMedium: TextStyle(
          color: secondaryTextColor,
          fontSize: 13,
          height: 1.5,
          fontFamily: faPrimaryFontFamily,
        ),
        labelLarge: TextStyle(
          fontFamily: faPrimaryFontFamily,
        ),
      );

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: Colors.pink,
      primaryColor: primaryColor,
      brightness: brightness,
      appBarTheme: AppBarTheme(
        color: appBarColor,
        foregroundColor: primaryTextColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      dividerColor: surfaceColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
      ),
      textTheme: languageCode == 'en' ? enPrimaryTextTheme : faPrimaryTextTheme,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: surfaceColor,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function() toggleTheme;
  final Function(_Language _language) selectedLanguageChanged;

  const MyHomePage(
      {super.key,
      required this.toggleTheme,
      required this.selectedLanguageChanged});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _SkillType _skill = _SkillType.photoshop;
  _Language _language = _Language.en;

  void _updateSelectedSkill(_SkillType _skillType) {
    // we use setState(() {}); because we want the the widget to know when the state is changed
    setState(() {
      this._skill = _skillType;
    });
  }

  void _updateSelectedLanguage(_Language language) {
    setState(() {
      widget.selectedLanguageChanged(language);
      this._language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(localization.profileTitle),
        actions: [
          Icon(CupertinoIcons.chat_bubble),
          InkWell(
            onTap: widget.toggleTheme,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Icon(CupertinoIcons.ellipsis_vertical),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(36),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/profile_image.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 2),
                        Text(
                          localization.job,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.location_solid,
                              size: 15,
                            ),
                            SizedBox(width: 3),
                            Text(
                              localization.location,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(36, 0, 36, 16),
              child: Text(localization.summary),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localization.selectedLanguage),
                  CupertinoSlidingSegmentedControl<_Language>(
                    groupValue: _language,
                    thumbColor: Theme.of(context).primaryColor,
                    children: {
                      _Language.en: Text(localization.enLanguage),
                      _Language.fa: Text(localization.faLanguage)
                    },
                    onValueChanged: (value) => _updateSelectedLanguage(value!),
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    localization.skills,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 13,
                  ),
                ],
              ),
            ),
            Center(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 10,
                runSpacing: 10,
                children: [
                  Skill(
                    type: _SkillType.photoshop,
                    title: 'Photoshop',
                    imagePath: 'assets/images/app_icon_01.png',
                    shadowcolor: Colors.blue,
                    isActive: _skill == _SkillType.photoshop,
                    onTap: () {
                      _updateSelectedSkill(_SkillType.photoshop);
                    },
                  ),
                  Skill(
                    type: _SkillType.xd,
                    title: 'Adobe XD',
                    imagePath: 'assets/images/app_icon_05.png',
                    shadowcolor: Colors.pink,
                    isActive: _skill == _SkillType.xd,
                    onTap: () {
                      _updateSelectedSkill(_SkillType.xd);
                    },
                  ),
                  Skill(
                    type: _SkillType.illustrator,
                    title: 'Illustrator',
                    imagePath: 'assets/images/app_icon_04.png',
                    shadowcolor: Colors.orange.shade100,
                    isActive: _skill == _SkillType.illustrator,
                    onTap: () {
                      _updateSelectedSkill(_SkillType.illustrator);
                    },
                  ),
                  Skill(
                    type: _SkillType.afterEffects,
                    title: 'After Effects',
                    imagePath: 'assets/images/app_icon_03.png',
                    shadowcolor: Colors.blue.shade800,
                    isActive: _skill == _SkillType.afterEffects,
                    onTap: () {
                      _updateSelectedSkill(_SkillType.afterEffects);
                    },
                  ),
                  Skill(
                    type: _SkillType.lightRoom,
                    title: 'Lightroom',
                    imagePath: 'assets/images/app_icon_02.png',
                    shadowcolor: Colors.blue,
                    isActive: _skill == _SkillType.lightRoom,
                    onTap: () {
                      _updateSelectedSkill(_SkillType.lightRoom);
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(36, 16, 36, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.personalInformation,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localization.email,
                      prefixIcon: Icon(CupertinoIcons.at),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localization.password,
                      prefixIcon: Icon(CupertinoIcons.lock),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(localization.save),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Skill extends StatelessWidget {
  final _SkillType type;
  final String title;
  final String imagePath;
  final Color shadowcolor;
  final bool isActive;
  final Function() onTap;

  const Skill({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.shadowcolor,
    required this.isActive,
    required this.type,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius defaultBorderRadius = BorderRadius.circular(12);
    return InkWell(
      borderRadius: defaultBorderRadius,
      onTap: onTap,
      child: Container(
        height: 110,
        width: 110,
        decoration: isActive
            ? BoxDecoration(
                borderRadius: defaultBorderRadius,
                color: Theme.of(context).dividerColor,
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: shadowcolor.withOpacity(0.3),
                        blurRadius: 30,
                      ),
                    ])
                  : null,
              child: Image.asset(
                imagePath,
                height: 50,
                width: 50,
              ),
            ),
            SizedBox(height: 7),
            Text(title),
          ],
        ),
      ),
    );
  }
}

enum _SkillType { photoshop, xd, illustrator, afterEffects, lightRoom }

enum _Language {
  en,
  fa,
}
