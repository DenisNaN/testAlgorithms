
import 'dart:math';

void main(){
  List<int> listForSearch = List.generate(1000000000, (index) => index + 1, growable: false);
  int elementToSearch = 766988999;
  TestAplgorithms testAplgorithms = TestAplgorithms();

  testAplgorithms.durationForAlgorithms('Linear Search', listForSearch, elementToSearch, testAplgorithms.linearSearch);
  testAplgorithms.durationForAlgorithms('Binary Search', listForSearch, elementToSearch, testAplgorithms.binarySearch);
  testAplgorithms.durationForAlgorithms('Jump Search', listForSearch, elementToSearch, testAplgorithms.jumpSearch);
  testAplgorithms.durationForAlgorithms('Interpolation Search', listForSearch, elementToSearch, testAplgorithms.interpolationSearch);

  DateTime dateStart = DateTime.now();
  int pos = testAplgorithms.exponentialSearch(listForSearch, listForSearch.length, elementToSearch);
  DateTime dateFinish = DateTime.now();
  Duration duration = dateFinish.difference(dateStart);
  print('Exponential Search. Position: $pos. duration: ${duration.inMicroseconds}');
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

  int binarySearch1(List<int> list, int l, int r, int x) {
    while (l <= r) {
      int m = l + (r - l) ~/ 2;

      if (list[m] == x) {
        return m;
      }

      if (list[m] < x) {
        l = m + 1;
      } else {
        r = m - 1;
      }
    }

    return -1;
  }

  int exponentialSearch(List<int> list, int n, int x) {
    // mengecek jika nilai x muncul di awal
    if (list[0] == x) return 0;

    int i = 1;
    while (i < n && list[i] <= x) i = i * 2;

    //  panggil binary search untuk mencari range
    return binarySearch1(list, 0, n - 1, x);
  }
  
  void durationForAlgorithms(String nameFunction, List array, int i, int Function(List array, dynamic elementToSearch) linearSearch){
    DateTime dateStart = DateTime.now();
    int pos = linearSearch(array, i);
    DateTime dateFinish = DateTime.now();
    Duration duration = dateFinish.difference(dateStart);
    print('$nameFunction. Position: $pos. duration: ${duration.inMicroseconds}');
  }
}