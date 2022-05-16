import 'package:flutter/material.dart';

typedef void StringCallback(String val);

class InputSection extends StatefulWidget {
  final StringCallback onAddClicked;

  const InputSection({required this.onAddClicked, Key? key}) : super(key: key);

  @override
  _InputSectionState createState() => _InputSectionState();
}

class _InputSectionState extends State<InputSection> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Row(children: [
            SizedBox(
              width: 250,
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  hintText: "Write a task",
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide:
                        const BorderSide(color: Color(0xFFC0C0C0), width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: const BorderSide(
                      color: Color(0xFFC0C0C0),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              height: 60,
            )),
            InkWell(
                onTap: () {
                  widget.onAddClicked(textController.text);
                  textController.clear();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFC0C0C0),
                          width: 1,
                        ),
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60))),
                    child: const Center(
                      child: Text('+'),
                    )))
          ]),
        ));
  }
}
