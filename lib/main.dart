import "package:flutter/material.dart";
import "package:diana/map/map.dart";

void main() {
  runApp(const Aurora());
}

class Aurora extends StatelessWidget {
  const Aurora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      themeMode: ThemeMode.dark,
      home: const MainFrame(),
    );
  }
}

class MainFrame extends StatelessWidget {
  const MainFrame({super.key});

  static AppBar _makeAppBar() {
    return AppBar(
      bottom: const TabBar(
        tabs: [
          Tab(text: "MapScreen"),
          Tab(text: "EmptyTab"),
        ],
      ),
    );
  }

  static Drawer _makeDrawer() {
    return Drawer(
      child: ListView(),
    );
  }

  static TabBarView _makeTabBarView() {
    return TabBarView(
      children: [
        MapScreen(),
        const Center(child: Text("EmptyTab")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _makeAppBar(),
        drawer: _makeDrawer(),
        body: _makeTabBarView(),
      ),
    );
  }
}
