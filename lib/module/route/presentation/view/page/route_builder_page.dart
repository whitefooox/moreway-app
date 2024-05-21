import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/route/presentation/state/builder/route_builder_bloc.dart';

class RouteBuilderPage extends StatefulWidget {
  @override
  _RouteBuilderPageState createState() => _RouteBuilderPageState();
}

class _RouteBuilderPageState extends State<RouteBuilderPage> {
  late final RouteBuilderBloc _builderBloc;

  @override
  void initState() {
    super.initState();
    _builderBloc = BlocProvider.of<RouteBuilderBloc>(context);
  }

  List<String> attractions = [
    'Достопримечательность 1',
    'Достопримечательность 2',
    'Достопримечательность 3',
    'Достопримечательность 4',
  ];

  void _addAttraction(String attraction) {
    setState(() {
      attractions.add(attraction);
    });
  }

  void _removeAttraction(int index) {
    setState(() {
      attractions.removeAt(index);
    });
  }

  void _reorderAttraction(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String item = attractions.removeAt(oldIndex);
      attractions.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Конструктор'),
      ),
      body: BlocBuilder<RouteBuilderBloc, RouteBuilderState>(builder:(context, state) {
        if(state.routeStatus == LoadingStatus.loading){
          return Center(child: CircularProgressIndicator(),);
        } else if(state.routeStatus == LoadingStatus.success){
          return ListView.builder(
            itemCount: state.route!.points.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(state.route!.points[index].name),);
            },
          );
        } else {
          return Center(child: Text("Ошибка"),);
        }
      },),
      // body: ReorderableListView(
      //   children: <Widget>[
      //     for (int index = 0; index < attractions.length; index++)
      //       ListTile(
      //         key: Key('$index'),
      //         title: Text(attractions[index]),
      //         trailing: IconButton(
      //           icon: Icon(Icons.delete),
      //           onPressed: () => _removeAttraction(index),
      //         ),
      //       ),
      //   ],
      //   onReorder: _reorderAttraction,
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         String newAttraction = '';
      //         return AlertDialog(
      //           title: Text('Добавить достопримечательность'),
      //           content: TextField(
      //             onChanged: (value) {
      //               newAttraction = value;
      //             },
      //           ),
      //           actions: [
      //             TextButton(
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //                 _addAttraction(newAttraction);
      //               },
      //               child: Text('Добавить'),
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
