import 'package:clean_arch_ecommerce_app/presentation/bloc/product_bloc.dart';
import 'package:clean_arch_ecommerce_app/presentation/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/product_tile.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LoadedAllProductsState) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductTile(product: state.products[index]);
              },
            );
          } else if (state is ErrorState) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/product_form');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
