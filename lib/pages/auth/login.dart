import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermangsir/common_widgets/toast_show.dart';
import 'package:fluttermangsir/providers/auth/login_provider.dart';
import 'package:fluttermangsir/routes/route_enum.dart';
import 'package:fluttermangsir/shared/validators.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {

  final _form = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {




    final pass = ref.watch(passShowProvider(id: 1));
    final mode = ref.watch(validateModeProvider(id: 1));
    final loginState = ref.watch(loginProviderProvider);

    ref.listen(loginProviderProvider, (prev, next){
      next.maybeWhen(
          data: (d) => showToast(context, 'successfully login'),
          error: (err,st) => showToast(context, '$err'),
          orElse: () => null
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FormBuilder(
          autovalidateMode:mode,
          key: _form,
            child: ListView(
              children: [
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
                      ref.read(passShowProvider(id: 1).notifier).toggle();
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
                    Text('Don\'t have an account?'),
                    TextButton(onPressed: (){
                      context.pushNamed(AppRoute.register.name);
                    }, child: Text('Sign Up'))
                  ],
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                    onPressed: loginState.isLoading ? null: (){
                  FocusScope.of(context).unfocus();
                  if(_form.currentState!.saveAndValidate(focusOnInvalid: false)){
                    final map = _form.currentState!.value;
                  ref.read(loginProviderProvider.notifier).loginUser(map);
                  }else{
                    ref.read(validateModeProvider(id: 1).notifier).change();

                  }

                }, child: loginState.isLoading ? CircularProgressIndicator() :Text('Submit'))
              ],
            )
        ),
      ),
    );
  }
}
