void setup()
{
  size(600,600);
  smooth();
  colorMode(HSB,360,100,100,100);
  ellipseMode(CENTER);
  black = color(0,0,0);
  white = color(0,0,100);
  wipe = color(white,5);
  
  X = width/2;
  Y = height/2;
  angle = 0;
  inc = 0.002;
  bw = new BallWave(100,200,50,0 );
  bw.init();
  gw = new BallWave(50,100,50,PI);
  gw.init();
}

int X, Y; // midX, midY
color wipe,black,white;
float dmouse;
float angle, inc;
BallWave bw,gw;

void draw()
{
	refresh(); 
  bw.display();
  gw.display();
	angle+=inc;
  
  //translate(cos(PI/18)*sqrt(X*X+Y*Y),sin(PI/18)*sqrt(X*X+Y*Y));
	//println(+" "+" "+); //debug
}

class Ball{
  float xpos,ypos,r;
  
  Ball(float _xpos, float _ypos, float _r){
    xpos = _xpos;
    ypos =_ypos;
    r=_r;
  }

  void display(float newy, float c){
    noStroke();
    fill(c,100,100,30);
    ellipse(xpos,newy,r,r);
  }

  
}

class BallWave{
  int num;
  Ball[] Balls;
  float amp,freq, r,angleMOD;

  color c;
  
  BallWave(float _freq, float _amp, float _r,float _angleMOD){
    num = int((width/(_r*.8)))+1;
    freq = _freq;
    amp = _amp;
    r = _r;
    angleMOD = _angleMOD;
    //c = _c;
  }

  void init(){
    Balls = new Ball[num];
    
    for (int i = 0; i < num; i++){
      //float newY = Y + sin(freq*(angle+(inc*i)))*amp;
      Balls[i] = new Ball(i*(r*.8),Y,r);
    }
  }
  
  void display(){
    float a = angle + angleMOD;
    for (int i = 0; i <num; i++){
      a += inc;
      float rc = map(sin(freq*a)*amp,-1*amp,1*amp,0,360);
      float newY = Y + sin(freq*a)*amp;
      //Balls[i].ypos = newY;
      //rotate(map(sin(angle),-1,1,0,2*PI));
      
      Balls[i].display(newY,rc);
      
    }
   
  }
}


void refresh(){
  //drawGrid(20);
  
  //dmouse = dist(pmouseX,pmouseY,mouseX,mouseY);
  
  noStroke();
  fill(wipe);
  rect(0,0,width,height);
  
  //background(white);
}

void drawGrid(float step){
  strokeWeight(.1);
  stroke(black,10);
  fill(black,10);
  
  ellipse(X,Y,2,2);
  ellipse(3*X/2,Y/2,1,1);
  ellipse(3*X/2,3*Y/2,1,1);
  ellipse(X/2,Y/2,1,1);
  ellipse(X/2,3*Y/2,1,1);
  
  for(float i = 0; i < max(width,height); i+=step){
    line(0,i,width,i);
    line(i,0,i,height);
  }
}


int rand(int a, int b){
  return int(random(a,b));
}
