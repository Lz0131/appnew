import 'package:flutter/material.dart';
import 'package:appnew/pages/onboarding_screen.dart';
import 'package:appnew/pages/LoginPage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:appnew/pages/dashboard_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  io.File? imagen;
  final picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Clave global para el formulario

  String _username = '';
  String _email = '';
  String _password = '';
  String _confirm_password = '';
  String password = '';

  Future selImagen(int op) async {
    var pickedFile;
    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        imagen = io.File(pickedFile.path);
      } else {
        print("No seleccionaste ninguna foto");
      }
    });

    Navigator.of(context).pop();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Si los campos son válidos, se guarda el formulario
      _formKey.currentState!.save();

      // Aquí puedes hacer lo que necesites con los datos del formulario
      print('Username: $_username');
      print('Email: $_email');
      print('Password: $_password');
      print('Confirm Password: $_confirm_password');

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
    }
  }

  Opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      selImagen(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.purple))),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Tomar una foto",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.camera_alt,
                            color: Colors.purple,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selImagen(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.purple))),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Seleccionar una foto",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.image,
                            color: Colors.purple,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration:
                          BoxDecoration(color: Colors.red.withOpacity(0.9)),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Cancelar",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Icon(
                            Icons.cancel,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              // height: MediaQuery.of(context).size.height - 10,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 10.0),
                        const Text(
                          "SigUp",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Crea tu cuenta",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Opciones(context);
                      },
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.purple,
                        backgroundImage:
                            imagen == null ? null : FileImage(imagen!),
                        child: imagen == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    /*
                    Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Opciones(context);
                              },
                              child: const Text(
                                "Seleccionar Foto",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                backgroundColor: Colors.purple,
                              )),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                imagen == null ? null : FileImage(imagen!),
                            child: imagen == null
                                ? Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          //imagen == null ? Center() : Image.file(imagen!)
                        ],
                      ),
                    ), */
                    Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Nombre de usuario",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none),
                              fillColor: Colors.purple.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.person)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Porfavor ingresa tu nombre de \nusuario';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _username = value!;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Correo",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none),
                              fillColor: Colors.purple.withOpacity(0.1),
                              filled: true,
                              prefixIcon: const Icon(Icons.email)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Porfavor ingresa tu correo';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Por favor ingresa un correo \nelectrónico válido';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Contraseña",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.password),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese la contraseña';
                            }
                            if (value.length < 8) {
                              return 'La contraseña debe tener al menos 8 caracteres';
                            }
                            if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(value)) {
                              return 'La contraseña debe contener \nal menos: \nUna letra mayúscula\nUna minúscula \nUn número \nUn carácter especial';
                            }
                            password = value!;
                            return null;
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Confirma la contraseña",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none),
                            fillColor: Colors.purple.withOpacity(0.1),
                            filled: true,
                            prefixIcon: const Icon(Icons.password),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Porfavor Ingresa la contraseña';
                            }
                            if (value != password) {
                              return 'Las contraseñas no coinciden';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _confirm_password = value!;
                          },
                        ),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 3, left: 3),
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text(
                            "Registrar",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            backgroundColor: Colors.purple,
                          ),
                        )),
                    const Center(child: Text("O")),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.purple,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30.0,
                              width: 30.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/login_signup/google.png'),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 18),
                            const Text(
                              "Registrar con Google",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Ya tienes cuenta?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.purple),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
