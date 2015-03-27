int unit = 100;
int count;
Globall[] ballz;
int cycleSpeed;

void setup(){
  size(1000,800);
  background(0);
  colorMode(HSB, 360,100,100);
  noStroke();
  smooth();
  frameRate(24);
  
  started = false;
}

boolean started;


void draw(){

  
  if (started==false){
    
   float X = width/2; float Y = height/2;
    fill(0,0,100);
    beginShape();
    vertex(X+30,Y);
    vertex(X-30,Y+30);
    vertex(X-30,Y-30);
    endShape(CLOSE);
  } else {background(0,0,80);}
  // fill(0,0,0,5);
  // rect(0,0,width,height);
  
   for (int i = 0; i < count; i++) {
    ballz[i].go();
   }
   
unit = int(map(mouseY,0,height,3,500));
cycleSpeed = int(map(mouseX,0,width,1,38));
if (mousePressed == true){
  started = true;
sizecheck();
}
  
}


void sizecheck(){ //this will run if the mouse is pressed. It will re-initialize the object array with random starting color
  int wideCount = width / unit;
  int highCount = height / unit;
  count = wideCount * highCount;
  ballz = new Globall[count];

  int index = 0;
  for (int y = 0; y < highCount; y++) {
    for (int x = 0; x < wideCount; x++) {
      ballz[index++] = new Globall(int(random(0,360)), unit*x, unit*y,unit); //
    }
  }
}


class Globall{
  int base;
  int x;
  int y;
  int w = 200;
  int h = 200;
  int size;
  int dir = 1;
  Globall(int _base, int _x, int _y, int _size){
   base = _base;
    x = _x;
     y = _y;
    size = _size; 
  }
  
  void go(){
    
    fill(base,100,100,256);//256
    //polygon(x,y,size/2,6);
    rect(x,y,size,size);
    base = base + cycleSpeed;
    
    if ( base > 359){
      base = 0;
    }
    
    
    
    
  }
  
}
  
  
  void polygon(int x, int y, float radius, int nsides){
  float angle = TWO_PI / nsides;
  beginShape();
  for (float a = 0; a < TWO_PI; a +=angle){
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
