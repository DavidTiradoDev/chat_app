import 'package:flutter/material.dart';
import 'package:chat_app/common/widgets/widgets.dart';
import 'package:chat_app/utils/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height * 0.9,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoWidget(title: 'Messenger'),
                _Form(),
                LabelWidget(
                  routeName: 'register',
                  title: '¿No tienes cuenta?',
                  subtitle: 'Crea una ahora!',
                ),
                Text(
                  'Términos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          TextFieldInput(
            autoCorrect: false,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            icons: Icons.mail_outline,
            hintText: 'Correo',
            textEditingController: emailController,
          ),
          TextFieldInput(
            autoCorrect: false,
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            icons: Icons.mail_outline,
            hintText: 'Contraseña',
            textEditingController: passwordController,
          ),
          SizedBox(height: 10),
          BlueButton(
            title: 'Ingresar',
            onTap: () {
              debugPrint('El correo es: ${emailController.text}');
              debugPrint('La contraseña es: ${passwordController.text}');
            },
          ),
        ],
      ),
    );
  }
}
