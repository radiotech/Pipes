
//int[][] map = new int[10][10];

Pipe pipe;

/*
void setup() {
  size(400,400);
  //pipe = new Pipe(2,2,1);
}

void draw() {


  background(255);

  for(int i = 0; i <= 10; i++){
    line(0,i*40,400,i*40);
    line(i*40,0,i*40,400);
  }


  //pipe.display();


}
*/


class Pipes() {
  
  int xpos = 0;
  int ypos = 0;
  int type = -1;

  Pipe(int txpos, int typos, int ttype){
    xpos = txpos;
    ypos = typos;

    type = ttype;
  }
  
  void display() {
     rect(40*xpos+10,40*ypos+10,20,20);
    
  }

}
