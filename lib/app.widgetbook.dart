import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const KnobsExample());
}

class KnobsExample extends StatelessWidget {
  const KnobsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: "light",
              data: ThemeData.light(),
            ),
            WidgetbookTheme(
              name: "dark",
              data: ThemeData.dark(),
            ),
          ],
        ),
        TextScaleAddon(
          scales: [
            1.0,
            1.25,
            1.5,
          ],
        ),
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhone13,
            Devices.android.samsungGalaxyNote20Ultra,
            Devices.ios.iPad12InchesGen4,
            Devices.windows.laptop,
          ],
          initialDevice: Devices.ios.iPhone13,
        ),
      ],
      directories: [
        WidgetbookCategory(
          name: 'Pages',
          children: [
            WidgetbookComponent(
              name: 'Onboarding',
              useCases: [
                WidgetbookUseCase(
                  name: 'Home Page',
                  builder: (context) => MyHomePage(
                    title: context.knobs
                        .string(label: 'Title', initialValue: 'Title'),
                    incrementBy: context.knobs.doubleOrNull
                            .slider(
                                label: 'Increment By',
                                min: 0,
                                initialValue: 5,
                                max: 10,
                                divisions: 10)
                            ?.toInt() ??
                        0,
                    countLabel: context.knobs.stringOrNull(
                      label: 'Count Label',
                      initialValue: 'Current Count',
                      description:
                          'This is the text that appears above the current count of increments',
                    ),
                    iconData: context.knobs.list(
                      label: 'Icon',
                      options: [
                        Icons.add,
                        Icons.crop_square_sharp,
                        Icons.circle
                      ],
                    ),
                    showToolTip: context.knobs.boolean(
                      label: 'Show Increment Tool Tip',
                      description:
                          'This is the tooltip that is displayed when hovering over the increment button',
                      initialValue: true,
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookFolder(
              name: "Button Folder",
              children: [
                WidgetbookComponent(
                  name: 'button',
                  useCases: [
                    WidgetbookUseCase(
                      name: 'Elevated Button',
                      builder: (_) => Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Button"),
                        ),
                      ),
                    ),
                    WidgetbookUseCase(
                      name: 'Text Button',
                      builder: (_) => Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Button"),
                        ),
                      ),
                    ),
                    WidgetbookUseCase(
                      name: 'Outlined Button',
                      builder: (_) => Center(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Button"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      appBuilder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    this.incrementBy = 1,
    this.countLabel,
    this.iconData,
    this.showToolTip = true,
  }) : super(key: key);

  final String title;
  final int incrementBy;
  final String? countLabel;
  final IconData? iconData;
  final bool showToolTip;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += widget.incrementBy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.countLabel ??
                  'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: widget.showToolTip ? 'Increment' : null,
        child: Icon(widget.iconData ?? Icons.add),
      ),
    );
  }
}
