import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TextFieldQuantityProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TextFieldQuantitySelector(),
      ),
    );
  }
}

class TextFieldQuantityProvider with ChangeNotifier {
  int quantity = 1;

  void setQuantity(int newQuantity) {
    quantity = newQuantity;
    notifyListeners();
  }
}

class TextFieldQuantitySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextFieldQuantityProvider provider =
        Provider.of<TextFieldQuantityProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TextField Quantity Selector',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<int>(
            borderRadius: BorderRadius.circular(20),dropdownColor: Colors.white70,
            value: provider.quantity,
            items: List.generate(10, (index) => index + 1).map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value Text Fields'),
              );
            }).toList(),
            onChanged: (newValue) {
              provider.setQuantity(newValue!);
            },
          ),
          SizedBox(height: 20),
          Text('Selected Quantity: ${provider.quantity}'),
          SizedBox(height: 20),
          TextFieldsContainer(quantity: provider.quantity),
        ],
      ),
    );
  }
}

class TextFieldsContainer extends StatelessWidget {
  final int quantity;

  TextFieldsContainer({required this.quantity});

  @override
  Widget build(BuildContext context) {
    List<Widget> textFields = List.generate(quantity, (index) {
      return TextField(
        decoration: InputDecoration(labelText: 'Text Field ${index + 1}'),
      );
    });

    return Column(
      children: textFields,
    );
  }
}
