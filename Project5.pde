// VertexAnimation Project - Student Version
import java.io.*;
import java.util.*;


float positionX, positionY, positionZ; 
float rotation = 0; 
float posX, posY, posZ; 
PVector camPos; 
int segmentCount = 20; 
float angleStep = 360/segmentCount; 
float fanRad = 10; 

PShape triangle;  
PShape monster; 
float sX = -0.5; 
float sY = 0.5; 
float sZ = 0.5; 
float rad = 1; 
PVector target; 
int numSides = 20; 
int value = 0; 


Camera camera = new Camera(); 
/*========== Monsters ==========*/
Animation monsterAnim;
ShapeInterpolator monsterForward = new ShapeInterpolator();
ShapeInterpolator monsterReverse = new ShapeInterpolator();
ShapeInterpolator monsterSnap = new ShapeInterpolator();

/*========== Sphere ==========*/
Animation sphereAnim; // Load from file
Animation spherePos; // Create manually
ShapeInterpolator sphereForward = new ShapeInterpolator();
PositionInterpolator spherePosition = new PositionInterpolator();




// TODO: Create animations for interpolators
PositionInterpolator cubePos = new PositionInterpolator(); 
ArrayList<PositionInterpolator> cubes = new ArrayList<PositionInterpolator>();

void setup()
{
  //pixelDensity(2);
  size(1200, 800, P3D);
 
  /*====== Load Animations ======*/
  monsterAnim = ReadAnimationFromFile("monster.txt");
  sphereAnim = ReadAnimationFromFile("sphere.txt");

  monsterForward.SetAnimation(monsterAnim);
  monsterReverse.SetAnimation(monsterAnim);
  monsterSnap.SetAnimation(monsterAnim);  
  monsterSnap.SetFrameSnapping(true);

  sphereForward.SetAnimation(sphereAnim);

  /*====== Create Animations For Cubes ======*/
  // When initializing animations, to offset them
  // you can "initialize" them by calling Update()
  // with a time value update. Each is 0.1 seconds
  // ahead of the previous one
  

  Animation cubeAnim = new Animation(); 
  
  
  float time;  
   KeyFrame KeyFrame = new KeyFrame(); 
   ArrayList<PVector> points = new ArrayList<PVector>();
   PVector p = new PVector(-100,0,0); 
   // The points have been added to the keyframe array 
   KeyFrame.points.add(p); 
   // We added the time of the keyframe! 
   KeyFrame.time = 0; 
   cubeAnim.keyFrames.add(0,KeyFrame);
//   cubePos.Update(KeyFrame.time); 
   
  // Second position KeyFrame[1]
  KeyFrame = new KeyFrame(); 
  points = new ArrayList<PVector>();
  p = new PVector(-100,0,100); 
  KeyFrame.points.add(p);
  KeyFrame.time = 2; 
  cubeAnim.keyFrames.add(1,KeyFrame); 
  //cubePos.Update(playbackSpeed); 
  
  // Third position KeyFrame[2]
  KeyFrame = new KeyFrame(); 
  points = new ArrayList<PVector>();
  p = new PVector(-100,0,0); 
  KeyFrame.points.add(p); 
  KeyFrame.time = 4; 
  cubeAnim.keyFrames.add(2,KeyFrame); 
  //cubePos.Update(KeyFrame.time); 
  
  // Fourth position KeyFrame[3]
  KeyFrame = new KeyFrame();  //<>//
  points = new ArrayList<PVector>();
  p = new PVector(-100,0,-100); 
  KeyFrame.points.add(p); 
  KeyFrame.time = 6; 
 // cubePos.Update(KeyFrame.time); 
  cubeAnim.keyFrames.add(3,KeyFrame);  //<>//
  
  cubePos.SetAnimation(cubeAnim); 
  cubePos.Update(0);  //<>//
  
  
  
  /*====== Create Animations For Spheroid ======*/
  Animation spherePos = new Animation();
  // Create and set keyframes
  //spherePosition.SetAnimation(spherePos);
  

}

void draw()
{
  lights();
  background(0);
  DrawGrid();

  float playbackSpeed = 0.005f;

  // TODO: Implement your own camera
  camera.Update(); 
  camera(camera.cameraPosition.x, camera.cameraPosition.y,camera.cameraPosition.z,camera.LookatTarget.x,camera.LookatTarget.y,camera.LookatTarget.z,0,1,0); 


  /*====== Draw Forward Monster ======*/
  /*pushMatrix();
  translate(-40, 0, 0);
  monsterForward.fillColor = color(128, 200, 54);
  monsterForward.Update(playbackSpeed);
  shape(monsterForward.currentShape);
  popMatrix();
  */ 
  /*====== Draw Reverse Monster ======*/
  /*
  pushMatrix();
  translate(40, 0, 0);
  monsterReverse.fillColor = color(220, 80, 45);
  monsterReverse.Update(-playbackSpeed);
  shape(monsterReverse.currentShape);
  popMatrix();
  */ 
  /*====== Draw Snapped Monster ======*/
  /*
  pushMatrix();
  translate(0, 0, -60);
  monsterSnap.fillColor = color(160, 120, 85);
  monsterSnap.Update(playbackSpeed);
  shape(monsterSnap.currentShape);
  popMatrix();
  */ 
  /*====== Draw Spheroid ======*/
  /*
  spherePosition.Update(playbackSpeed);
  sphereForward.fillColor = color(39, 110, 190);
  sphereForward.Update(playbackSpeed);
  PVector pos = spherePosition.currentPosition;
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  shape(sphereForward.currentShape);
  popMatrix();
  */ 
  
  /*====== TODO: Update and draw cubes ======*/
  // For each interpolator, update/draw
   cubes(); 
   
} 

PShape cubes () { 
   float playbackSpeed = 0.005f;
  PShape cubeShape = createShape(); 
  pushMatrix(); 
 // translate(-100,0,-100); 
  cubeShape.scale(5,5,5); 
  cubeShape.beginShape(TRIANGLE); 
  cubeShape.translate(-100,0,0); 
  cubeShape.fill(#FF0000); 
  cubeShape.vertex(sX,sY,sZ); 
  cubeShape.vertex(sX+rad,sY,sZ); 
  cubeShape.vertex(sX,sY-rad,sZ); 
  
  cubeShape.fill(#FF0000); 
  cubeShape.vertex(sX,sY-rad,sZ); 
  cubeShape.vertex(sX+rad,sY,sZ); 
  cubeShape.vertex(sX+rad,sY-rad,sZ); 
  
  cubeShape.fill(#FF0000); 
  cubeShape.vertex(sX,sY-rad,sZ); 
  cubeShape.vertex(sX,sY-rad,sZ-rad); 
  cubeShape.vertex(sX+rad,sY-rad,sZ); 
  
  cubeShape.fill(#FF0000); 
  cubeShape.vertex(sX,sY-rad,sZ-rad); 
  cubeShape.vertex(sX+rad,sY-rad,sZ); 
  cubeShape.vertex(sX+rad,sY-rad,sZ-rad); 
  
  cubeShape.fill(#FF0000); 
  cubeShape.vertex(sX+rad,sY,sZ); 
  cubeShape.vertex(sX+rad,sY-rad,sZ); 
  cubeShape.vertex(sX+rad,sY-rad,sZ-rad); 
   
  
  cubeShape.fill(#FF0000); 
  cubeShape.vertex(sX+rad,sY,sZ); 
  cubeShape.vertex(sX+rad,sY,sZ-rad); 
  cubeShape.vertex(sX+rad,sY-rad,sZ-rad); 
  
  cubeShape.fill(#FF0000);
  cubeShape.vertex(sX,sY,sZ); 
  cubeShape.vertex(sX+rad,sY,sZ); 
  cubeShape.vertex(sX,sY,sZ-rad); 
  

  cubeShape.fill(#FF0000); 
  cubeShape.vertex(sX+rad,sY,sZ); 
  cubeShape.vertex(sX,sY,sZ-rad); 
  cubeShape.vertex(sX+rad,sY,sZ-rad); 
  
  cubeShape.fill(#FF0000); 
  cubeShape.vertex(sX,sY,sZ-rad); 
  cubeShape.vertex(sX,sY-rad,sZ-rad); 
  cubeShape.vertex(sX+rad,sY,sZ-rad); 
  
  cubeShape.fill(#FF0000); 
  cubeShape.vertex(sX,sY-rad,sZ-rad); 
  cubeShape.vertex(sX+rad,sY-rad,sZ-rad); 
  cubeShape.vertex(sX+rad,sY,sZ-rad); 
  
  cubeShape.fill(#FF0000); 
  cubeShape.vertex(sX,sY,sZ); 
  cubeShape.vertex(sX,sY-rad,sZ); 
  cubeShape.vertex(sX,sY-rad,sZ-rad); 
  
  cubeShape.fill(#FF0000); 
  cubeShape.vertex(sX,sY,sZ); 
  cubeShape.vertex(sX,sY,sZ-rad); 
  cubeShape.vertex(sX,sY-rad,sZ-rad); 
  cubeShape.endShape(TRIANGLE);
  cubeShape.setStroke(false); 
  shape(cubeShape);
  cubePos.Update(playbackSpeed); 
  popMatrix();
  
  return cubeShape; 
}

void mouseWheel(MouseEvent event)
{
  float e = event.getCount();
  // Zoom the camera
  // SomeCameraClass.zoom(e);
  println(e);
   camera.Zoom(e); 
}

// Create and return an animation object
Animation ReadAnimationFromFile(String fileName)
{
  Animation animation = new Animation();

  // The BufferedReader class will let you read in the file data
  //try
  //{
  //  BufferedReader reader = createReader(fileName);
    
  //}
  //catch (FileNotFoundException ex)
  //{
  //  println("File not found: " + fileName);
  //}
  //catch (IOException ex)
  //{
  //  ex.printStackTrace();
  //}
 
  return animation;
}

void DrawGrid()
{
  // TODO: Draw the grid
  // Dimensions: 200x200 (-100 to +100 on X and Z)
  for (int i=-100; i< 101; i++) { 
    stroke(255); 
    line(i,0,100,i,0,-100); 
    i+=10; 
  } 
   
  for (int j=-100; j< 101; j++) { 
    stroke(255); 
    line(100,0,j,-100,0,j); 
    j+=10; 
  } 
  stroke(255,0,0);
  strokeWeight(3); 
  line(0,0,100,0,0,-100); 
  
  stroke(0,0,255); 
  strokeWeight(3); 
  line(100,0,0,-100,0,0); 
  
  
}
