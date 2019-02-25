float theta = 0;
PShape nave;
float xNave;
float yNave;
float zNave;
float perspectivaX;
float perspectivaY;
int mode;
float vx;
float vy;
float vz;
float px;
float py;
float ang;
float lastX;
float lastY;

void setup() {
  size(1000, 800,P3D);
  xNave = 0;
  yNave = 0;
  zNave = 0;
  perspectivaX = 0;
  perspectivaY = 0;
  mode = 0;
  perspective();
  px = 0;
  py = 0;
  vx = 0;
  vy = 0;
}

void draw() {
  background(255);
  stroke(0);
  if (mode == 0) {
    perspective();
  } else {
    camera(xNave + px, yNave + py, zNave, mouseX, mouseY, 0, vx, vy, 0);
  }

  pushMatrix();
    translate(width/2, height/2);
    rotateX(perspectivaX);
    rotateY(perspectivaY);
    fill(255, 200, 50);
    sphere(64);
  
    pushMatrix();
      rotate(theta);
      translate(100, 0);
      fill(50, 200, 255);
      sphere(32);
      
      pushMatrix(); 
        rotate(-theta*4);
        translate(36, 0);
        fill(50, 255, 200);
        sphere(12);
      popMatrix();
  
      pushMatrix();
        rotate(theta*2);
        translate(80, 0);
        fill(50, 255, 200);
        sphere(6);
      popMatrix();
    
    popMatrix();
  popMatrix();
  pushMatrix();
    if (mode == 1) {
      xNave = lastX + px;
      yNave = lastY + py;
    }
    if (mode == 0) translate(xNave,yNave,zNave);
    if (mode == 1) translate(xNave,yNave,0);
    nave = createShape(BOX,15);
    beginShape();
    nave.setFill(color(255,0,0));
    nave.setStroke(color(255));
    endShape();
    shape(nave);
  popMatrix();
  
  if (keyPressed) {
      if (keyCode == UP) {
        if (mode == 0) perspectivaX -= 0.02;
        if (mode == 1) py += 5;
      }
      if (keyCode == DOWN) {
        if (mode == 0) perspectivaX += 0.02;
        if (mode == 1) py -= 5;
      }
      if (keyCode == LEFT) {
        if (mode == 0) perspectivaY -= 0.02;
        if (mode == 1) px -= 5;
      }
      if (keyCode == RIGHT) {
        if (mode == 0) perspectivaY += 0.02;
        if (mode == 1) px += 5;
      }
  }
  
  theta += 0.01;
  vx = -sin(radians(ang));
  vy = cos(radians(ang));
}

void mouseMoved() {
  xNave = mouseX;
  yNave = mouseY;
}

void mouseWheel(MouseEvent e) {
  if (mode == 0) {
    zNave += 5*e.getCount();
  } else {
    ang += 5*e.getCount();
  }
}

void keyPressed() {
  
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    if (mode == 1) popMatrix();
    mode = 0;
  }
  if (mouseButton == RIGHT) {
    if (mode == 0) pushMatrix();
    mode = 1;
    lastX = xNave;
    lastY = yNave;
  }
}
