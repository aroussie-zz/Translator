import 'package:flutter/material.dart';
import 'package:myTranslator/screens/TranslatePage.dart';

/// See https://medium.com/coding-with-flutter/flutter-case-study-multiple-navigators-with-bottomnavigationbar-90eb6caa6dbf
class TabNavigator extends StatefulWidget {

  TabNavigator({this.navigationKey, this.tabItem});

  final Widget tabItem;
  final GlobalKey<NavigatorState> navigationKey;

  @override
  _TabNavigatorState createState() {
    return _TabNavigatorState();
  }

}

class _TabNavigatorState extends State<TabNavigator>{

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigationKey ,
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name){
              case '/':
                return widget.tabItem;
              case '/details':
                return TranslatePage();
            }
          }
        );
      },
    );

  }


}