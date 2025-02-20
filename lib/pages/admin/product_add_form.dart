import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/common_widgets/toast_show.dart';
import 'package:fluttermangsir/providers/product/product_provider.dart';
import 'package:fluttermangsir/shared/image_provider.dart';
import 'package:fluttermangsir/shared/validators.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

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
    final mode = ref.watch(validateModeProvider(id:3));
    final image = ref.watch(imageProviderProvider);
    final productState = ref.watch(productsStateProvider);

    ref.listen(productsStateProvider, (prev, next){
      next.maybeWhen(
          data: (d) {
            ref.invalidate(getProductsProvider);
            context.pop();
            showToast(context, 'successfully product added');
          },
          error: (err,st) => showToast(context, '$err'),
          orElse: () => null
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FormBuilder(
          autovalidateMode: mode,
          key: _form,
          child: ListView(
            children: [
              FormBuilderTextField(
                name: 'title',
                decoration: InputDecoration(
                  hintText: 'Title'
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 15,),
              FormBuilderTextField(
                  name: 'price',
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Price'
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),

              const SizedBox(height: 15,),
              FormBuilderDropdown<String>(
                name: 'category',
                initialValue: 'mobile',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
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
                ),
                items: brands.map((e){
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 15,),
              FormBuilderTextField(
                  name: 'description',
                decoration: InputDecoration(
                    hintText: 'Description',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),

              ),
              const SizedBox(height: 25,),

              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder()
                ),
                  onPressed: (){
                  ref.read(imageProviderProvider.notifier).pickAnImage();
                  }, child: Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
                ),
                child:image == null ?  Center(child:  Text('pick an image')): Image.file(File(image.path)),
              )),

              const SizedBox(height: 25,),

              ElevatedButton(
                  onPressed: productState.isLoading ? null: (){
                    FocusScope.of(context).unfocus();
                    if(_form.currentState!.saveAndValidate(focusOnInvalid: false)){
                      final map = _form.currentState!.value;
                      if(image == null){
                        showToast(context, 'please select an image');

                      }else{
                        ref.read(productsStateProvider.notifier).addProduct(map: map, image: image);
                      }


                    }else{
                      ref.read(validateModeProvider(id: 3).notifier).change();

                    }

                  }, child: productState.isLoading ? Center(child: CircularProgressIndicator()): Text('Submit')
              )

            ],
          ),
        ),
      ),
    );
  }
}
