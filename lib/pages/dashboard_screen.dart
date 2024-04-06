import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:appnew/settings/app_value_notifier.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150')),
            accountName: Text('Nom. Usuario'),
            accountEmail: Text('uncorreo@gmail.com'),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Añadir receta'),
            subtitle: Text('Compárte tus propias recetas'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, '/recetario');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Peliculas'),
            subtitle: Text('Ver las peliculas'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, '/movies');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Peliculas Favoritas'),
            subtitle: Text('Ver las peliculas'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, '/moviesf');
            },
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text('Salir'),
            subtitle: Text('Hasta luego'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          DayNightSwitcher(
            isDarkModeEnabled: AppValueNotifier.themeNotifier.value,
            onStateChanged: (isDarkModeEnabled) {
              AppValueNotifier.themeNotifier.value = isDarkModeEnabled;
              AppValueNotifier.banTheme.value = isDarkModeEnabled;
            },
          ),
        ],
      ),
    );
  }
}
