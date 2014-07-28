
int[][] map = new int[10][10];


void setup() {
  size(400,400);
}

void draw() {


  background(255);

  for(int i = 0; i <= 10; i++){
    line(0,i*40,400,i*40);
    line(i*40,0,i*40,400);
  }
}




class Pipe() {
  
  boolean Pipe(){
    return true;
  }

}