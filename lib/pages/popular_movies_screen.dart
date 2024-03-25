import 'package:appnew/pages/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:appnew/models/popular_model.dart';
import 'package:appnew/network/api_popular.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  ApiPopular? apiPopular;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DashboardScreen(),
        appBar: AppBar(
          elevation: 0,
          title: const Text("Movies"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: apiPopular!.getPopularMovie(),
          builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/detail",
                        arguments: snapshot.data![index]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/loading1.gif'),
                        image: NetworkImage(
                            "https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}"),
                      ),
                    ),
                  );
                },
              );
            } else {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Ocurrio un error :"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          },
        ));
  }
}
