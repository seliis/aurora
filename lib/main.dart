import "package:flutter/material.dart";

void main() {
  runApp(const Diana());
}

class Diana extends StatelessWidget {
  const Diana({super.key});

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
    return const TabBarView(
      children: [
        MapScreen(),
        Center(child: Text("EmptyTab")),
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

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("MapScreen"));
  }
}
