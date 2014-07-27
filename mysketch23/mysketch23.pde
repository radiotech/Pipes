int mapw = 5;
int maph = 5;
int [][] map = new int[mapw][maph];
int [][] tmap = new int[mapw][maph];
int cblc = 0;
int mof = 40;
int tool = 1;
int itemcount = 0;

//item vars
int items = 3;

float[] gipt = new float[items];
float[] gist = new float[items];
float[] giflt = new float[items];
float[] gixt = new float[items];
float[] giyt = new float[items];
float[] givxt = new float[items];
float[] givyt = new float[items];

float[] git = new float[items];
float[] gip = new float[items];
float[] gis = new float[items];
float[] gifl = new float[items];
float[] gix = new float[items];
float[] giy = new float[items];
float[] givx = new float[items];
float[] givy = new float[items];

void setup() {
  size(40*mapw,40*maph+mof);

  for(int i=0; i<items; i++){
    resetPoint(i);
  }

  for(int i = 0; i < mapw; i++){
    for(int j = 0; j < maph; j++){
      map[i][j] = 0;
    }
  }

}

void draw() {
  
  background(255);
  ellipseMode(CENTER);
  fill(0);



  itemcount = 0;

  for(int l = 0; l<items; l++){

    float it = git[l];
    float ip = gip[l];
    float is = gis[l];
    float ifl = gifl[l];
    float ix = gix[l];
    float iy = giy[l];
    float ivx = givx[l];
    float ivy = givy[l];

    if(ip==1){
    
      int xof = 0;
      int yof = 0;

      if(ivx!=0){
        ivx+=abs(ivx)/ivx*is;
        if(abs(ivx)>40){
          xof = round(abs(ivx)/ivx);
          ivx = xof*40;
        }
      }

      if(ivy!=0){
        ivy+=abs(ivy)/ivy*is;
        if(abs(ivy)>40){
          yof = round(abs(ivy)/ivy);
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
            iPop(l);
            break;
        }
      
      }


    int fix = round(ix);
    int fiy = round(iy);
    if(abs(ivx)>20){fix += round(abs(ivx)/ivx);}
    if(abs(ivy)>20){fiy += round(abs(ivy)/ivy);}

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

      if(map[fix][fiy]<1){iPop(l);}
    } else {iPop(l);}

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

    git[l] = it;
    gip[l] = ip;
    gis[l] = is;
    gifl[l] = ifl;
    gix[l] = ix;
    giy[l] = iy;
    givx[l] = ivx;
    givy[l] = ivy;
    
    stroke(0);
    fill(200,0,0);
//ellipse(100,100,40,40);
    if(ip==1){
      ellipse(ix*40+20+ivx, iy*40+20+mof+ivy, 19,19);
      itemcount += 1;
     } else {
       ellipse(ix,iy,20,20);
     }
    text(l,ix,iy-30);

    if(iy>40*maph+mof+40){
      removeItem(l);
      l -= 1;
    }

  }

  if(itemcount<3){
    if(random(100)<5){
      addItem();
    }
  }

  stroke(0);

  for(int k = 0; k <= mapw; k++){
    line(0,k*40+mof+40, 40*mapw,k*40+mof+40);
    //line(k*40,mof,k*40,40*maph+mof);
 
    if(k>1 && k<=5+1){
      fill(getCol(k-1));
    } else if(k==1){
      fill(255);
    } else {
      fill(0);
    }
    if(k<8){
      rect(k*40,0,40,40);
    }
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
  
  for(int i = 0; i < mapw; i++){
    for(int j = 0; j < maph; j++){
      if(map[i][j] > 0){
        
        cblc = map[i][j];

        noFill();
        stroke(getCol(cblc));

        

        rect(i*40+10, j*40+10+mof, 20,20);

        fill(255);
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
  



  }

}



void mousePressed() {
  int txpos = floor(mouseX/40);
  int typos = floor(mouseY/40-mof/40);
  boolean good = true;
  
  if(typos < 0){
    good = false;
    if(txpos<=6+1){
      tool = txpos-1;
    }
  }
  
  if(good){
    if(tool<6){
      map[txpos][typos] = tool;
      if(inMap(txpos,typos)==false){
        int pushx = 0;
        int pushy = 0;
        if(txpos==0){pushx=-1;}
        if(txpos==mapw-1){pushx=1;}
        if(typos==0){pushy=-1;}
        if(typos==maph-1){pushy=1;}
        expand(pushx,pushy);
      }
    }
    if(tool==6 || tool==5){
      wrench(txpos,typos);
    }
  }

  //resetPoint(2);

  //expand(1,1);
/*
  if(gip==false){
    ix[l] = mouseX;
    iy[l] = mouseY;
    ip[l] = false;

    ivx[l] = random(20) - 10;
    ivy[l] = -1 * random(10);
  }
*/

}

color getCol(int ttyp){
  
  color tcol = color(255,0,0);
  switch(ttyp){
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
  if(txpos < mapw-1 && txpos > 0 && typos < maph-1 && typos > 0){
    return true;
  } else {
    return false;
  }
}

boolean grab(float tttxpos, float tttypos,int ttofh, int ttofv){
  boolean myreturn = true;
  if(!inMap(tttxpos+ttofh,tttypos+ttofv) || !inMap(tttxpos,tttypos)){myreturn= false;}
  if(myreturn){
    int tfpos = map[round(tttxpos)][round(tttypos)];
    int tspos = map[round(tttxpos)+ttofh][round(tttypos)+ttofv];

    if(tspos <= 0){myreturn = false;}
    if(tfpos  == 1 && tspos == 2){myreturn = false;}
    if(tfpos == 2 && tspos == 1) {myreturn = false;}
    if(tfpos == 3 && tspos == 3) {myreturn = false;}

  }
  return myreturn;
}

int grabs(float ttxpos, float ttypos){
  int tmr = 0;
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
  
  int tpos = grabs(txpos,typos);
  
  if(thof != 0 || tvof != 0){
    tpos -= 1;
  }

  tpos = floor(random(tpos));

  int tcpos = 0;

  if(thof!=-1 && grab(txpos,typos,1,0)){
    if(tcpos == tpos){
      mr = 0;
    }
    tcpos++;
  }

  if(thof!=1 && grab(txpos,typos,-1,0)){
    if(tcpos == tpos){
      mr = 2;
    }
    tcpos++;
  }

  if(tvof!=-1 && grab(txpos,typos,0,1)){
    if(tcpos == tpos){
      mr = 1;
    }
    tcpos++;
  }

  if(tvof!=1 && grab(txpos,typos,0,-1)){
    if(tcpos == tpos){
      mr = 3;
    }
  }

  if(map[round(txpos)][round(typos)]>=5){
    mr = map[round(txpos)][round(typos)]-5;
  }

  return mr;
}

boolean iPop(int titem){
  if(gip[titem]==1){
    int tivx = 0;
    int tivy = 0;

    if(grab(gix[titem],giy[titem],1,0)){tivx -= 10;}
    if(grab(gix[titem],giy[titem],-1,0)){tivx += 10;}
    if(grab(gix[titem],giy[titem],0,1)){tivy -= 10;}
    if(grab(gix[titem],giy[titem],0,-1)){tivy += 10;}

    gix[titem] = gix[titem]*40+20+givx[titem];
    giy[titem] = giy[titem]*40+20+mof+givy[titem];

  

    givx[titem] += random(10)-5+tivx;
    givy[titem] += random(10)-5+tivy;

    gip[titem] = 0;
  }
  return true;
}

boolean wrench(int wposx, int wposy){
  map[wposx][wposy] = 4;
  map[wposx][wposy] = 5 + direct(wposx,wposy,0,0);
  return true;
}

boolean resetPoint(int ttitem){
  git[ttitem] = 0;
  gip[ttitem] = 0;
  gis[ttitem] = 0;
  gifl[ttitem] = 0;
  gix[ttitem] = random(200);
  giy[ttitem] = -40;
  givx[ttitem] = random(10)-5;
  givy[ttitem] = random(5)*-1;

  return true;
}

boolean expand(int tsx, int tsy){
  tmap = new int[mapw][maph];
  for(int m = 0; m < mapw; m++){
    for(int n = 0; n < maph; n++){
      tmap[m][n] = map[m][n];
    }
  }
  map = new int[mapw+abs(tsx)][maph+abs(tsy)];
  int tpushx = 0;
  int tpushy = 0;
  if(tsx<0){tpushx=abs(tsx);}
  if(tsy<0){tpushy=abs(tsy);}
  for(int m = 0; m < mapw; m++){
    for(int n = 0; n < maph; n++){
      map[m+tpushx][n+tpushy] = tmap[m][n];
    }
  }
  mapw+=abs(tsx);
  maph+=abs(tsy);
  size(mapw*40,maph*40+mof);
  return true;
}

boolean addItem(){
  gipt = new float[items];
  gist = new float[items];
  giflt = new float[items];
  gixt = new float[items];
  giyt = new float[items];
  givxt = new float[items];
  givyt = new float[items];

  for(int m = 0; m < items; m++){
    gipt[m] = gip[m];
    gist[m] = gis[m];
    giflt[m] = gis[m];
    gixt[m] = gix[m];
    giyt[m] = giy[m];
    givxt[m] = givx[m];
    givyt[m] = givy[m];
  }

  items+=1;

  gip = new float[items];
  gis = new float[items];
  gifl = new float[items];
  gix = new float[items];
  giy = new float[items];
  givx = new float[items];
  givy = new float[items];

  for(int n = 0; n < items-1; n++){
    gipt[n] = gip[n];
    gist[n] = gis[n];
    giflt[n] = gis[n];
    gixt[n] = gix[n];
    giyt[n] = giy[n];
    givxt[n] = givx[n];
    givyt[n] = givy[n];
  }

  resetPoint(items);
  return(true);
}

boolean removeItem(int fitem){
   
  for(int n = fitem; n < items-1; n++){
    gip[n] = gip[n+1];
    gis[n] = gis[n+1];
    gifl[n] = gis[n+1];
    gix[n] = gix[n+1];
    giy[n] = giy[n+1];
    givx[n] = givx[n+1];
    givy[n] = givy[n+1];
  }
  
  items-=1;

  return true;
}
