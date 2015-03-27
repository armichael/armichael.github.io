void setup()
{
  size(500,600); //500/600
  smooth();
  colorMode(HSB,360,100,100,100);
  noStroke();
  black = color(0,0,0);
  white = color(0,0,100);
  wipe = color(white,10);
  
  X = width/2;
  Y = height/2;

  bar = 35;
  slant = 16;
  retract = 80;
  retracty = 60;
  angle = 0;
  inc = 0;
  frameRate(40);
}

int X, Y; // midX, midY
color wipe,black,white;
float dmouse;
float angle, inc;


void draw()
{
	// refresh(); 
  background(0,0,100);
  // retract = map(mouseY,0,height,40,100);
  // retracty = map(retract,40,100,20,80);
  
  for(float i = width+2*bar; i > 0; i-= 2*bar){
    // drawKink(i+sin(angle)*50+inc,0);
    // bar = 15;
    drawKink(i+inc*(mouseX>X? -1:1),0);
    // drawNoodle(i-inc,0);
  }
  inc-=8;
  if (inc < 0) inc = 2*bar;
	//println(+" "+" "+); //debug
  angle+=0.1;
}

float dimval;
float bar;
float slant;
float retract;
float retracty;

void drawKink(float x,float y){
  float base = map(x,20,width,0,100);
  float col = 210;///(x,0,width,0,360);
  float base2 = map(x,20,width,0,75);

  fill(col,base,100);

  float smallbar = map(x,0 ,width,0,200);
  // cleaning this up later
  quad(x,0, x+bar,0, x+bar,smallbar+slant, x, smallbar);
  quad(x,height, x+bar,height,  x+bar,height-(smallbar+slant), x,height-smallbar);
  
  fill(col,base2,100);
  quad(x+bar,smallbar+slant, x,smallbar,  x-retract,smallbar+retracty, x+bar-retract,smallbar+slant+retracty);

  quad(x+bar,height-(smallbar+slant), x,height-smallbar,  x-retract,height-smallbar-retracty, x+bar-retract,height-smallbar-slant-retracty);
  fill(col,base,100);
  quad(x+bar-retract,height-smallbar-slant-retracty, x-retract,height-smallbar-retracty,
       x-retract,smallbar+retracty, x+bar-retract,smallbar+slant+retracty);
}





