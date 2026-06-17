import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_viewmodel.dart';
import '../viewmodels/favorites_viewmodel.dart';
import 'product_details_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductViewModel>();
    final favViewModel = context.watch<FavoritesViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _buildBody(viewModel, favViewModel),
    );
  }

  Widget _buildBody(ProductViewModel viewModel, FavoritesViewModel favViewModel) {
    if (viewModel.state == AppState.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.state == AppState.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            Text(viewModel.errorMessage, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: viewModel.loadProducts, child: const Text('Tentar Novamente'))
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: viewModel.products.length,
      itemBuilder: (context, index) {
        final product = viewModel.products[index];
        final isFav = favViewModel.isFavorite(product.id);
        
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: product.image.isNotEmpty
                ? Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover)
                : const Icon(Icons.image),
            title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : null),
              onPressed: () => context.read<FavoritesViewModel>().toggleFavorite(product.id),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(product: product)));
            },
          ),
        );
      },
    );
  }
}