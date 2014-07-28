int[][] map = new int[10][10];
int cblc = 0;
int mof =40;

void setup() {
  size(400,400+mof);

  for(int i = 0; i < 10; i++){
    for(int j = 0; j < 10; j++){
      map[i][j] = 0;
    }
  }

}

void draw() {

  background(255);

  stroke(0);

  for(int k = 0; k <= 10; k++){
    line(0,k*40+mof,400,k*40+mof);
    line(k*40,mof,k*40,400+mof);
 
    if(k>0){
      fill(getCol(k));
    } else {
      fill(255);
    }
    rect(k*40,0,40,40);
    fill(255);
  }
  
  for(int i = 0; i < 10; i++){
    for(int j = 0; j < 10; j++){
      if(map[i][j] > 0){
        
        cblc = map[i][j];

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


      }
    }
  }

}



void mousePressed() {
  int txpos = floor(mouseX/40);
  int typos = floor(mouseY/40-mof/40);
  boolean good = true;

  if(good){
    map[txpos][typos] = 2;
  }
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