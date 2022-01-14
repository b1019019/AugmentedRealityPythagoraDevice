import processing.serial.*;
//
Front front = new Front();
//

Serial serialPort; // Arduinoにデータを送るシリアルポート
boolean firstContact = false;  //Arduinoからのはじめの送信を確認する

byte[] inByte = new byte[3]; // 受信データ用バッファ

int oval1, oval2;
//
boolean mouseP = false;
//
void setup() {
  size(1366, 768);
  //
  background(255);
  front.Setup();
  //
  printArray(Serial.list()); // 使用可能なシリアルポート一覧の出力。デバッグ用
  String portName = Serial.list()[0]; // 使用するシリアルポート名
  serialPort = new Serial(this, portName, 9600);
  serialPort.buffer(inByte.length); // 読み込むバッファの長さをの指定

  oval1 = 100;
  sendServo(1, oval1);
  oval2 = 100;
  sendServo(2, oval2);
}

void draw() {
  background(255);
  //
  if(mousePressed){
    mouseP = true;
  }
  if(mouseP){
  front.Draw();
  }
  //
  if(front.b.x >= width){
    oval1 = 70;
    sendServo(1, oval1);
  }
  if(front.c.x >= width){
    oval2 = 70;
    sendServo(2, oval2);
  }
  
  //
}

// シリアルポートにデータが受信されると呼び出されるメソッド
void serialEvent(Serial port) {
  inByte = port.readBytes();

  if(firstContact == false) {
    if(inByte[0] == 'C') { // Arduinoとの接続確認
      port.clear();
      firstContact = true;
      sendServo(1, 100);
      sendServo(2, 100);
    } 
  }
}

// シリアルポートにサーボの値を送るメソッド
void sendServo(int id, int value)
{
  if(!firstContact) return;
  int v = value;
  if(v < 15) v = 15; // サーボの最小値。個体差による。
  if(v > 125) v = 125; // サーボの最大値。個体差による。
  serialPort.write((byte)'S');
  serialPort.write((byte)id);
  serialPort.write((byte)v);
  
  
}

// キー入力メソッド。デバッグ用。
void keyPressed() {
  switch(key){
  case 'z':
    oval1 += 1; // zキーがおされたら値を1増やす。
    sendServo(1, oval1);
    break;
  case 'x':
    oval1 -= 1; // xキーがおされたら値を1減らす。
    sendServo(1, oval1);
    break;
  case 'c':////
    oval1 = 70;
    sendServo(1, oval1);
    break;
  case 'v':////
    oval1 = 100;
    sendServo(1, oval1);
    break;
  case 'y':////
    oval2 = 70;
    sendServo(2, oval2);
    break;
  case 'u'://///
    oval2 = 100;
    sendServo(2, oval2);
    break;
  default:
    break;
  }
}
