import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_app/controller/todo_provider.dart';
import 'package:to_do_list_app/model/todo_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() {
    return _ToDoApp();
  }
}

class _ToDoApp extends State<ToDoApp> {
  //TextEditingControllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  //Global Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// submitTask Function
  void submitTask(bool isEdit, [ToDoListModel? toDoListModelObj]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!isEdit) {
        Provider.of<TodoProvider>(context, listen: false).addTask(ToDoListModel(
            title: titleController.text,
            description: descriptController.text,
            date: dateController.text,
            isComplete: false));
      } else {
        toDoListModelObj!.title = titleController.text.trim();
        toDoListModelObj.description = descriptController.text.trim();
        toDoListModelObj.date = dateController.text.trim();
        Provider.of<TodoProvider>(context, listen: false)
            .updateToDoTask(toDoListModelObj);
      }
    }
    clearController();
  }

//To edit Task
  void editTask(ToDoListModel toDoListModelObj) {
    titleController.text = toDoListModelObj.title;
    descriptController.text = toDoListModelObj.description;
    dateController.text = toDoListModelObj.date;
    showBottomSheet(true, toDoListModelObj);
  }

//To Clear all TextEditingcontrollers

  void clearController() {
    titleController.clear();
    descriptController.clear();
    dateController.clear();
  }

// Function For display BottomSheet

  void showBottomSheet(bool isEdit, [ToDoListModel? toDoListModelObj]) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 15,
                  //To avoid the keyboard overlap the screen
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Create Task",
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Title",
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: titleController,
                            style: Theme.of(context).textTheme.titleSmall,
                            cursorColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Description",
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: descriptController,
                            style: Theme.of(context).textTheme.titleSmall,
                            cursorColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Date",
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: dateController,
                            style: Theme.of(context).textTheme.titleSmall,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.date_range_rounded),
                            ),
                            cursorColor: Theme.of(context).primaryColor,
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2024),
                                  lastDate: DateTime(2025));
                              String formatDate =
                                  DateFormat.yMMMd().format(pickedDate!);
                              dateController.text = formatDate;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      isEdit
                          ? submitTask(isEdit, toDoListModelObj)
                          : submitTask(isEdit);
                      Navigator.pop(context);
                    },
                    child: Text("Submit",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final cardList = todoProvider.todoList;
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 30, top: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Good morning",
                    style: Theme.of(context).textTheme.displaySmall),
                Text("Ankita",
                    style: Theme.of(context).textTheme.displayMedium),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "CREATE TO DO LIST",
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(top: 40),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
      //Task display
                        child: ListView.builder(
                            itemCount: cardList.length,
                            itemBuilder: ((context, index) {
                              return Slidable(
                                closeOnScroll: true,
                                endActionPane: ActionPane(
                                  extentRatio: 0.2,
                                  motion: const DrawerMotion(),
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              editTask(cardList[index]);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(0, 139, 148, 1),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Icon(Icons.edit,
                                                  color: Colors.white,
                                                  size: 20),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              todoProvider.deleteToDoTask(
                                                  cardList[index]);
                                              cardList.removeAt(index);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(0, 139, 148, 1),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Icon(Icons.delete,
                                                  color: Colors.white,
                                                  size: 20),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.05),
                                          width: 0.5),
                                      boxShadow: const [
                                        BoxShadow(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.13),
                                            offset: Offset(0, 4),
                                            blurRadius: 20)
                                      ]),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 52,
                                        width: 52,
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                217, 217, 217, 1),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Image.asset(
                                          "assets/images/Group.png",
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          width: 23,
                                          height: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(cardList[index].title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(cardList[index].description,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontSize: 10,
                                                      color:
                                                          const Color.fromRGBO(
                                                              0, 0, 0, 0.7),
                                                    )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(cardList[index].date,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontSize: 10,
                                                      color:
                                                          const Color.fromRGBO(
                                                              0, 0, 0, 0.7),
                                                    ))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Checkbox(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          activeColor: Colors.green,
                                          value: cardList[index].isComplete,
                                          onChanged: (val) {
                                            todoProvider.toggleTaskCompletion(
                                                cardList[index]);
                                          })
                                    ],
                                  ),
                                ),
                              );
                            }))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheet(false);
          },
          backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
          foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
          child: const Icon(
            Icons.add,
            size: 46,
          )),
    );
  }
}
