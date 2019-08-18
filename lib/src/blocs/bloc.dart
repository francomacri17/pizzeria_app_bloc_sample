import 'dart:async';
import 'package:rxdart/rxdart.dart';

class Bloc {

  // Pizzeria logic
  final orders = StreamController<String>();

  Stream<String> get showOrders => orders.stream.transform(validateOrder);

  // Menu de pizaa
  static final _pizzaList = { 'Sushi': 2, 'Napolitana': 10, 'Carbonara': 5, 'Cheddar': 9 };

  // images of the pizzas
  static final _pizzaImages = {
    'Sushi': "http://pngimg.com/uploads/pizza/pizza_PNG44077.png",
    'Napolitana': "http://pngimg.com/uploads/pizza/pizza_PNG44078.png",
    'Carbonara': "http://pngimg.com/uploads/pizza/pizza_PNG44081.png",
    'Cheddar': "http://pngimg.com/uploads/pizza/pizza_PNG44084.png"
  };

  // function validate & make a order
  final validateOrder = StreamTransformer<String, String>.fromHandlers(handleData: (order, sink){
    if(_pizzaList[order] != null){
      if(_pizzaList[order] > 0){
        sink.add(_pizzaImages[order]);
        final count = _pizzaList[order];
        _pizzaList[order] = count - 1;
      }
      else{
        sink.addError('No hay stock');
      }
    }
    else{
      sink.addError("Pizza no encontrada!");
    }
  });

  // Add new order
  void newOrder(String pizza){
    orders.sink.add(pizza);
  }
}