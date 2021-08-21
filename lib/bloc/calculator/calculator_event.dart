part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class ResetAc extends CalculatorEvent{}

class AddNumber extends CalculatorEvent{

  final String number;

  AddNumber(this.number);

}

class ChangeNegativePositive extends CalculatorEvent{}

class DeleteLastEntry extends CalculatorEvent{}

class OperationsEntry extends CalculatorEvent{
  final String oparation;

  OperationsEntry(this.oparation);
}

class CalculateResult extends CalculatorEvent{}