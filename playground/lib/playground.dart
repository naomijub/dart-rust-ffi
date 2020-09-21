import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef sum_even = Int32 Function(Pointer<Int32> a, Int32 size);
typedef SumEven = int Function(Pointer<Int32> a, int size);

void main() {
  final path = 'libprocessor.dylib';
  final dylib = DynamicLibrary.open(path);
  List<int> pDart = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final p = intListToArray(pDart);

  final natVecSumEven = dylib.lookup<NativeFunction<sum_even>>('vecSumEven');
  final vecSumEven = natVecSumEven.asFunction<SumEven>();
  print('${vecSumEven(p, pDart.length)}');
}

Pointer<Int32> intListToArray(List<int> list) {
  final ptr = allocate<Int32>(count: list.length);
  for (var i = 0; i < list.length; i++) {
    ptr.elementAt(i).value = list[i];
  }
  return ptr;
}
