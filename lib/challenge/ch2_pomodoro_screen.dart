import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toonflix/challenge/constants/gaps.dart';

class Ch2PomodoroScreen extends StatefulWidget {
  const Ch2PomodoroScreen({super.key});

  @override
  State<Ch2PomodoroScreen> createState() => _Ch2PomodoroScreenState();
}

class _Ch2PomodoroScreenState extends State<Ch2PomodoroScreen> {
  static int fiveMinute = 300;
  static int _selectedIndex = 2; // 기본값은 3번째 버튼 (index = 2)
  //int totalSeconds = buttonLabels[_selectedIndex] * 60;
  int totalSeconds = 2; //지워야
  bool isRunning = false;
  bool isRest = false;
  int totalPomodoros = 0;
  int totalGoal = 0;
  final ScrollController _scrollController = ScrollController();
  static List<int> buttonLabels = [15, 20, 25, 30, 35];
  late Timer timer;
  // 버튼 5개의 상태를 관리하는 리스트 (true: 활성화, false: 비활성화)
  final List<bool> _isButtonActive = [
    false,
    false,
    true,
    false,
    false
  ]; // 3번째 버튼 활성화 상태로 시작

  // 버튼을 클릭했을 때 상태를 업데이트하는 함수
  void _handleButtonClick(int index) {
    setState(() {
      _selectedIndex = index;
      for (int i = 0; i < _isButtonActive.length; i++) {
        _isButtonActive[i] = (i == index);
      }
    });
    _scrollToCenter(index);
    totalSeconds = buttonLabels[_selectedIndex] * 60;
  }

  void _scrollToCenter(int index) {
    _scrollController.animateTo(
      (index * 92) + 20,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        //totalSeconds = buttonLabels[_selectedIndex] * 60;
        totalSeconds = 2; //지워야
        if (totalPomodoros == 4) {
          totalGoal = totalGoal + 1;
          totalPomodoros = 0;
          onRest();
        }
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onRest() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    totalSeconds = fiveMinute;
    setState(() {
      isRunning = true;
      isRest = true;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      isRest = false;
    });
  }

  void onRestart() {
    timer.cancel();
    setState(() {
      totalPomodoros = 0;
      isRunning = false;
      isRest = false;
      totalSeconds = buttonLabels[_selectedIndex] * 60;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);

    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  void initState() {
    super.initState();

    // 처음에 3번째 버튼이 중앙에 위치하도록 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenter(2); // 3번째 버튼을 중앙에 배치 (index 2)
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7626C),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Fully rest for 5min",
                  style: TextStyle(
                    color: isRest
                        ? Colors.white.withOpacity(1)
                        : Colors.white.withOpacity(0),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  format(totalSeconds),
                  style: const TextStyle(
                    color: Color(0xFFF4EDDB),
                    fontSize: 89,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 170,
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () => _handleButtonClick(index),
                            child: AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 300,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 17,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: _isButtonActive[index]
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: _isButtonActive[index]
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                  width: 3,
                                ),
                              ),
                              child: Text(
                                '${buttonLabels[index]}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: _isButtonActive[index]
                                      ? Theme.of(context).primaryColor
                                      : Colors.white,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        width: 170,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                IconButton(
                  iconSize: 120,
                  color: const Color(0xFFF4EDDB),
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(
                    isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                  iconSize: 65,
                  color: Theme.of(context).canvasColor,
                  onPressed: onRestart,
                  icon: const Icon(Icons.restart_alt_rounded),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4EDDB),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$totalPomodoros/4',
                                  style: const TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF232B55),
                                  ),
                                ),
                                Gaps.v12,
                                const Text(
                                  'Pomodoros',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF232B55),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$totalGoal/12',
                                  style: const TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF232B55),
                                  ),
                                ),
                                Gaps.v12,
                                const Text(
                                  'GOAL',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF232B55),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
