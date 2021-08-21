import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  
  CalculatorBloc() : super(CalculatorState());

  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {
    
    //borrar todo
    if(event is ResetAc){
      yield* this._resetAc();

      //agregar numeros
    }else if(event is AddNumber){
      yield state.copyWith(
        mathResult: (state.mathResult == '0')
                      ? event.number
                      : state.mathResult + event.number,
      );

      //cambiar sigo + -
    }else if(event is ChangeNegativePositive){
      yield state.copyWith(
        mathResult: state.mathResult.contains('-')
                      ? state.mathResult.replaceFirst('-', '')
                      : '-' + state.mathResult
      );

      //borrar ultimo digito
    }else if(event is DeleteLastEntry){
      yield state.copyWith(
        mathResult: state.mathResult.length > 1
                      ? state.mathResult.substring(0, state.mathResult.length - 1)
                      : '0'
      );

      //agrgar operacion
    }else if(event is OperationsEntry){
      yield state.copyWith(
        firstNumber: state.mathResult,
        mathResult: '0',
        operation: event.oparation,
        secondNumber: state.secondNumber
      );

      //calcular resultado
    }else if(event is CalculateResult){
      yield* _calculateResult();
    }

  }

  Stream<CalculatorState> _resetAc() async* {

    yield CalculatorState(
        firstNumber: '0',
        mathResult: '0',
        secondNumber: '0',
        operation: '+',
    );
  }

  Stream<CalculatorState> _calculateResult() async* {

    final double num1 = double.parse(state.firstNumber);
    final double num3 = double.parse(state.mathResult);

    switch(state.operation){

      case '+':
        yield state.copyWith(
          mathResult: '${num1 + num3}'
        );
      break;


      default:
        yield state;
    }
  }

}  
