import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final String text;
  final String id;
  final GestureTapCallback onPressed;

  const TaskWidget(
      {required this.text, required this.id, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onPressed.call();
        },
        child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
                height: 54,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          color: const Color(0xFF218165).withOpacity(0.4),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(text),
                    Expanded(child: Container()),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF218165),
                            width: 2,
                          ),
                          color: Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                    )
                  ]),
                ))));
  }
}
