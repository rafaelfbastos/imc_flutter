// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:imc/widgets/imc_gauge_range.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomRadialGauge extends StatelessWidget {
  final double imc;

  const CustomRadialGauge({
    Key? key,
    required this.imc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showLabels: false,
          showAxisLine: false,
          showTicks: false,
          minimum: 15,
          maximum: 45,
          ranges: [
            ImcGaugeRange(
                color: const Color(0XFF85C440),
                start: 15,
                end: 18.5,
                label: "Magreza"),
            ImcGaugeRange(
                color: const Color(0XFFAECF36),
                start: 18.5,
                end: 25,
                label: "Normal"),
            ImcGaugeRange(
                color: const Color(0XFFF89A1E),
                start: 25,
                end: 30,
                label: "Sobrepeso"),
            ImcGaugeRange(
                color: const Color(0XFFF36D23),
                start: 30,
                end: 35,
                label: "Obesidade grau I"),
            ImcGaugeRange(
                color: const Color(0XFFC5161D),
                start: 35,
                end: 40,
                label: "Obesidade grau II"),
            ImcGaugeRange(
                color: const Color(0XFF504F50),
                start: 40,
                end: 45,
                label: "Obesidade grau III"),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: imc,
              enableAnimation: true,
              animationDuration: 1000,
            )
          ],
        )
      ],
    );
  }
}
