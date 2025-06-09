import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:studywithme/styles/theme_config.dart';
import 'package:studywithme/widgets/custon_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  int remainingSeconds = 1500;
  Timer? timer;
  double progress = 0.0;
  double selectedDuration = 1500; // segundos

  bool isDark = false;

  void toggleTheme() {
    setState(() {
      isDark = !isDark;
      ThemeConfig.temaApp = isDark ? 'dark' : 'light';
    });
  }

  /// Inicia o timer com o tempo selecionado
  void startPomodoro() {
    timer?.cancel();

    totalSeconds = selectedDuration.toInt();
    if (totalSeconds < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tempo mínimo é 10 segundos.")),
      );
      return;
    }

    remainingSeconds = totalSeconds;
    progress = 0.0;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
          progress = 1 - (remainingSeconds / totalSeconds);
        });
      } else {
        t.cancel();
        showDialog(
          context: context,
          builder: (context) {
            return CustomConfirmationDialog(
              mensagem: 'Pomodoro finalizado. Deseja reiniciar?',
              primeiraOpcao: 'Não',
              iconePrimeiraOpcao: Icons.close,
              sePrimeiraOpcaoClica: () {
                Navigator.pop(context);
                stopPomodoro();
              },
              segundaOpcao: 'Sim',
              iconeSegundaOpcao: Icons.refresh,
              seSegundaOpcaoClica: () {
                Navigator.pop(context);
                startPomodoro();
              },
            );
          },
        );
      }
    });
  }

  /// Para o timer e reseta valores
  void stopPomodoro() {
    timer?.cancel();
    setState(() {
      remainingSeconds = totalSeconds;
      progress = 0.0;
    });
  }

  /// Formata tempo restante como mm:ss
  String get timeFormatted {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  /// Formata o tempo selecionado para exibição no slider (ex: 5m 30s)
  String get selectedDurationFormatted {
    final minutes = (selectedDuration ~/ 60).toInt();
    final seconds = (selectedDuration % 60).toInt();
    return '${minutes}m ${seconds}s';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDark ? ThemeConfig.temaDark : ThemeConfig.temalight,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pomodoro Timer"),
          actions: [
            IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              tooltip: isDark ? 'Tema Claro' : 'Tema Escuro',
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400, width: 1.5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TweenAnimationBuilder<double>(
                            tween: Tween(
                              begin: 0.0,
                              end: progress.clamp(0.0, 1.0),
                            ),
                            duration: const Duration(milliseconds: 500),
                            builder: (context, value, child) {
                              return CircularPercentIndicator(
                                radius: 120.0,
                                lineWidth: 12.0,
                                percent: value,
                                center: Text(
                                  timeFormatted,
                                  style: const TextStyle(fontSize: 36),
                                ),
                                progressColor: Theme.of(context).primaryColor,
                                backgroundColor: Colors.grey.shade300,
                                circularStrokeCap: CircularStrokeCap.round,
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Tempo do Pomodoro: $selectedDurationFormatted",
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              Slider(
                                min: 10,
                                max: 3600,
                                divisions: 60 * 6, // divisões a cada 10s
                                value: selectedDuration,
                                label: selectedDurationFormatted,
                                onChanged: (value) {
                                  if (timer?.isActive ?? false) return;
                                  setState(() => selectedDuration = value);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Botões colados à base do container
                    Row(
                      children: [
                        Expanded(child: BotaoParar(onPressed: stopPomodoro)),
                        Expanded(child: BotaoIniciar(onPressed: startPomodoro)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BotaoParar extends StatelessWidget {
  final VoidCallback onPressed;

  const BotaoParar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: ThemeConfig.cinzaMedio, // cor cinza
      height: 60,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0)),
      ),
      child: const Center(
        child: Text(
          'Parar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class BotaoIniciar extends StatelessWidget {
  final VoidCallback onPressed;

  const BotaoIniciar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor, // cor primária do tema
      height: 60,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0)),
      ),
      child: const Center(
        child: Text(
          'Iniciar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
