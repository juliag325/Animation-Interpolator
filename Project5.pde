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
  
  /*====== Create Animations For Spheroid ======*/
  //Animation spherePos = new Animation();
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
  
  PShape cube = createShape(); 
  pushMatrix(); 
 // translate(-100,0,-100); 
  cube.scale(5,5,5); 
  cube.beginShape(TRIANGLE); 
  cube.translate(-100,0,-100); 
  cube.fill(#FF0000); 
  cube.vertex(sX,sY,sZ); 
  cube.vertex(sX+rad,sY,sZ); 
  cube.vertex(sX,sY-rad,sZ); 
  
  cube.fill(#FF0000); 
  cube.vertex(sX,sY-rad,sZ); 
  cube.vertex(sX+rad,sY,sZ); 
  cube.vertex(sX+rad,sY-rad,sZ); 
  
  cube.fill(#FF0000); 
  cube.vertex(sX,sY-rad,sZ); 
  cube.vertex(sX,sY-rad,sZ-rad); 
  cube.vertex(sX+rad,sY-rad,sZ); 
  
  cube.fill(#FF0000); 
  cube.vertex(sX,sY-rad,sZ-rad); 
  cube.vertex(sX+rad,sY-rad,sZ); 
  cube.vertex(sX+rad,sY-rad,sZ-rad); 
  
  cube.fill(#FF0000); 
  cube.vertex(sX+rad,sY,sZ); 
  cube.vertex(sX+rad,sY-rad,sZ); 
  cube.vertex(sX+rad,sY-rad,sZ-rad); 
   
  
  cube.fill(#FF0000); 
  cube.vertex(sX+rad,sY,sZ); 
  cube.vertex(sX+rad,sY,sZ-rad); 
  cube.vertex(sX+rad,sY-rad,sZ-rad); 
  
  cube.fill(#FF0000);
  cube.vertex(sX,sY,sZ); 
  cube.vertex(sX+rad,sY,sZ); 
  cube.vertex(sX,sY,sZ-rad); 
  

  cube.fill(#FF0000); 
  cube.vertex(sX+rad,sY,sZ); 
  cube.vertex(sX,sY,sZ-rad); 
  cube.vertex(sX+rad,sY,sZ-rad); 
  
  cube.fill(#FF0000); 
  cube.vertex(sX,sY,sZ-rad); 
  cube.vertex(sX,sY-rad,sZ-rad); 
  cube.vertex(sX+rad,sY,sZ-rad); 
  
  cube.fill(#FF0000); 
  cube.vertex(sX,sY-rad,sZ-rad); 
  cube.vertex(sX+rad,sY-rad,sZ-rad); 
  cube.vertex(sX+rad,sY,sZ-rad); 
  
  cube.fill(#FF0000); 
  cube.vertex(sX,sY,sZ); 
  cube.vertex(sX,sY-rad,sZ); 
  cube.vertex(sX,sY-rad,sZ-rad); 
  
  cube.fill(#FF0000); 
  cube.vertex(sX,sY,sZ); 
  cube.vertex(sX,sY,sZ-rad); 
  cube.vertex(sX,sY-rad,sZ-rad); 
  cube.endShape(TRIANGLE);
  cube.setStroke(false); 
  popMatrix(); 
  shape(cube);
  


    KeyFrame keyframe = new KeyFrame(); 
    ArrayList<PVector> points = new ArrayList<PVector>();
    PVector p = new PVector(-100,0,0); 
    points.add(p); 
    
 
    
  
  
  //Animation animation = new Animation(); 
  //animation.GetDuration(); 
  
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