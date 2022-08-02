import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class BottomNavigationBarWidget extends ConsumerWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return BottomNavigationBar(  
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex: ref.watch(Providers.bottomNavBarIndexProvider),
      onTap: (value) {
        ref.read(Providers.bottomNavBarIndexProvider.state).state = value;
      },
      items: const [
        BottomNavigationBarItem(label: 'Ana Sayfa', icon: Icon(Icons.home,)),
        BottomNavigationBarItem(label: 'Filtre', icon: Icon(Icons.filter)),
        BottomNavigationBarItem(label: 'İstatistik', icon: Icon(Icons.numbers)),
      ],
    );
  }
}
