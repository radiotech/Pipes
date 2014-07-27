int [][] map = new int[10][10];
int cblc = 0;
int mof = 40;
int tool = 1;

//item vars
float it = 0;
float ip = 0;
float is = 10;
float ifl = 0;
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
  
  background(255);
  ellipseMode(CENTER);
  fill(0);

  

  if(ip == 1){
    
    float xof = 0;
    float yof = 0;

    if(ivx!=0){
      ivx+=abs(ivx)/ivx*is;
      if(abs(ivx)>40){
        xof = abs(ivx)/ivx;
        ivx = xof*40;
      }
    }

    if(ivy!=0){
      ivy+=abs(ivy)/ivy*is;
      if(abs(ivy)>40){
        yof = abs(ivy)/ivy;
        ivy = yof*40;
      }
    }
    
    if((xof != 0 || yof != 0) || (ivx==0 && ivy==0)){

      int tswitch = direct(ix,iy,ivx,ivy);

      ix += xof;
      iy += yof;

      ivx = 0;
      ivy = 0;

      switch(tswitch){
        case 0:
          ivx = is;
          break;
        case 1:
          ivy = is;
          break;
        case 2:
          ivx = -is;
          break;
        case 3:
          ivy = -is;
          break;
        case -1:
          iPop();
          break;
      }
      
    }


  int fix = round(ix);
  int fiy = round(iy);
  if(abs(ivx)>20){fix += (abs(ivx)/ivx);}
  if(abs(ivy)>20){fiy += (abs(ivy)/ivy);}

  if(inMap(fix,fiy)){

    switch(map[fix][fiy]){
      case 1:
        is-=.04;
        break;
      case 2:
        is-=.02;
        break;
      case 3:
        is-=.06;
        break;
      case 4:
        is+=.08;
        break;
      case 5:
        is-=.02;
        break;
    }

    if(is<.5){is=.5;}
    if(is>12){is=12;}

    if(map[fix][fiy]<1){iPop();}
  } else {iPop();}

  } else {
    ivy += 1;
    ivx /= 1.1;

    if(abs(ivx)>10){ivx=abs(ivx)/ivx*10;}
    if(abs(ivy)>10){ivy=abs(ivy)/ivy*10;}

    ix += ivx;
    iy += ivy;

    int tix = floor(ix/40);
    int tiy = floor(iy/40-mof/40);

    int tcolh = 1;
    int tcolv = 1;
    if(ix<tix*40+20){tcolh=-1;}
    if((iy-mof)<tiy*40+20){tcolv=-1;}

    if(inMap(tix+tcolh,tiy)){
      if(map[tix+tcolh][tiy]==-1){
        if(abs(ix-((tix+tcolh)*40+20))<30){
          ix = ((tix+tcolh)*40+20)-30*tcolh;
          ivx = 0;
        }
      }
    }

    if(inMap(tix,tiy+tcolv)){
      if(map[tix][tiy+tcolv]==-1){
        if(abs((iy-mof)-((tiy+tcolv)*40+20))<30){
          iy = ((tiy+tcolv)*40+20)-30*tcolv+mof;
          ivy = 0;
        }
      }
    }

    if(inMap(tix,tiy)){
      if(map[tix][tiy]==3){
        if(grabs(tix,tiy)==1){
          ip = 1;
          ix = tix;
          iy = tiy;
          ivx = 0;
          ivy = 0;
          is = 2;
        }
      }
    }

  }

  

  stroke(0);

  for(int k = 0; k <= 10; k++){
    line(0,k*40+mof,400,k*40+mof);
    line(k*40,mof,k*40,400+mof);
 
    if(k>1 && k<=5+1){
      fill(getCol(k-1));
    } else if(k==1){
      fill(255);
    } else {
      fill(0);
    }
    rect(k*40,0,40,40);
    fill(255);

    if(k==6+1){
      stroke(255);
      line(k*40+13,6,k*40+13,14);
      line(k*40+27,6,k*40+27,14);
      line(k*40+13,14,k*40+27,14);
      line(k*40+20,14,k*40+20,34);
      stroke(0);
    }
  }
  
  for(int i = 0; i < 10; i++){
    for(int j = 0; j < 10; j++){
      if(map[i][j] > 0){
        
        cblc = map[i][j];

        fill(255);
        stroke(getCol(cblc));

        

        rect(i*40+10, j*40+10+mof, 20,20);

        if(grab(i,j,1,0)){
          line(i*40+30,j*40+10+mof, i*40+40,j*40+10+mof);
          line(i*40+30,j*40+30+mof, 
i*40+40,j*40+30+mof);
          if(cblc==5){
            line(i*40+30,j*40+20+mof, i*40+40,j*40+20+mof);
          }
        }

        if(grab(i,j,-1,0)){
          line(i*40,j*40+10+mof, i*40+10,j*40+10+mof);
          line(i*40,j*40+30+mof, i*40+10,j*40+30+mof);
          if(cblc==7){
            line(i*40,j*40+20+mof, i*40+10,j*40+20+mof);
          }
        }

        if(grab(i,j,0,1)) {
          line(i*40+10,j*40+30+mof, i*40+10,j*40+40+mof);
          line(i*40+30,j*40+30+mof, i*40+30,j*40+40+mof);
          if(cblc==6){
            line(i*40+20,j*40+30+mof, i*40+20,j*40+40+mof);
          }
        }

        if(grab(i,j,0,-1)){
          line(i*40+10,j*40+mof, i*40+10,j*40+10+mof);
          line(i*40+30,j*40+mof, i*40+30,j*40+10+mof);
          if(cblc==8){
            line(i*40+20,j*40+mof, i*40+20,j*40+10+mof);
          }
        }


      } else {
        if(map[i][j] == -1){
          fill(0);
          stroke(0);
          rect(i*40,j*40+mof,40,40);
        }
      }
    }

  stroke(0);
  fill(color(255,0,0));
  
  if(ip == 1){
    ellipse(ix*40+20+ivx,iy*40+20+mof+ivy, 19,19);
  } else {
    ellipse(ix,iy,20,20);
    text(ix,80,80);
  }


  }

}



void mousePressed() {
  int txpos = floor(mouseX/40);
  int typos = floor(mouseY/40-mof/40);
  boolean good = true;
  
  if(typos < 0){
    good = false;
    if(txpos<=6+1){
      tool = round(txpos-1);
    }
  }
  
  if(good){
    if(tool<6){
      map[txpos][typos] = tool;
    }
    if(tool==6 || tool==5){
      wrench(txpos,typos);
    }
  }

  if(ip==0){
    ix = mouseX;
    iy = mouseY;
    ip = 0;

    ivx = random(20) - 10;
    ivy = -1 * random(10);
  }

}

color getCol(float ttyp){
  
  color tcol = color(255,0,0);
  switch(round(ttyp)){
  case(1):
    tcol = color(50);
    break;
  case(2):
    tcol = color(170);
    break;
  case(3):
    tcol = color(130,40,130);
    break;
  case(4):
    tcol = color(200,200,50);
    break;

  case(5):
    tcol = color(210);
    break;
  case(6):
    tcol = color(210);
    break;
  case(7):
    tcol = color(210);
    break;
  case(8):
    tcol = color(210);
    break;
  }
  return tcol;
}


boolean inMap(float txpos,float typos){
  if(txpos < 9 && txpos > 0 && typos < 9 && typos > 0){
    return true;
  } else {
    return false;
  }
}

boolean grab(int tttxpos, int tttypos,int ttofh, int ttofv){
  boolean myreturn = true;
  if(!inMap(tttxpos+ttofh,tttypos+ttofv) || !inMap(tttxpos,tttypos)){myreturn= false;}
  if(myreturn){
    float tfpos = map[tttxpos][tttypos];
    float tspos = map[tttxpos+ttofh][tttypos+ttofv];

    if(tspos <= 0){myreturn = false;}
    if(tfpos  == 1 && tspos == 2){myreturn = false;}
    if(tfpos == 2 && tspos == 1) {myreturn = false;}
    if(tfpos == 3 && tspos == 3) {myreturn = false;}

  }
  return myreturn;
}

float grabs(int ttxpos, int ttypos){
  float tmr = 0;
  if(grab(ttxpos,ttypos,1,0)){tmr++;}
  if(grab(ttxpos,ttypos,-1,0)){tmr++;}
  if(grab(ttxpos,ttypos,0,1)){tmr++;}
  if(grab(ttxpos,ttypos,0,-1)){tmr++;}
  //println(tmr);
  return tmr;
}

int direct(float txpos, float typos, float thof, float tvof){
  int mr = -1;
  if(abs(thof)>0){thof = abs(thof)/thof;}
  if(abs(tvof)>0){tvof = abs(tvof)/tvof;}
  
  txpos += thof;
  typos += tvof;
  
  float tpos = grabs(round(txpos),round(typos));
  
  if(thof != 0 || tvof != 0){
    tpos -= 1;
  }

  tpos = floor(random(tpos));

  float tcpos = 0;

  if(thof!=-1 && grab(round(txpos),round(typos),1,0)){
    if(tcpos == tpos){
      mr = 0;
    }
    tcpos++;
  }

  if(thof!=1 && grab(round(txpos),round(typos),-1,0)){
    if(tcpos == tpos){
      mr = 2;
    }
    tcpos++;
  }

  if(tvof!=-1 && grab(round(txpos),round(typos),0,1)){
    if(tcpos == tpos){
      mr = 1;
    }
    tcpos++;
  }

  if(tvof!=1 && grab(round(txpos),round(typos),0,-1)){
    if(tcpos == tpos){
      mr = 3;
    }
  }
  return mr;
}

boolean iPop(){
  if(ip==1){
    float tivx = 0;
    float tivy = 0;

    if(grab(round(ix),round(iy),1,0)){tivx -= 10;}
    if(grab(round(ix),round(iy),-1,0)){tivx += 10;}
    if(grab(round(ix),round(iy),0,1)){tivy -= 10;}
    if(grab(round(ix),round(iy),0,-1)){tivy += 10;}

    ix = ix*40+20+ivx;
    iy = iy*40+20+mof+ivy;

  

    ivx += random(10)-5+tivx;
    ivy += random(10)-5+tivy;

    ip = 0;
    
  }
  
  return true;
}

boolean wrench(float wposx, float wposy){

  return true;
}

