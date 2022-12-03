import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppOpenClose extends StatelessWidget {
  const AppOpenClose({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          tooltip: "Minimize App",
          onPressed: () {
            windowManager.minimize();
          },
        ),
        
        IconButton(
          icon: const Icon(Icons.fullscreen),
          tooltip: "Maximize App",
          onPressed: () async {
            if (await windowManager.isFullScreen()==true){
              windowManager.setFullScreen(false);
            } else {
              windowManager.setFullScreen(true);
            }
          },
        ),
        
        IconButton(
          icon: const Icon(Icons.close),
          tooltip: "Close App",
          onPressed: () {
            windowManager.close();
          },
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}