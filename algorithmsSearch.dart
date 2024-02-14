
import 'dart:math';

void main(){
  List listForSearch = List.generate(1000000000, (index) => index + 1, growable: false);
  int elementToSearch = 766988999;
  TestAplgorithms testAplgorithms = TestAplgorithms();

  testAplgorithms.durationForAlgorithms('Linear Search', listForSearch, elementToSearch, testAplgorithms.linearSearch);
  testAplgorithms.durationForAlgorithms('Binary Search', listForSearch, elementToSearch, testAplgorithms.binarySearch);
  testAplgorithms.durationForAlgorithms('Jump Search', listForSearch, elementToSearch, testAplgorithms.jumpSearch);
  testAplgorithms.durationForAlgorithms('Interpolation Search', listForSearch, elementToSearch, testAplgorithms.interpolationSearch);
}

class TestAplgorithms{

  int linearSearch(List array, elementToSearch){
    for(int i = 0; i < array.length; i++){
      if(array[i] == elementToSearch) return i;
    }
    return -1;
  }

  int binarySearch(List array, elementToSearch) {
  int leftIndex = 0;
  int rightIndex = array.length - 1;

  while (leftIndex <= rightIndex) {
    int middleIndex = ((leftIndex + rightIndex) / 2).round();
    if (array[middleIndex] == elementToSearch) {
      return middleIndex;
    } else {
      if (array[middleIndex] < elementToSearch)
        leftIndex = middleIndex + 1;
      else {
        rightIndex = middleIndex - 1;
      }
    }
  }
  return -1;
  }

  int jumpSearch(List array, elementToSearch){
    int jumpStep = sqrt(array.length).round();
    int previousStep = 0;

    while (array[min(jumpStep, array.length) - 1] < elementToSearch) {
      previousStep = jumpStep;
      jumpStep += sqrt(array.length).round();
      if (previousStep >= array.length)
        return -1;
    }
    while (array[previousStep] < elementToSearch) {
      previousStep++;
      if (previousStep == min(jumpStep, array.length))
        return -1;
    }

    if (array[previousStep] == elementToSearch)
      return previousStep;
    return -1;
  }

  int interpolationSearch(List array, elementToSearch){
    int indexA = 0;
    int indexB = array.length - 1;

    while(elementToSearch > array[indexA] &&
      elementToSearch < array[indexB]){
      if(indexA == indexB) break;

      int pos = (indexA + (((indexB - indexA) /
          (array[indexB] - array[indexA])) *
          (elementToSearch - array[indexA]))).round();

      if(array[pos] == elementToSearch) return pos;
      if(array[pos] < elementToSearch) indexA = pos + 1;
      else indexB = pos - 1;
    }

    if(array[indexA] == elementToSearch) return indexA;
    if(array[indexB] == elementToSearch) return indexB;

    return - 1;
  }
  
  void durationForAlgorithms(String nameFunction, List array, int i, int Function(List array, dynamic elementToSearch) linearSearch){
    DateTime dateStart = DateTime.now();
    int pos = linearSearch(array, i);
    DateTime dateFinish = DateTime.now();
    Duration duration = dateFinish.difference(dateStart);
    print('$nameFunction. Position: $pos. duration: ${duration.inMicroseconds}');
  }
}