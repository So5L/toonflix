import 'package:flutter/material.dart';
import 'package:toonflix/challenge/constants/gaps.dart';
import 'package:toonflix/challenge/constants/sizes.dart';

class Ch1Screen extends StatefulWidget {
  const Ch1Screen({super.key});

  @override
  State<Ch1Screen> createState() => _Ch1ScreenState();
}

class _Ch1ScreenState extends State<Ch1Screen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size24,
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          foregroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/3612017",
                          ),
                          child: Text("니꼬"),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: Sizes.size36,
                        )
                      ],
                    ),
                    Gaps.v24,
                    Text(
                      "MONDAY 16",
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        color: Colors.white,
                      ),
                    ),
                    Gaps.v12,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            "TODAY",
                            style: TextStyle(
                              fontSize: Sizes.size44,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "*17 18 19 20 21 22 23 24 25 26 27 28 29 30 31",
                            style: TextStyle(
                              fontSize: Sizes.size40,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Schedule(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              startHour: "11",
              startMin: "30",
              endHour: "12",
              endMin: "20",
              nameOfSchedule: "DESIGN MEETING",
              color: Colors.pink,
            ),
            Gaps.v10,
            Schedule(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              startHour: "11",
              startMin: "30",
              endHour: "12",
              endMin: "20",
              nameOfSchedule: "DAILY PROJECT",
              color: Colors.green,
            ),
            Gaps.v10,
            Schedule(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              startHour: "11",
              startMin: "30",
              endHour: "12",
              endMin: "20",
              nameOfSchedule: "WEEKLY PLANNING",
              color: Colors.yellow,
            ),
            Gaps.v10,
            Schedule(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              startHour: "11",
              startMin: "30",
              endHour: "12",
              endMin: "20",
              nameOfSchedule: "MONTHLY PLANNING",
              color: Colors.amber,
            ),
            Gaps.v10,
          ],
        ),
      ),
    );
  }
}

class Schedule extends StatelessWidget {
  const Schedule(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.startHour,
      required this.startMin,
      required this.endHour,
      required this.endMin,
      required this.nameOfSchedule,
      required this.color
      // required joiner,
      });

  final double screenWidth;
  final double screenHeight;
  final String startHour;
  final String startMin;
  final String endHour;
  final String endMin;
  final String nameOfSchedule;
  final Color color;
  // List<String> joiner;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 1.0,
      height: screenHeight * 0.23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size32,
        ),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: Sizes.size28,
          left: Sizes.size20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  startHour,
                  style: const TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  startMin,
                  style: const TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "|",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  endHour,
                  style: const TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  endMin,
                  style: const TextStyle(
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: Sizes.size24,
                bottom: Sizes.size16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth * 0.81,
                    child: Text(
                      nameOfSchedule,
                      // softWrap: true,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: Sizes.size56,
                        fontWeight: FontWeight.w500,
                        height: 0.9,
                      ),
                    ),
                  ),
                  Gaps.v20,
                  const Row(
                    children: [
                      Text(
                        "ALEX",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      Gaps.h12,
                      Text(
                        "HELENA",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      Gaps.h12,
                      Text(
                        "NANA",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      Gaps.h12,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
