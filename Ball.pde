class Ball {
  float x;
  float y;
  float w;
  color c;
  Ball(float x, float y, float w, color c) {
    this.x = x;
    this.y = y;
    this.w = w;//直径
    this.c = c;
  }
  void Pmove(float cx, float cy, float theta, float miR) {//距離をどれくらい近づけるか
    PVector cv = new PVector(cx, cy);
    PVector pCoord = new PVector(x, y).sub(cv);
    pCoord.rotate(theta);
    pCoord.setMag(pCoord.copy().mag()-miR);
    PVector newV = pCoord.copy().add(cv);
    x = newV.x;
    y = newV.y;
  }

  void Draw() {
    ellipse(x, y, w, w);
  }

  boolean TouchJudge(float cx, float cy, float cr) {
    if (sqrt(sq(cx-x)+sq(cy-y))<w/2+cr) {
      return true;
    }
    return false;
  }
  
  void Move(float mx,float my){
    this.x += mx;
    this.y += my;
  }
}
