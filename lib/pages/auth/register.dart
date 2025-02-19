import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/common_widgets/toast_show.dart';
import 'package:fluttermangsir/providers/auth/sign_up_provider.dart';
import 'package:fluttermangsir/shared/validators.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {

  final _form = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {


    ref.listen(signUpProvider, (prev, next){
      next.maybeWhen(
          data: (d) {
            context.pop();
            showToast(context, 'successfully registered');
          },
          error: (err,st) => showToast(context, '$err'),
          orElse: () => null
      );
    });



    final pass = ref.watch(passShowProvider(id: 2));
    final mode = ref.watch(validateModeProvider(id: 2));
    final signUpState = ref.watch(signUpProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FormBuilder(
            autovalidateMode:mode,
            key: _form,
            child: ListView(
              children: [
                FormBuilderTextField(
                  name: 'username',
                  decoration: InputDecoration(
                      hintText: 'Username'
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20,),
                FormBuilderTextField(
                  name: 'email',
                  decoration: InputDecoration(
                      hintText: 'Email'
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                const SizedBox(height: 20,),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: pass,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: (){
                        ref.read(passShowProvider(id: 2).notifier).toggle();
                      }, icon: Icon(Icons.lock)),
                      hintText: 'Password'
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(5),
                  ]),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(onPressed: (){
                      context.pop();
                    }, child: Text('Login'))
                  ],
                ),
                const SizedBox(height: 30,),
                ElevatedButton(onPressed: signUpState.isLoading ? null: (){
                  FocusScope.of(context).unfocus();
                  if(_form.currentState!.saveAndValidate(focusOnInvalid: false)){
                    final map = _form.currentState!.value;
                    ref.read(signUpProvider.notifier).registerUser(map);

                  }else{
                    ref.read(validateModeProvider(id: 2).notifier).change();

                  }

                }, child: signUpState.isLoading ? CircularProgressIndicator(): Text('Submit'))
              ],
            )
        ),
      ),
    );
  }
}
