class Front{
void MagneticLineDraw(float x1, float y1, float x2, float y2, float theta) {
  PVector p1 = new PVector(x1, y1);
  PVector p2 = new PVector(x2, y2);
  PVector p12 = p2.copy().sub(p1);
  PVector d = p12.copy().div(2).rotate(PI/2).setMag(tan((PI/2)-theta)*(p12.copy().mag()/2));
  PVector cc = p1.copy().add(p12.copy().div(2)).add(d);
  float r = p1.copy().sub(cc).mag();
  PVector ccP1 = p1.copy().sub(cc);
  PVector ccP2 = p2.copy().sub(cc);
  //角度を求める
  float ccP1Ang = ccP1.heading();
  float ccP2Ang = ccP2.heading();
  //
  if (p1.y<cc.y) {
    ccP1Ang = 2*PI + ccP1Ang;
  }

  if (p1.y<cc.y) {
    ccP2Ang = 2*PI + ccP2Ang;
  }
  
  if (ccP1Ang>ccP2Ang) {
    ccP2Ang += 2*PI; 
  }
  
  arc(cc.x, cc.y, 2*r, 2*r, ccP1Ang, ccP2Ang,OPEN);
  
  //ellipse(cc.x,cc.y,10,10);
  ellipse(x1,y1,10,10);
  ellipse(x2,y2,10,10);
}

Ball b;
Ball c;
boolean t = false;
void Setup(){
b = new Ball(width/2,0,20,(0));
c = new Ball(width/2,height/2,20,(0));
}

void Draw(){
  background(255);
  if(b.TouchJudge(c.x,c.y,c.w)){
   t = true;
  }
  if(!t){
  b.Pmove(c.x,c.y,radians(2),3);
  }
  else{
  c.Move(3,-0.9);
  b.Move(2.5,-1.25);
  }
  
  
  boolean col = false;
  for(float i = PI-radians(1) ; 0<i ; i -= 0.048){
    if(col){
    fill(255);
    col = false;
  }
    else{
    fill(0);
    col = true;
  }
  MagneticLineDraw(b.x, b.y, c.x, c.y,i);
  MagneticLineDraw(c.x,c.y,b.x,b.y,i);
  }
  fill(255);
  b.Draw();
  c.Draw();
  
  

}




}
