import 'package:baitafome/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:baitafome/models/type.dart';
import '../dao/database.dart';
import 'package:flutter/services.dart';

class ViewRecipeDialog extends StatefulWidget {
  final int recipeId;
  String? op;

  ViewRecipeDialog({required this.recipeId});

  @override
  _ViewRecipeDialogState createState() => _ViewRecipeDialogState();
}

class _ViewRecipeDialogState extends State<ViewRecipeDialog> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();

  List<Type>? allowedTypes;
  Type? selectedType;
  Recipe? recipe;

  @override
  void initState() {
    super.initState();
    loadAllowedTypes();
    loadRecipeDetails(widget.recipeId);
  }

  // CARREGA TIPOS DO BANCO DE DADOS
  Future<void> loadAllowedTypes() async {
    final database = await $FloorAppDatabase.databaseBuilder('baitafome.db').build();
    final typeDao = database.typeDao;
    allowedTypes = await typeDao.findAllTypes();
    setState(() {});
  }

  Future<void> loadRecipeDetails(int recipeId) async {
    final database = await $FloorAppDatabase.databaseBuilder('baitafome.db').build();
    final recipeDao = database.recipeDao;    

    recipe = await recipeDao.findRecipeById(widget.recipeId);
    selectedType = allowedTypes?.firstWhere((type) => type.id == recipe?.type);

    idController.text = recipe?.id.toString() ?? '';
    nameController.text = recipe?.description ?? '';
    descriptionController.text = recipe?.description ?? '';
    ingredientsController.text = recipe?.ingredients ?? '';    

    setState(() {});
  }

  // DELETAR RECEITA DO BANCO DE DADOS
  void deleteRecipe(int idReceita) async {
    final database = await $FloorAppDatabase.databaseBuilder('baitafome.db').build();
    final recipeDao = database.recipeDao;

    Recipe? recipe = await recipeDao.findRecipeById(idReceita);
    recipeDao.deleteRecipe(recipe!);
  }

  // SALVAR RECEITA NO BANCO DE DADOS
  /*void saveRecipe() async {
    final database = await $FloorAppDatabase.databaseBuilder('baitafome.db').build();
    final recipeDao = database.recipeDao;

    final recipe = Recipe(
      name: nameController.text,
      description: descriptionController.text,
      type: selectedType?.id,
      ingredients: ingredientsController.text,
    );
    await recipeDao.insertRecipe(recipe);
  }*/

  // VALIDAR SE A RECEITA TEM AS INFORMAÇÕES NECESSÁRIAS
  /*void validateRecipe() {
    if (selectedType != null && descriptionController.text.isNotEmpty && nameController.text.isNotEmpty) {
      saveRecipe();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Receita adicionada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ops, parece que você esqueceu de preencher alguns campos! A receita não foi salva!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Informações da Receita:'),
      content: Container(
        width: 540,
        height: 600,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    controller: idController,
                    maxLength: 5,
                    maxLines: 1,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'ID',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      counter: SizedBox.shrink(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),                    
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 4,
                  child: TextField(
                    controller: nameController,
                    maxLength: 30,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      counter: SizedBox.shrink(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              maxLines: 2,
              maxLength: 100,
              decoration: InputDecoration(
                labelText: 'Descrição',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                counter: SizedBox.shrink(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.deny('\n'),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<Type>(
                isExpanded: true,
                icon: const Icon(Icons.receipt),
                decoration: InputDecoration(
                  labelText: 'Tipo da Receita',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                value: selectedType,
                onChanged: (Type? value) {
                  setState(() {
                    selectedType = value;
                  });
                },
                items: allowedTypes?.map((Type type) {
                      return DropdownMenuItem<Type>(
                        value: type,
                        child: Text(type.description),
                      );
                    }).toList() ??
                    [],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: ingredientsController,
              maxLines: 10,
              maxLength: 1000,
              decoration: InputDecoration(
                labelText: 'Ingredientes / Modo de Preparo',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                counter: SizedBox.shrink(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
              'Sair',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
              'Salvar',
              style: TextStyle(
                color: Colors.green,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          onPressed: () {
            //validateRecipe();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
              'Excluir',
              style: TextStyle(
                color: Colors.red,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          onPressed: () {
            deleteRecipe(widget.recipeId);
            Navigator.of(context).pop('E');
          },
        ),
      ],
    );
  }
}


