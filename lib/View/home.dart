import 'dart:math';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:imc/widgets/custom_radial_gauge.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var pesoEC = TextEditingController();
  var alturaEC = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var imc = 0.0;

  Future<double> _calcularImc(
      {required double altura, required double peso}) async {
    if (imc != 0) {
      setState(() {
        imc = 0;
      });
    }

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      imc = peso / pow(altura, 2);
    });

    return imc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomRadialGauge(imc: imc),
                Visibility(
                  child: Text(
                    "Imc = ${imc.toStringAsFixed(2)}",
                    style:
                        GoogleFonts.acme(fontSize: 16, color: Colors.blue[800]),
                  ),
                  visible: (imc > 0),
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: pesoEC,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Peso Obrigatorio";
                            }
                          },
                          decoration: const InputDecoration(
                            label: Text("Peso"),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            CurrencyTextInputFormatter(
                                locale: "pt_BR",
                                symbol: "",
                                decimalDigits: 2,
                                turnOffGrouping: true)
                          ],
                        ),
                        TextFormField(
                          controller: alturaEC,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Altura Obrigatorio";
                            }
                          },
                          decoration: const InputDecoration(
                            label: Text("Altura"),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            CurrencyTextInputFormatter(
                                locale: "pt_BR",
                                symbol: "",
                                decimalDigits: 2,
                                turnOffGrouping: true)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              var formValid =
                                  formKey.currentState?.validate() ?? false;

                              if (formValid) {
                                var formatter = NumberFormat.simpleCurrency(
                                    locale: "pt_BR", decimalDigits: 2);

                                var peso =
                                    formatter.parse(pesoEC.text) as double;
                                var altura =
                                    formatter.parse(alturaEC.text) as double;

                                _calcularImc(altura: altura, peso: peso);
                              }
                            },
                            child: const Text("Calcular IMC"))
                      ],
                    ))
              ],
            ),
          )),
        ));
  }
}
