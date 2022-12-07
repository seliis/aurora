import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:window_manager/window_manager.dart";
import "package:flutter/material.dart";
import "package:aurora/map/map.dart";
import "package:aurora/udp/udp.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(
    const WindowOptions(
      center: true,
    ),
    () async {
      await windowManager.focus();
      await windowManager.show();
    },
  );

  runApp(const ProviderScope(child: Aurora()));
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

class MainFrame extends StatefulWidget {
  const MainFrame({super.key});

  @override
  MainFrameWidget createState() => MainFrameWidget();
}

class MainFrameWidget extends State<MainFrame> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    _initStateAsync();
    super.initState();
  }

  void _initStateAsync() async {
    await windowManager.setPreventClose(true);
    await UDP.initServer();
    setState(() {});
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    if (await windowManager.isPreventClose()) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Exit Aurora?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await UDP.quitServer();
                  await windowManager.destroy();
                },
                child: const Text("Yes"),
              )
            ],
          );
        },
      );
    }
  }

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
