import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<String> categories = ['mobile', 'laptop', 'tv', 'camera', 'clothes'];
const List<String> brands = ['apple', 'samsung', 'oppo', 'hp', 'dell', 'gucci', 'adidas'];
class ProductAddForm extends ConsumerStatefulWidget {
  const ProductAddForm({super.key});

  @override
  ConsumerState createState() => _ProductAddFormState();
}

class _ProductAddFormState extends ConsumerState<ProductAddForm> {
  final _form = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FormBuilder(
          key: _form,
          child: ListView(
            children: [
              FormBuilderTextField(
                name: 'title',
                decoration: InputDecoration(
                  hintText: 'Title'
                ),
              ),
              const SizedBox(height: 15,),
              FormBuilderTextField(
                  name: 'price',
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Price'
                ),
              ),

              const SizedBox(height: 15,),
              FormBuilderDropdown<String>(
                name: 'category',
                initialValue: 'mobile',
                decoration: InputDecoration(
                    hintText: 'Category',
                ),
                items: categories.map((e){
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
              ),

              FormBuilderDropdown<String>(
                name: 'brand',
                initialValue: 'apple',
                decoration: InputDecoration(
                  hintText: 'Category',
                ),
                items: brands.map((e){
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15,),
              FormBuilderTextField(
                  name: 'description',
                decoration: InputDecoration(
                    hintText: 'Description',
                ),

              ),

            ],
          ),
        ),
      ),
    );
  }
}
