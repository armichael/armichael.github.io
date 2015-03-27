void setup()
{
  size(900,600);
  smooth();
  colorMode(HSB,360,100,100,100);
  
  black = color(0,0,0);
  white = color(0,0,100);
  wipe = color(white,10);
  frameRate(130);
  X = width/2;
  Y = height/2;
  background(0,0,100);
  PHI = 1.618033988749894;
  
  c_x= 0; c_y = 0;
  depth = 22;
  easing = 0.01;
  innersquareSize = 550;
  // init_x = X - ((innersquareSize*PHI)/2);
  // init_y = Y - ((innersquareSize*PHI)/2);

  goldpoints = initgoldpoints(depth, innersquareSize);
  cpoints = initcpoints(depth*50, innersquareSize);
  depth = 1;
  masterSide = goldpoints[1].y - goldpoints[0].y;
}

int X, Y; // midX, midY
// standard
color wipe,black,white;
float dmouse;
float angle, inc;

float spiral_x, spiral_y;
float PHI;
int depth;
float c_x;
float c_y;
float target_x; float target_y;
float easing;
PVector goldpoints[];
PVector cpoints[];
float innersquareSize;
// float spiralAngle = -PI/6 + depth*-PI/2;

void draw()
{  
	refresh(); 
  
  drawGoldenRectangle();
  depth = int((map(mouseX,0,width,1,15)));



  
  traceSpiral();
  // debug();
}



PVector[] initgoldpoints(int n, float sqsize){
  float a = sqsize;
  float b = sqsize/PHI;
  PVector  gpoints[] = new PVector[n];
  float iterAngle = PI/4;
  gpoints[0] = new PVector(0,0);
  
  for(int i = 1; i < n; i++){
    // int mod_x = (i mod 4 == 0 || i mod 4 == 1)? 1 : -1;
    // int mod_y = (i mod 4 == 0 || i mod 3 == 1)? 1 : -1;
    float path = sqrt(a*a+b*b);
    float point_x = gpoints[i-1].x + cos(iterAngle)*path;
    float point_y = gpoints[i-1].y + sin(iterAngle)*path;
    gpoints[i] = new PVector(point_x,point_y);
    iterAngle -= PI/2;
    a /= PHI;
    b /= PHI;
   
  }
  return gpoints;
}

PVector[] initcpoints(int n, float sqsize){
  float a = goldpoints[1].y - goldpoints[0].y;
  PVector cps[] = new PVector[n];
  float iterangle = PI/2;
  float cpx = a;
  float cpy = 0;
  cps[0] = new PVector(a,0);
  
  for(int i = 1; i < n; i++){
    float term = a/(pow(PHI,i+1));
    cpx += cos(iterangle)*(term);
    cpy += sin(iterangle)*term;
    iterangle-=PI/2;
    cps[i] = new PVector(cpx,cpy);
    cps[1] = new PVector(a,a/pow(PHI,2));
  }
  
  return cps;
}

void drawSpiral(){
  for(int i = 0; i < depth-1; i ++){
    stroke(black); line(goldpoints[i].x,goldpoints[i].y,goldpoints[i+1].x,goldpoints[i+1].y);
  }
}

void drawGoldenRectangle(){
  rectMode(CORNERS);
  stroke(black);
  strokeWeight(1);
  rect(0,0, masterSide*PHI,masterSide);
  if (mousePressed == false){
  for(int i = 0; i < depth; i ++){
    if (i == (depth-1) && depth > 1) strokeWeight(2);
    rect(goldpoints[i].x,goldpoints[i].y,goldpoints[i+1].x,goldpoints[i+1].y);

  }}
}

float masterSide; 
float spiralAngle= 0;
float spiralInc = .08;
float nv;
float nvv;
void traceSpiral(){
  float a = goldpoints[1].y - goldpoints[0].y;
  PVector center = cpoints[0];
  if(depth >0){ center = cpoints[depth-1];}
  float scalar = a/(pow(PHI,depth));
  
  // fill(360,100,100);
  // ellipse(center.x,center.y,20,20);
  

  float targetAngle = depth*PI/2;
  

  target_x = goldpoints[depth].x;
  target_y = goldpoints[depth].y;
  noFill();
  stroke(black);
  ellipseMode(CENTER);

  for(int i = depth-1; i > 0; i--){
    setArcVars(i);
    float s = a/(pow(PHI,i));
    stroke(240,70,80,70);
    strokeWeight(.5);
    arc(cpoints[i-1].x,cpoints[i-1].y,s*PHI*2,s*PHI*2, nv, nvv);
  }}
  
  // if (spiralAngle != targetAngle){
  //     stroke(black);
  //     noFill();
  //     translate(center.x,center.y);
  //     float c_x = cos(spiralAngle)*scalar*PHI*2;
  //     float c_y = sin(spiralAngle)*scalar*2*PHI;
  //     point(c_x,c_y);
  //     spiralAngle += inc;
  // } 
  //   }


// void lineUpdate(){
//     stroke(360,100,100);
//     line(cx,cy+trace_y,cx+PHI*cside,cy+trace_y);
//     stroke(100,100,100);
//     line(cx+cside*PHI,cy+trace_y,cx+cside,cy+trace_y);
//     trace_y += 1;
//     if (trace_y > cside) cfinished = true;
// }

void setArcVars(int d){
  switch(d%4){
  case 1:
    nv = HALF_PI;
    nvv = PI;
    break;
  case 2:
    nv = 0;
    nvv = HALF_PI;
    break;
  case 3:
    nv = 3*PI/2;
    nvv = TWO_PI;
    break;
  case 0:
    nv = PI;
    nvv = 3*PI/2;
    break;
  default:
    println("I'm sorry for this.");
    break;
  }
}

// void goldenRect(float x, float y, float side,int depth){
//   pushMatrix();
//   if (depth > 0){
//     stroke(black);
//     strokeWeight(2);
//     noFill();
//     rect(x,y,side*PHI,side);
//     translate(x+PHI,y+side);
//     rotate(-PI/2);
//     goldenRect(0,0,side/PHI,depth-1);
//       }
//   popMatrix();
// }

// void oneRect(float x, float y, float side){
//   for (int i = 0; i < side; i++){
//     if (hasFinished == true){
//     stroke(360,100,100);
//     line(x,y+i,x+side,y+i);
//     stroke(100,100,100);
//     line(x+side,y+i,x+side*PHI,y+i);
   
  // }
  // }}

 
void refresh(){
  // drawGrid(innersqareSize/pow(PHI,8));
  translate(-(innersquareSize*PHI)/2.5,-(innersquareSize)/2.5);
  translate(X,Y);
  noStroke();
  fill(wipe);
  rect(-X,-Y,width+X,height+Y);
  
  //background(white);
}

void drawGrid(float step){
  strokeWeight(.1);
  stroke(black,10);
  fill(black,10);
  
  for(float i = 0; i < max(width,height); i+=step){
    line(0,i,width,i);
    line(i,0,i,height);
  }
}

void debug(){
  println("Depth: "+depth); //debug
  for(int i = 0 ; i < 7; i++){
    ellipse(cpoints[i].x,cpoints[i].y,20,20);
  }
}

