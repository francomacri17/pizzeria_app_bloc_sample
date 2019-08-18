import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria_app_bloc/src/blocs/bloc.dart';
import 'package:pizzeria_app_bloc/src/blocs/provider.dart';

class Pizzeria extends StatelessWidget {
  var pizzaNamne = '';

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of(context);
    return Scaffold(
        appBar: AppBar(title: Text("Antiono's pizza")),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[menu1(_bloc), menu2(_bloc), orderInfo(_bloc)],
          ),
        ));
  }

  menu1(Bloc bloc) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
                child: Text('Napolitana'),
                onPressed: () {
                  bloc.newOrder('Napolitana');
                  pizzaNamne = 'Napolitana';
                }),
          ),
          Container(
            margin: EdgeInsets.only(left: 2.0, right: 2.0),
          ),
          Expanded(
            child: RaisedButton(
                child: Text('Cheddar'),
                onPressed: () {
                  bloc.newOrder('Cheddar');
                  pizzaNamne = 'Cheddar';
                }),
          )
        ],
      ),
    );
  }

  menu2(Bloc bloc) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              child: Text('Sushi'),
              onPressed: () {
                bloc.newOrder('Sushi');
                pizzaNamne = 'Sushi';
              },),
          ),
          Container(
            margin: EdgeInsets.only(left: 2.0, right: 2.0),
          ),
          Expanded(
            child: RaisedButton(
                child: Text('Carbonara'),
                onPressed: () {
                  bloc.newOrder('Carbonara');
                  pizzaNamne = 'Carbonara';
                }),
          )
        ],
      ),
    );
  }

  orderInfo(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.showOrders,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    snapshot.data,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                  ),
                  Text(
                      'Listo! Recoge tu pizza ${pizzaNamne}'
                  )
                ]);
          } else if (snapshot.hasError) {
            return Column(
              children: <Widget>[
                Image.network(
                  'http://megatron.co.il/en/wp-content/uploads/sites/2/2017/11/out-of-stock.jpg',
                  fit: BoxFit.fill,),
                Text(
                    snapshot.error,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0
                    )
                )
              ],
            );
          }
          else {
            return Text(
                'No pizza'
            );
          }
        });
  }
}
