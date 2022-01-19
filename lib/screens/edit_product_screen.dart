import 'package:flutter/material.dart';
import 'package:online_shop/models/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  final _imageForm = GlobalKey<FormState>();

  var _product = Product(
    id: '',
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Rasm URLni kiriting.'),
          content: Form(
            key: _imageForm,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Rasm URL',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              onSaved: (newValue) {
                _product = Product(
                  id: '',
                  title: _product.title,
                  description: _product.description,
                  price: _product.price,
                  imageUrl: newValue!,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('BEKOR QILISH'),
            ),
            ElevatedButton(
              onPressed: () => _saveImageForm,
              child: const Text('SAQLASH'),
            ),
          ],
        );
      },
    );
  }

  void _saveImageForm() {
    _imageForm.currentState!.save();
    print(_product.imageUrl);
    Navigator.of(context).pop();
  }

  void _saveForm() {
    _form.currentState!.save();
    print(_product.title);
    print(_product.description);
    print(_product.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mahsulot qo\'shish'),
        actions: [
          IconButton(
            onPressed: () => _saveForm(),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: GestureDetector(
        onDoubleTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nomi',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (newValue) {
                    _product = Product(
                      id: '',
                      title: newValue!,
                      description: _product.description,
                      price: _product.price,
                      imageUrl: _product.imageUrl,
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Narxi',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (newValue) {
                    _product = Product(
                      id: '',
                      title: _product.title,
                      description: _product.description,
                      price: double.parse(newValue!),
                      imageUrl: _product.imageUrl,
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nomi',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (newValue) {
                    _product = Product(
                      id: '',
                      title: _product.title,
                      description: newValue!,
                      price: _product.price,
                      imageUrl: _product.imageUrl,
                    );
                  },
                ),
                const SizedBox(height: 10),
                Card(
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => _showImageDialog(context),
                    splashColor:
                        Theme.of(context).primaryColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5),
                    highlightColor: Colors.transparent,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text('Asosiy rasm URL-ni kiriting.'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
