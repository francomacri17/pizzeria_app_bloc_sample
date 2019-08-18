import 'package:flutter/cupertino.dart';
import 'bloc.dart';

class Provider extends InheritedWidget{

  final bloc = Bloc();

  Provider({Key key, Widget child}): super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static Bloc of(BuildContext context){
    return(context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }

}