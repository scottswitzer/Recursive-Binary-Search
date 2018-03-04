# Recursive Binary Search
This is an assembly program written in the ARMv7 instruction set to exercise the ARM calling conventions. The interface is designed such that the user can run it on the ARM Cortex-A9 onboard the DE1-SoC.

The program implements the binary search function in C as defined below:
```
int binary_search(int *numbers, int key, int startIndex, int endIndex, int NumCalls) {
  
  int middleIndex = startIndex + (endIndex - startIndex)/2;
  int keyIndex;
  NumCalls++;
  
  if (startIndex > endIndex)
    return -1;
  
  else if (numbers[middleIndex] == key)
    keyIndex = middleIndex;
  
  else if (numbers[middleIndex] > key)
    keyIndex = binary_search(numbers, key, startIndex, middleIndex-1, NumCalls);
 
  else
    keyIndex = binary_search(numbers, key, middleIndex+1, endIndex, NumCalls);
  
  numbers[ middleIndex ] = -NumCalls;
  
  return keyIndex;
}
```
