int [][] map = new int[10][10];
int cblc = 0;
int mof = 40;
int tool = 1;

//item vars
float it = 0;

float ip = 0;

float ix = 0;
float iy = 0;

float ivx = 0;
float ivy = 0;

void setup() {
  size(400,400+mof);

  for(int i = 0; i < 10; i++){
    for(int j = 0; j < 10; j++){
      map[i][j] = 0;
    }
  }

}

void draw() {
  
  ivy += 1;
  ivx /= 1.1



  ix += ivx;
  iy += ivy;

  int tix = floor(ix/40);
  int tiy = floor(iy/40+mof/40);

  int tcolh = 1;
  int tcolv = 1;
  if(ix<tix*40+20){tcolh=-1;}
  if((iy-mof)<tiy*40+20){tcolv=-1;}

  if(inMap(tix+tcolh,tiy)){
    if(map[tix+tcolh][tiy]==-1){
      if(abs(ix-((tix+tcolh)*40+20))<30){
        ix = ((tix+tcolh)*40+20)-30*tcolh;
      }
    }
  }

  if(inMap(tix,tiy+tcolv)){
    if(map[tix][tiy+tcolv]==-1){
      if(abs((iy-mof)-((tiy+tcolv)*40+20))<30){
        iy = ((tiy+tcolv)*40+20)-30*tcolv+mof;
      }
    }
  }
  background(255);

  stroke(0);

  for(int k = 0; k <= 10; k++){
    line(0,k*40+mof,400,k*40+mof);
    line(k*40,mof,k*40,400+mof);
 
    if(k>1){
      fill(getCol(k-1));
    } else {
      if(k==1){
        fill(255);
      } else {
        fill(0);
      }
    }
    rect(k*40,0,40,40);
    fill(255);
  }
  
  for(int i = 0; i < 10; i++){
    for(int j = 0; j < 10; j++){
      if(map[i][j] > 0){
        
        cblc = map[i][j];

        fill(255);
        stroke(getCol(cblc));

        switch(cblc){
          case(2):
            
            break;
        }

        rect(i*40+10, j*40+10+mof, 20,20);

        if(map[i+1][j] > 0){
          line(i*40+30,j*40+10+mof, i*40+40,j*40+10+mof);
          line(i*40+30,j*40+30+mof, 
i*40+40,j*40+30+mof);
        }

        if(map[i-1][j] > 0){
          line(i*40,j*40+10+mof, i*40+10,j*40+10+mof);
          line(i*40,j*40+30+mof, i*40+10,j*40+30+mof);
        }

        if(map[i][j+1] > 0) {
          line(i*40+10,j*40+30+mof, i*40+10,j*40+40+mof);
          line(i*40+30,j*40+30+mof, i*40+30,j*40+40+mof);
        }

        if(map[i][j-1] > 0){
          line(i*40+10,j*40+mof, i*40+10,j*40+10+mof);
          line(i*40+30,j*40+mof, i*40+30,j*40+10+mof);
        }


      } else {
        if(map[i][j] == -1){
          fill(0);
          stroke(0);
          rect(i*40,j*40+mof,40,40);
        }
      }
    }

  ellipseMode(CENTER);
  ellipse(ix,iy,20,20);


  }

}



void mousePressed() {
  int txpos = floor(mouseX/40);
  int typos = floor(mouseY/40-mof/40);
  boolean good = true;
  
  if(typos < 0){
    good = false;
    tool = txpos-1;
  }
  
  if(good){
    map[txpos][typos] = tool;
  }

  ix = mouseX
  iy = mouseY

  ivx = random(20) - 10;
  ivy = -1 * random(10);


}

Color getCol(int ttyp){
  
  int tcol = color(255,0,0);
  switch(ttyp){
  case(1):
    tcol = color(50);
    break;
  case(2):
    tcol = color(150,50,150);
    break;
  }
  return tcol;
}


boolean inMap(int txpos,int typos){
  if(txpos < 9 && txpos > 0 && typos < 9 && typos > 0){
    return true;
  } else {
    return false;
  }
}
