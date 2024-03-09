import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/view/single_choice_segment.dart';
import 'package:todo_list/view_model/todo_list_view_model.dart';

class ToDoListView extends StatefulWidget {
  const ToDoListView({Key? key}) : super(key: key);

  @override
  State<ToDoListView> createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView> {
  int? segmentedControlValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ToDoListViewModel(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo List'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView(),
              ),
            ],
          ),
          floatingActionButton: Consumer<ToDoListViewModel>(
            builder: (context, model, child) {
              return FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return bottomSheet(context, model);
                    },
                  );
                },
                backgroundColor: Color.fromRGBO(230, 200, 245, 1),
                child: const Icon(Icons.add),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }

  Widget bottomSheet(BuildContext maincontext, ToDoListViewModel model) {
  return SingleChildScrollView(
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(maincontext).pop();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    // Save logic
                    Navigator.of(maincontext).pop();
                  },
                ),
              ],
            ),
            const TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: "Content",
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(230, 200, 245, 1)), // 聚焦时的底线颜色
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Importance',
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10),
            const SingleChoice(),
          ],
        ),
      ),
    ),
  );
}

}
