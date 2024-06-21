import './coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './networking.dart';
import './constants.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currency = 'AUD';

  dynamic btcRate = 0;
  dynamic ethRate = 0;
  dynamic ltcRate = 0;

  Future<void> getRates() async {
    print('$url/BTC/$currency?apikey=$apiKey');
    var btcData =
        await NetworkHelper('$url/BTC/$currency?apikey=$apiKey').getData();
    var ethData =
        await NetworkHelper('$url/ETH/$currency?apikey=$apiKey').getData();
    var ltcData =
        await NetworkHelper('$url/LTC/$currency?apikey=$apiKey').getData();
    setState(() {
      btcRate = btcData['rate'].toInt();
      ethRate = ethData['rate'].toInt();
      ltcRate = ltcData['rate'].toInt();
    });
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        setState(() {
          currency = currenciesList[selectedIndex];
          btcRate = '?';
          ethRate = '?';
          ltcRate = '?';
        });
        await getRates();
        setState(() {});
      },
      children:
          currenciesList.map((String currency) => Text(currency)).toList(),
    );
  }

  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
      value: currency,
      items: currenciesList
          .map((String currency) => DropdownMenuItem<String>(
                child: Text(currency),
                value: currency,
              ))
          .toList(),
      onChanged: (value) async {
        setState(() {
          currency = value.toString();
          btcRate = '?';
          ethRate = '?';
          ltcRate = '?';
        });
        await getRates();
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $btcRate $currency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $ethRate $currency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $ltcRate $currency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
// DropdownButton<String>(
//               value: currency,
//               items: currenciesList
//                   .map((String currency) => DropdownMenuItem<String>(
//                         child: Text(currency),
//                         value: currency,
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   currency = value.toString();
//                 });
//               },
//             ),