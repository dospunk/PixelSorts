PImage img;
PImage drawMe;
String imgPath;
boolean started;
int last1 = 0;
int last2;
int min = 0;
int min2;

void setup(){
  size(1200,1200);
  frameRate(120);
  selectInput("Select a file to sort:", "fileSelected");
  textSize(32);
  fill(255, 0, 0);
}

void fileSelected(File sel){
  if(sel == null){
    exit();
  }
  img = loadImage(sel.getAbsolutePath());
  last2 = img.pixels.length-1;
  min2 = last2;
  started = true;
}

void draw(){
  if(started){
    for(int i = last1; i < img.pixels.length; i++){
      //print(i);
      if(avg(img.pixels[i]) < avg(img.pixels[min])){
        min = i;
      }
    }
    for(int j = last2; j > 0; j--){
      //print(i);
      if(avg(img.pixels[j]) < avg(img.pixels[min2])){
        min2 = j;
      }
    }
    //print(min);
    swap(min, last1);
    swap(min2, last2);
    if(last1 + 1 < img.pixels.length) last1++;
    if(last2 - 1 > 0) last2--;
    drawMe = img.copy();
    drawMe.resize(width, width);
    image(drawMe, 0, 0);
    text(frameRate, 10, 26);
  }
}

double avg(color c){
  return (red(c)+blue(c)+green(c))/3;
}

void swap(int a, int b){
  color temp = img.pixels[a];
  img.set(a%img.width, floor(a/img.width), img.pixels[b]);
  img.set(b%img.width, floor(b/img.width), temp);
}
