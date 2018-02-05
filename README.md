# Recursive Binary Search
Implemented in the ARMv7 instruction set and following ARM calling conventions.

I assembled the function from C as defined below
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

Note that the assembly program is written such that the user can see it run on the DE1-SoC.
