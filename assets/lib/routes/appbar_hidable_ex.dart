import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';

class HidableBtmbarExample extends StatefulWidget {
  const HidableBtmbarExample({super.key});

  @override
  State<HidableBtmbarExample> createState() => _HidableBtmbarExampleState();
}

class _HidableBtmbarExampleState extends State<HidableBtmbarExample> {
  int _index = 0;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        controller: _scrollController, // !Explicitly specify the controller
        itemBuilder: (_, i) => Container(
          height: 80,
          color: Colors.primaries[i % Colors.primaries.length],
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemCount: 100,
      ),
      bottomNavigationBar: Hidable(
        controller: _scrollController, // !Use the same controller
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          items: bottomBarItems(),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> bottomBarItems() {
    return [
      BottomNavigationBarItem(
        label: 'Home',
        icon: const Icon(Icons.home, color: Colors.white),
        backgroundColor: Colors.amber.withOpacity(.9),
      ),
      BottomNavigationBarItem(
        label: 'Favorites',
        icon: const Icon(Icons.favorite, color: Colors.white),
        backgroundColor: Colors.blue.withOpacity(.9),
      ),
      BottomNavigationBarItem(
        label: 'Profile',
        icon: const Icon(Icons.person, color: Colors.white),
        backgroundColor: Colors.green.withOpacity(.9),
      ),
      BottomNavigationBarItem(
        label: 'Settings',
        icon: const Icon(Icons.settings, color: Colors.white),
        backgroundColor: Colors.purple.withOpacity(.9),
      ),
    ];
  }
}
