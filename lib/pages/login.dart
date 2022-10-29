import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/bloc/login/login_bloc.dart';
import 'package:marketplace/utils/colors.dart';
import 'package:marketplace/widgets/custom_buttom.dart';
import 'package:marketplace/widgets/custom_inputs.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _lastName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const CustomText(
                      text: 'APROVECHA\n LOS MEJORES PRECIOS', size: 20),
                  const CustomText(
                      text: 'QUE TENEMOS PARA TI',
                      fontWeight: FontWeight.normal),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: grey, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        const CustomText(text: 'INGRESA TU NOMRE', size: 15),
                        const CustomText(
                            text: 'y obten descuentos exclusivos', size: 13),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            style: TextStyle(color: black),
                            decoration: CustomInputs.loginInputDecoration(
                                isPrefixIcon: false, hint: 'Nombre'),
                            validator: (value) {
                              this._name = value;
                              return (value == null || value.isEmpty)
                                  ? 'Nombre invalido'
                                  : null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            style: TextStyle(color: black),
                            decoration: CustomInputs.loginInputDecoration(
                                isPrefixIcon: false, hint: 'Apellido'),
                            validator: (value) {
                              this._lastName = value;
                              return (value == null || value.isEmpty)
                                  ? 'apellidos invalido'
                                  : null;
                            },
                          ),
                        ),
                        BlocConsumer<LoginBloc, LoginBlocState>(
                          listener: (context, state) {
                            if (state is Loaded) {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          builder: (context, state) {
                            return CustomOutlinedButton(
                              isFilled: true,
                              onPressed: () => onformSubmit(),
                              text: 'Ingresar',
                              loading: state is Loading,
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/people.png',
                      width: 250,
                      height: 250,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void onformSubmit() {
    if (_formKey.currentState!.validate()) {
      context
          .read<LoginBloc>()
          .add(LoginByName(name: _name!, lastName: _lastName!));
    }
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight? fontWeight;

  const CustomText(
      {required this.text, this.size = 17, this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: primary,
          fontSize: size,
          fontWeight: fontWeight,
        ));
  }
}
