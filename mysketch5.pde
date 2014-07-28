
int[][] map = new int[10][10];


void setup() {
  size(400,400);

  for(int i = 0; i < 10; i++){
    for(int j = 0; j < 10; j++){
      map[i][j] = 0;
    }
  }

  map[2][2] = 1;
  map[3][2] = 1;

}

void draw() {

  background(255);

  for(int k = 0; k <= 10; k++){
    line(0,k*40,400,k*40);
    line(k*40,0,k*40,400);
  }
  
  for(int i = 0; i < 10; i++){
    for(int j = 0; j < 10; j++){
      if(map[i][j] > 0){
        rect(i*40+10, j*40+10,20,20);

        if(map[i+1][j] > 0){
          line(i*40+30,j*40+10, i*40+40,j*40+10);
          line(i*40+30,j*40+30, 
i*40+40,j*40+30);
        }

        if(map[i-1][j] > 0){
          line(i*40,j*40+10, i*40+10,j*40+10);
          line(i*40,j*40+30, i*40+10,j*40+30);
        }

        if(map[i][j+1] > 0) {
          line(i*40+10,j*40+30, i*40+10,j*40+40);
          line(i*40+30,j*40+30, i*40+30,j*40+40);
        }

        if(map[i][j-1] > 0){
          line(i*40+10,j*40, i*40+10,j*40+10);
          line(i*40+30,j*40, i*40+30,j*40+10);
        }


      }
    }
  }

}