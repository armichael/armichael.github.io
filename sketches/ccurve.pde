//template

void setup(){
  size( 800, 800);
  background( 255 );
  stroke(255);
  strokeWeight(.8);
  colorMode(HSB,360,100,100,100);
  frameRate(2);
  fr = 1;
}
int fr;
void draw(){
  derp = fr % 17; 
  // background(0,0,100);
  scale(.8);
  noStroke();
  fill(0,0,100,80);
  rect(0,0,width*2,height*2);
  rline(220,350,580,350,derp);
  fr++;
}


int derp = 3;
void rline(float x, float y, float x2, float y2, int levels){
  
  if (levels >= 0){
    // stroke(300,int(map(levels,0,derp,20,100)),int(map(levels,0,derp,50,80)),50);
    noFill();
    stroke(0,0,0);
    if (levels == 0)
    line(x,y,x2,y2);
    
    float xa = (x+x2)/2 - (y2-y)/2;
    float ya =  (y+y2)/2 + (x2 -x)/2;
    
    rline(x,y,xa,ya,levels-1);
    
    rline(xa,ya,x2,y2,levels-1);
  }
  
  
    
}




void ps(){
  pushMatrix();
}
void pop(){
  popMatrix();
}
