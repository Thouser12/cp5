import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  String nome = '';
  final peopleNumController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: <Widget>[
          buildEmail(),
          const SizedBox(
            height: 24,
          ),
          buildPassword(),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              //validar o form

              //Acessar o form
              bool valid = _formKey.currentState!.validate();

              if (valid) {
                print('Nome: $nome');
                print('NumPessoas: ${peopleNumController.text}');
                Navigator.push(context, MaterialPageRoute(builder: (context) => ValidSubmit(nome)));
              }
            },
            child: const Text('Reservar'),
          )
        ],
      ),
    );
  }

  Widget buildEmail() => TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Obrigatório informar um nome!';
          }
          if (value.length < 4 ){
            return 'O nome deve conter mais do que 4 caracteres!';
          }
          return null;
        },
        controller: nameController,
        onChanged: (value) {
          nome = value;
        },
        decoration: InputDecoration(
          hintText: 'Nome e sobrenome',
          labelText: 'Nome do Cliente',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              nameController.clear();
            },
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      );

  Widget buildPassword() => TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Obrigatório informar o número de pessoas!';
          }
          if ((int.parse(value) < 1) || (int.parse(value) > 20)) {
            return 'O número de pessoas deve estar entre 1 e 20!';
          }
          return null;
        },
        controller: peopleNumController,
        decoration: InputDecoration(
          hintText: '1-20',
          labelText: 'Número de pessoas',
          border: OutlineInputBorder(),
        ),
      );
}
class ValidSubmit extends StatelessWidget {
  const ValidSubmit(String nome, {super.key});
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: const Text('Mesa reservada para nome da pessoa'),
      ),
    );
  }
}

