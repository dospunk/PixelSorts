PImage img;
PImage drawMe;
int[] bubbles;
//boolean[] swapsTracker;
int timerDuration = 1;
int timer = 0;
//Do not make bubbleSpace less than 2
int bubbleSpace = 7;
int bubblesMax = 0;
String imgPath;
boolean started;
boolean drawFramerate = false;


void setup(){
  size(1200,1200);
  frameRate(120);
  selectInput("Select a file to sort:", "fileSelected");
  textSize(32);
  fill(255, 0, 0);
  noSmooth();
}

void fileSelected(File selection){
  if(selection == null){
    exit();
  }
  img = loadImage(selection.getAbsolutePath());
  int possibleBubbles = floor((img.pixels.length-2)/bubbleSpace);
  if(possibleBubbles > bubblesMax && bubblesMax > 0){
    bubbles = new int[bubblesMax];
  } else {
    bubbles = new int[possibleBubbles];
  }
  //swapsTracker = new boolean[bubbles.length];
  for(int i = 0; i < bubbles.length; i++){
    bubbles[i] = i*bubbleSpace;
  }
  /*for(int i = 0; i < swapsTracker.length; i++){
    swapsTracker[i] = false;
  }*/
  started = true;
}

void draw(){
  if(started){
    for(int i = 0; i < bubbles.length; i++){
      bubbles[i] = bubble(bubbles[i], i);
    }
    drawMe = img.copy();
    drawMe.resize(width, img.height * (img.width/width));
    image(drawMe, 0, (height-drawMe.height)/2);
    if(drawFramerate) text(frameRate, 10, 26);
  }
}

int bubble(int x, int idx){
  if(avg(img.pixels[x]) < avg(img.pixels[x+1])){
    swap(x, x+1);
    //swapsTracker[idx] = true;
  }
  x++;
  if(x >= img.pixels.length-2){
    x = 0;
  }
  return x;
}

double avg(color c){
  return (red(c)+blue(c)+green(c))/3;
}

void swap(int a, int b){
  color temp = img.pixels[a];
  img.set(a%img.width, floor(a/img.width), img.pixels[b]);
  img.set(b%img.width, floor(b/img.width), temp);
}
