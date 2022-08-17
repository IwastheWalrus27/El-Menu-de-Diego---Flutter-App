import 'package:flutter/material.dart';

void main() {
  


  runApp(RootWidget());
}
class RootWidget extends StatefulWidget {
  static ValueNotifier changed = ValueNotifier(false);
  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  //lista de recetas
  static List<Recetas> listRecipes = [
    Recetas('Huevo duro', 'Se hierve por 40 minutos en agua...', ["Huevo"], ["Poner agua en una olla", "Conseguir huevos"]),
    Recetas('Arroz con leche', 'Se deja hervir con 30 minutos el arroz en agua...',["Arroz", "Leche"], ["Poner agua en una olla", "Conseguir arroz"]),
    Recetas('Tacos de frijol', 'Se embarra una cucharada de frijol en una tortilla de harina',["Frijol","Tortilas"], ["Poner agua en una olla", "Conseguir frijoles"]),
  ];
  


  @override
  void initState(){
    RootWidget.changed.addListener(() {
      setState(() {
        
      });
     });
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Builder(
        builder: (context)=> Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,    
          title: Center(
            child: Text("Recetas"),
          ),
        ),

        body: Center(
          child: Column(
            children: <Widget>[
                    Expanded(
                      child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context,index)=> Divider(color:Colors.black),
                      itemCount: listRecipes.length,
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          title: Text(listRecipes[index].name),
                          leading: IconButton(
                            icon:Icon(Icons.menu, color:Colors.grey),
                            //Cambiar de pantalla a la descripcion de la receta
                            onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context)=>RecipeDesc(index)
                                    )
                                );
                            },
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //Boton de poner favorito
                                IconButton(
                                icon: listRecipes[index].fav? Icon(Icons.star, color: Color.fromARGB(255, 213, 196, 44),): Icon(Icons.star, color: Colors.grey,),
                                onPressed: (){
                                  setState(() {
                                    listRecipes[index].fav = !listRecipes[index].fav;
                                  });
                                },
                              ),
                              //Boton para eliminar
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red,),
                                onPressed: (){
                                  setState(() {
                                    listRecipes.removeAt(index);
                                  },);
                                },
                              )
                            ],
                          )

                        );
                      }
                      
                      ),
                  ),
                  Row(
                    children: [
                      //TextButton(onPressed: (){}, child: Text("+ Add recipe")),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child:                       FloatingActionButton.extended(
                        backgroundColor:Color.fromARGB(255, 210, 130, 10) ,
                        icon: Icon(Icons.add,),
                        label: Text("Receta"),
                        onPressed: (){
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context)=>RecipeForms()
                                  )
                                    
                                    
                                );
                        }
                      ),
                      )

                    ],
                  )
            ],
          ),
        ),
      ),
      )
      
    );
  }


}


class Recetas{
  String name ="";
  String dsc ="";
  List<String> ingredients = [];
  List<String> steps = [];
  bool fav = false;
  Recetas(name,dsc, ingredients, steps){
    this.name = name;
    this.dsc = dsc;
    this.ingredients = ingredients;
    this.steps = steps;
  }



}



class RecipeDesc extends StatefulWidget {
  int index = 0;
  RecipeDesc(int index){
    this.index = index;
  }

  @override
  State<RecipeDesc> createState() => _RecipeDescState(index);
}

class _RecipeDescState extends State<RecipeDesc> {
  int index = 0;
  _RecipeDescState(int index){
    this.index = index;
  }
  List<bool> isIngredientChecked = [];
  List<bool> isStepChecked = [];

  // int currRecipeIngLen = 0;
  // int currRecipeStepLen = 0;
  // @override
  // void initState() {
  //   currRecipeIngLen = _RootWidgetState.listRecipes[index].ingredients.length;
  //   currRecipeStepLen = _RootWidgetState.listRecipes[index].steps.length;
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  void initState() {
    setState(() {
      
    });
    super.initState();
  }


  //Necesitamos la info de nombre y descripcion de la receta
  //con tener el index me basta, y esto lo voy a pasar a traves del constructor del boton
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    for(int i = 0; i< _RootWidgetState.listRecipes[index].ingredients.length; i++){
      isIngredientChecked.add(false);
    }

    for(int i = 0; i< _RootWidgetState.listRecipes[index].steps.length; i++){
      isStepChecked.add(false);
    }
  

    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 213, 128, 0),  
          title: Center(
            child: Text('Descripción de la receta de ' + _RootWidgetState.listRecipes[index].name)
          ),
          actions: [
            IconButton(
              onPressed: (() {
                isIngredientChecked = [];
                isStepChecked = [];
                
              Navigator.pop(context);
            }),
             icon: Icon(Icons.arrow_back)
          )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 16,),
              FormsTitle("Lista de ingredientes"),

              Expanded(
                
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _RootWidgetState.listRecipes[index].ingredients.length,
                  itemBuilder: (BuildContext context, int ingredientIndex){
                    
                    return ListTile(
                        title: Text(
                        // \u2022 es el valor de UTF para el bullet point
                        "\u2022 "+_RootWidgetState.listRecipes[index].ingredients[ingredientIndex],
                        style: TextStyle(
                          fontSize: 24,
                          decoration: isIngredientChecked[ingredientIndex]? TextDecoration.lineThrough : TextDecoration.none

                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.check,
                          color: isIngredientChecked[ingredientIndex]? Colors.green : Colors.grey
                          
                          ),
                        onPressed: (){
                          setState(() {
                            isIngredientChecked[ingredientIndex] = !isIngredientChecked[ingredientIndex];
                          });
                        },

                      ),
                    );
                  }
                  
                ),
              ),
              FormsTitle("Indicaciones"),
              Expanded(
                child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _RootWidgetState.listRecipes[index].steps.length,
                itemBuilder: (BuildContext context, int stepsIndex){
                  return ListTile(
                    title: Text(
                      (stepsIndex + 1).toString() + "- " +_RootWidgetState.listRecipes[index].steps[stepsIndex],
                      style: TextStyle(
                        fontSize: 24,
                        decoration: isStepChecked[stepsIndex]? TextDecoration.lineThrough : TextDecoration.none
                      ),
                      ),

                      trailing: IconButton(
                        icon: isStepChecked[stepsIndex]? Icon(Icons.check_circle, color: Colors.green) : Icon(Icons.check_circle_outline),
                        onPressed: (){
                          setState(() {
                            isStepChecked[stepsIndex] = !isStepChecked[stepsIndex];
                          });
                        },
                      ),
                  );
                }
                
                ),
              ),
              Text(
                ("Nota: " + _RootWidgetState.listRecipes[index].dsc),
                style: TextStyle(
                  fontSize: 24
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}


class RecipeForms extends StatefulWidget {

  @override
  State<RecipeForms> createState() => _RecipeFormsState();
}

class _RecipeFormsState extends State<RecipeForms> {

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  

  //Para los ingredientes
  List<String> ingredientsList = [];
  List<TextEditingController> controllersList = [TextEditingController()];
  int ingTextFieldsLen = 1;

  //Para los pasos
  List<String> stepsList = [];
  List<TextEditingController> stepsControllersList = [TextEditingController()];
  int stepTextFieldsLen = 1;



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Registro de receta")),
          backgroundColor: Color.fromARGB(255, 213, 128, 0),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        ),

        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                  label: Text("Nombre de la receta")
                  ),
            ),
            FormsTitle("Ingredientes"),
//Registro de lista de ingredientes
            Expanded(
              child:ListView.separated(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index){
                  return TextField(
                    controller: controllersList[index],
                    decoration: InputDecoration(  
                        border: OutlineInputBorder(),
                        hintText: "Ingrediente"
                    ),
                  );
                },
                separatorBuilder: (context, index)=> SizedBox(height: 4,),
                itemCount: ingTextFieldsLen
              ),
            ),


//Por aqui iria el boton que se encargaria de cambiar el tamano de ingTextFieldsLen
            TextButton(
              child: Text("Añadir ingrediente"),
              onPressed: (){
                setState(() {
                  ingTextFieldsLen++;
                  controllersList.add(TextEditingController());
                });
              },
            ),
//Indicaciones
            FormsTitle("Indicaciones"),
            
            Expanded(
              
              child:ListView.separated(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index){
                  return TextField(
                    controller: stepsControllersList[index],
                    decoration: InputDecoration(  
                        border: OutlineInputBorder(),
                        hintText: "Paso " + (index + 1).toString()
                    ),
                  );
                },
                separatorBuilder: (context, index)=> SizedBox(height: 4,),
                itemCount: stepTextFieldsLen
              ),
            ),
            TextButton(
              child: Text("Añadir paso"),
              onPressed: (){
                setState(() {
                  stepTextFieldsLen++;
                  stepsControllersList.add(TextEditingController());
                });
              },
            ),

//Se convertira en una nota mas bien, en lugar de una descripcion
            TextField(
              controller: _descController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                    
                    border: OutlineInputBorder(),
                    hintText: "Descripción de la receta"
                  ),
            ),
            SizedBox(height: 16,),
            FloatingActionButton.extended(
              foregroundColor: Colors.white,
              icon: Icon(Icons.border_color_outlined),
              label: Text("Guardar"),
              backgroundColor: Color.fromARGB(255, 217, 135, 12) ,
              onPressed: (){
                
                saveIngredients();
                saveSteps();
                _RootWidgetState.listRecipes.add(Recetas(_nameController.text, _descController.text, ingredientsList, stepsList));
                _nameController.text = "";
                _descController.text = "";
                setState(() {
                  ingTextFieldsLen = 1;
                  controllersList = [TextEditingController()];
                  ingredientsList = [];

                  stepTextFieldsLen = 1;
                  stepsControllersList = [TextEditingController()];
                  stepsList = [];

                });
                


                RootWidget.changed.notifyListeners();
              },
            )
          ],
        )
          
           
        


      ),
    );
  }


  void saveIngredients(){
    for(int i = 0; i<controllersList.length; i++){
      ingredientsList.add(controllersList[i].text);
    }
  }

  void saveSteps(){
    for(int i = 0; i<stepsControllersList.length; i++){
      stepsList.add(stepsControllersList[i].text);
    } 
  }

}


class FormsTitle extends StatelessWidget {
  String title = "";
  FormsTitle(title){
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            );
  }
}
