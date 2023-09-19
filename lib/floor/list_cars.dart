import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistence_type/commons/constants.dart';
import 'package:persistence_type/commons/list_item.dart';
import 'package:persistence_type/floor/car_form.dart';
import 'package:persistence_type/floor/models/car.dart';

class ListCarWidget extends StatefulWidget {
  const ListCarWidget({super.key});

  @override
  State<ListCarWidget> createState() => _ListCarWidgetState();
}

class _ListCarWidgetState extends State<ListCarWidget> {
  List<Car> cars = [
    Car("Volkswagen", "Kombi"),
    Car("Ford", "Ka"),
    Car("Fiat", "Fiorino"),
    Car("Nissan", "March")
  ];

  @override
  Widget build(BuildContext context) {
    const title = Text("Carros");
    final carForm = CarFormWidget();

    return Scaffold(
        appBar: AppBar(
          title: title,
          actions: [
            IconButton(
                icon: addIcon,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => carForm));
                })
          ],
        ),
        body: buildList(context));
  }

  _onDeleteCar() {}

  Widget buildList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("cars").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          if (snapshot.data == null) {
            return const Text("Nenhum carro encontrado!");
          } else {
            return buildListView(context, snapshot.data!.docs);
          }
        });
  }

  Widget buildListView(
      BuildContext context, List<QueryDocumentSnapshot> snapshots) {
    return ListView(
      padding: const EdgeInsets.only(top: 30),
      children: snapshots.map((data) => _buildItem(context, data)).toList(),
    );
  }

  Widget _buildItem(BuildContext context, QueryDocumentSnapshot data) {
    Car c = Car.fromSnapshot(data);
    return Padding(
        padding: const EdgeInsets.all(12),
        child: ListItemWidget(
            leading: "1",
            title: c.brand,
            subtitle: c.model,
            longPress: _onDeleteCar));
  }
}
