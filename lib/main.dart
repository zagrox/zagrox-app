import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  bool displaySplashImage = true;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);

    Future.delayed(Duration(milliseconds: 1000),
        () => safeSetState(() => _appStateNotifier.stopShowingSplashImage()));
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'خدمات برندسازی و بازاریابی اینترنتی',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('fa'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({
    Key? key,
    this.initialPage,
    this.page,
    this.disableResizeToAvoidBottomInset = false,
  }) : super(key: key);

  final String? initialPage;
  final Widget? page;
  final bool disableResizeToAvoidBottomInset;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Home';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Home': HomeWidget(),
      'Services': ServicesWidget(),
      'Brands': BrandsWidget(),
      'Projects': ProjectsWidget(),
      'Profile': ProfileWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: MediaQuery(
          data: queryData
              .removeViewInsets(removeBottom: true)
              .removeViewPadding(removeBottom: true),
          child: _currentPage ?? tabs[_currentPageName]!),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        currentIndex: currentIndex,
        onTap: (i) => safeSetState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: FlutterFlowTheme.of(context).primary,
        selectedItemColor: FlutterFlowTheme.of(context).tertiary,
        unselectedItemColor: FlutterFlowTheme.of(context).alternate,
        selectedBackgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: 8.0,
        itemBorderRadius: 8.0,
        margin: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 8.0),
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 7.0, 0.0, 6.0),
        width: double.infinity,
        elevation: 0.0,
        items: [
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 0
                      ? Icons.cottage_sharp
                      : Icons.cottage_outlined,
                  color: currentIndex == 0
                      ? FlutterFlowTheme.of(context).tertiary
                      : FlutterFlowTheme.of(context).alternate,
                  size: currentIndex == 0 ? 24.0 : 24.0,
                ),
                Text(
                  'زاگرس',
                  overflow: TextOverflow.ellipsis,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Yekan',
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 1
                      ? Icons.perm_data_setting_sharp
                      : Icons.perm_data_setting_outlined,
                  color: currentIndex == 1
                      ? FlutterFlowTheme.of(context).tertiary
                      : FlutterFlowTheme.of(context).alternate,
                  size: currentIndex == 1 ? 24.0 : 24.0,
                ),
                Text(
                  'خدمات',
                  overflow: TextOverflow.ellipsis,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Yekan',
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 2
                      ? Icons.business_center_rounded
                      : Icons.business_center_outlined,
                  color: currentIndex == 2
                      ? FlutterFlowTheme.of(context).tertiary
                      : FlutterFlowTheme.of(context).alternate,
                  size: currentIndex == 2 ? 24.0 : 24.0,
                ),
                Text(
                  'برندها',
                  overflow: TextOverflow.ellipsis,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Yekan',
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 3
                      ? Icons.devices_fold
                      : Icons.devices_fold_outlined,
                  color: currentIndex == 3
                      ? FlutterFlowTheme.of(context).tertiary
                      : FlutterFlowTheme.of(context).alternate,
                  size: currentIndex == 3 ? 24.0 : 24.0,
                ),
                Text(
                  'پروژه ها',
                  overflow: TextOverflow.ellipsis,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Yekan',
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          FloatingNavbarItem(
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  currentIndex == 4
                      ? Icons.admin_panel_settings_rounded
                      : Icons.admin_panel_settings_outlined,
                  color: currentIndex == 4
                      ? FlutterFlowTheme.of(context).tertiary
                      : FlutterFlowTheme.of(context).alternate,
                  size: currentIndex == 4 ? 24.0 : 24.0,
                ),
                Text(
                  'پروفایل',
                  overflow: TextOverflow.ellipsis,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Yekan',
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
