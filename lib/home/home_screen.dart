import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app_with_bloc/Favourite/favourite.dart';
import 'package:shoping_app_with_bloc/cart/cart.dart';
import 'package:shoping_app_with_bloc/home/bloc/home_bloc.dart';
import 'package:shoping_app_with_bloc/widgets/carousal_widgets.dart';
import 'package:shoping_app_with_bloc/widgets/grid_view.dart';
import 'package:shoping_app_with_bloc/widgets/snackbar.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homebloc = HomeBloc();
  int _currentIndex = 0;

  @override
  void initState() {
    homebloc.add(InitialfetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homebloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionButton) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const FavouriteScreen()));
        } else if (state is HomeNavigateToCartPageActionButton) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const Cartscreen()));
        } else if (state is SnackbarOfFavouritesAdd) {
          snackbar('Added to Favourite', context);
        } else if (state is SnackbarOfCartsAdd) {
          snackbar('Added to Cart', context);
        } else if (state is SnackbarOfCartRemove) {
          snackbar('Removed from Cart', context);
        } else if (state is SnackbarOfFavouriteRemove) {
          snackbar('Removed from Favourite', context);
        }
      },
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return _buildSkeleton();
        }
        switch (state.runtimeType) {
          case HomeLoadingState:
          case HomeLoadedSuccessState:
            final value = state as HomeLoadedSuccessState;

            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF2AB0A9),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(10),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Search Amazon.in',
                          filled: true,
                          contentPadding: const EdgeInsets.all(15.0),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: const Icon(
                            Icons.mic,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              body: _buildBody(state, value),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: const Color(0xFF2AB0A9),
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.black,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favourite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'Cart',
                  ),
                ],
              ),
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text(
                  'Error',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }

  Widget _buildBody(HomeState state, HomeLoadedSuccessState value) {
    switch (_currentIndex) {
      case 0:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: CrouselWidget(homebloc: homebloc, value: value),
            ),
            const Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Deals for you',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Ashi',
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            GridViewWidget(
              homebloc: homebloc,
              value: value,
            ),
          ],
        );
      case 1:
        return const FavouriteScreen();
      case 2:
        return const Cartscreen();
      default:
        return Container();
    }
  }

  Widget _buildSkeleton() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2AB0A9),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Container(
            margin: const EdgeInsets.only(bottom: 4.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Search Amazon.in',
                  filled: true,
                  contentPadding: const EdgeInsets.all(15.0),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(
                    Icons.mic,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 150,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Deals for you',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Ashi',
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF2AB0A9),
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
