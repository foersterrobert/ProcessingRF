float[] myList;
int idx = -1;

void setup() {
  size(152, 120);
  myList = new float[15];
  for (int i = 0; i < myList.length; i++) {
    myList[i] = random(100);
  }
}

void draw() {
  frameRate(10);
  background(200);
  for (int i = 0; i < myList.length; i++) {
    if (i == idx) {
      fill(random(255), random(255), random(255));
    }
    else {
      fill(255);
    }
    rect(i*10 + 2, 100-myList[i], 8, myList[i]);
  }
  idx = bubbleSort(myList);
  fill(0);
  text("BubbleSort - SPACE", 2, 115);
}

int bubbleSort(float[] arr) {
  float temp = 0;  
  for(int i=0; i < arr.length; i++){  
   for(int j=1; j < (arr.length-i); j++){  
     if(arr[j-1] > arr[j]){  
         temp = arr[j-1];  
         arr[j-1] = arr[j];  
         arr[j] = temp;
         return j;
     }     
     }  
   }
   return -1;
}

int insertionSort(float[] arr) {
  for (int i = 1; i < arr.length; i++) {
      float current = arr[i];
      int j = i - 1;
      while(j >= 0 && current < arr[j]) {
          arr[j+1] = arr[j];
          j--;
      }
      arr[j+1] = current;
      return i;
  }
  return -1;
}

void keyPressed() {
  if (key == 32) {
    for (int i = 0; i < myList.length; i++) {
      myList[i] = random(100);
    }
  }
}
