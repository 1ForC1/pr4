import 'package:flutter/material.dart';
import 'cubit/click_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<String> text = [];
int count = 0;
String themeName = "Light";
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwitchCubit>(
      create: (context) => SwitchCubit(),
      child: BlocBuilder<SwitchCubit, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.theme,
              home: BlocProvider(
                create: (context) => ClickCubit(),
                child: MyHomePage(),
              ));
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Вы нажали на кнопку столько раз',
            ),
            BlocBuilder<ClickCubit, ClickState>(
              builder: (context, state) {
                if (state is ClickError) {
                  return Text(
                    state.message,
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
                if (state is Click) {
                  if (text.isNotEmpty) {
                    if (count != state.count) {
                      text.add(state.count.toString() + " - " + state.theme);
                    }
                  } else {
                    text.add(state.count.toString() + " - " + state.theme);
                  }
                  count = state.count;
                  context.read<SwitchCubit>().toggleSwitch(null, false);
                  return Text(
                    state.count.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
                return Container();
              },
            ),
            BlocBuilder<SwitchCubit, SwitchState>(
              builder: (context, state) {
                return Switch(
                  value: state.isDarkThemeOff,
                  onChanged: (newValue) {
                    context.read<SwitchCubit>().toggleSwitch(newValue, true);
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.read<ClickCubit>().onClick(1);
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  onPressed: () {
                    context.read<ClickCubit>().onClick(-1);
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 400,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: text.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BlocBuilder<ClickCubit, ClickState>(
                          builder: (context, state) {
                            if (state is Click) {
                              return Text(text[index],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium);
                            }
                            return Container();
                          },
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
