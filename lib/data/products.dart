import '../models/products.dart';

List<Product> getProducts() {
  List<Product> products = new List<Product>();
  Product productModel = new Product();

  productModel.imageUrl = 'assets/images/img1.png';
  productModel.details = "Cold and Cough";
  productModel.price = "100";
  productModel.name = "this is thing";
  products.add(productModel);

  productModel = new Product();

  productModel.imageUrl = 'assets/images/img1.png';
  productModel.details = "Cold and Cough";
  productModel.price = "100";
  productModel.name = "this is thing";
  products.add(productModel);

  productModel = new Product();

  productModel.imageUrl = 'assets/images/img1.png';
  productModel.details = "Cold and Cough";
  productModel.price = "100";
  productModel.name = "this is thing";
  products.add(productModel);

  productModel = new Product();

  productModel.imageUrl = 'assets/images/img1.png';
  productModel.details = "Cold and Cough";
  productModel.price = "100";
  productModel.name = "this is thing";
  products.add(productModel);

  productModel = new Product();
  productModel.imageUrl = 'assets/images/img1.png';
  productModel.details = "Cold and Cough";
  productModel.price = "100";
  productModel.name = "this is thing";
  products.add(productModel);

  productModel = new Product();

  return products;
}
