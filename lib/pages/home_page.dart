import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500; // 25 min default
  int remainingSeconds = 1500;
  Timer? timer;
  double progress = 0.0;

  double selectedMinutes = 25;

  void startPomodoro() {
    timer?.cancel();

    if (selectedMinutes <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Insira um tempo válido em minutos")),
      );
      return;
    }

    totalSeconds = (selectedMinutes * 60).toInt();
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Pomodoro finalizado!")));
      }
    });
  }

  void stopPomodoro() {
    timer?.cancel();
    setState(() {
      remainingSeconds = totalSeconds;
      progress = 0.0;
    });
  }

  String get timeFormatted {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pomodoro Timer")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container quadrado com borda arredondada
            Container(
              padding: const EdgeInsets.all(24),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: progress.clamp(0.0, 1.0)),
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
                        progressColor: Colors.deepOrange,
                        backgroundColor: Colors.grey.shade300,
                        circularStrokeCap: CircularStrokeCap.round,
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Slider para definir o tempo
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Tempo do Pomodoro: ${selectedMinutes.toInt()} min",
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Slider(
                        min: 1,
                        max: 60,
                        divisions: 59,
                        value: selectedMinutes,
                        label: "${selectedMinutes.toInt()} min",
                        onChanged: (value) {
                          if (timer?.isActive ?? false) {
                            return; // bloqueia slider se timer ativo
                          }
                          setState(() {
                            selectedMinutes = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Botões em linha: Parar (esquerda) e Iniciar (direita)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: stopPomodoro,
                    child: const Text("Parar"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: startPomodoro,
                    child: const Text("Iniciar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
