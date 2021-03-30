import 'package:flutter/material.dart';
import 'package:flutter_posv1/models/table_model.dart';

class TableCard extends StatelessWidget {
  const TableCard({Key key, this.tableModel}) : super(key: key);
  final TableModel tableModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: tableModel.isOpen ? Colors.teal : Colors.grey,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Icon(
                Icons.face_rounded,
                color: Colors.amber,
                size: 70,
              ),
            ),
            Text(
              tableModel.tableNumber,
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
