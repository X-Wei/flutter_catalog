import 'package:flutter/material.dart';

// Adapted from the data table demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/data_table_demo.dart
class DataTableExample extends StatefulWidget {
  const DataTableExample({Key key}) : super(key: key);

  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        header: const Text('Nutrition'),
        rowsPerPage: _rowsPerPage,
        availableRowsPerPage: const <int>[5, 10, 20],
        onRowsPerPageChanged: (int value) {
          setState(() {
            _rowsPerPage = value;
          });
        },
        columns: kTableColumns,
        source: DessertDataSource(),
      ),
    );
  }
}

////// Columns in table.
const kTableColumns = <DataColumn>[
  DataColumn(
    label: Text('Dessert (100g serving)'),
  ),
  DataColumn(
    label: Text('Calories'),
    tooltip: 'The total amount of food energy in the given serving size.',
    numeric: true,
  ),
  DataColumn(
    label: Text('Fat (g)'),
    numeric: true,
  ),
  DataColumn(
    label: Text('Carbs (g)'),
    numeric: true,
  ),
  DataColumn(
    label: Text('Protein (g)'),
    numeric: true,
  ),
  DataColumn(
    label: Text('Sodium (mg)'),
    numeric: true,
  ),
  DataColumn(
    label: Text('Calcium (%)'),
    tooltip:
        'The amount of calcium as a percentage of the recommended daily amount.',
    numeric: true,
  ),
  DataColumn(
    label: Text('Iron (%)'),
    numeric: true,
  ),
];

////// Data class.
class Dessert {
  Dessert(this.name, this.calories, this.fat, this.carbs, this.protein,
      this.sodium, this.calcium, this.iron);
  final String name;
  final int calories;
  final double fat;
  final int carbs;
  final double protein;
  final int sodium;
  final int calcium;
  final int iron;
  bool selected = false;
}

////// Data source class for obtaining row data for PaginatedDataTable.
class DessertDataSource extends DataTableSource {
  int _selectedCount = 0;
  final List<Dessert> _desserts = <Dessert>[
    Dessert('Frozen yogurt', 159, 6.0, 24, 4.0, 87, 14, 1),
    Dessert('Ice cream sandwich', 237, 9.0, 37, 4.3, 129, 8, 1),
    Dessert('Eclair', 262, 16.0, 24, 6.0, 337, 6, 7),
    Dessert('Cupcake', 305, 3.7, 67, 4.3, 413, 3, 8),
    Dessert('Gingerbread', 356, 16.0, 49, 3.9, 327, 7, 16),
    Dessert('Jelly bean', 375, 0.0, 94, 0.0, 50, 0, 0),
    Dessert('Lollipop', 392, 0.2, 98, 0.0, 38, 0, 2),
    Dessert('Honeycomb', 408, 3.2, 87, 6.5, 562, 0, 45),
    Dessert('Donut', 452, 25.0, 51, 4.9, 326, 2, 22),
    Dessert('KitKat', 518, 26.0, 65, 7.0, 54, 12, 6),
    Dessert('Frozen yogurt with sugar', 168, 6.0, 26, 4.0, 87, 14, 1),
    Dessert('Ice cream sandwich with sugar', 246, 9.0, 39, 4.3, 129, 8, 1),
    Dessert('Eclair with sugar', 271, 16.0, 26, 6.0, 337, 6, 7),
    Dessert('Cupcake with sugar', 314, 3.7, 69, 4.3, 413, 3, 8),
    Dessert('Gingerbread with sugar', 345, 16.0, 51, 3.9, 327, 7, 16),
    Dessert('Jelly bean with sugar', 364, 0.0, 96, 0.0, 50, 0, 0),
    Dessert('Lollipop with sugar', 401, 0.2, 100, 0.0, 38, 0, 2),
  ];

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _desserts.length) return null;
    final Dessert dessert = _desserts[index];
    return DataRow.byIndex(
        index: index,
        selected: dessert.selected,
        onSelectChanged: (bool value) {
          if (dessert.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            dessert.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text(dessert.name)),
          DataCell(Text('${dessert.calories}')),
          DataCell(Text(dessert.fat.toStringAsFixed(1))),
          DataCell(Text('${dessert.carbs}')),
          DataCell(Text(dessert.protein.toStringAsFixed(1))),
          DataCell(Text('${dessert.sodium}')),
          DataCell(Text('${dessert.calcium}%')),
          DataCell(Text('${dessert.iron}%')),
        ]);
  }

  @override
  int get rowCount => _desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
