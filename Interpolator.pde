abstract class Interpolator
{
  Animation animation;
  
  // Where we at in the animation?
  float currentTime = 0;
  
  // To interpolate, or not to interpolate... that is the question
  /*If snapping is true, we do not interpolate. 
    If it is false, we do interpolate!
    */ 
  boolean snapping = false;
  
  void SetAnimation(Animation anim) //<>//
  {
    animation = anim;
  }
  
  void SetFrameSnapping(boolean snap)
  {
    snapping = snap;
  }
  
  void UpdateTime(float time)
  {
    // TODO: Update the current time
    // Check to see if the time is out of bounds (0 / Animation_Duration)
    // If so, adjust by an appropriate amount to loop correctly
    
    if (time == 0) {  //<>//
      time++; 
    } 
    else if (time == animation.GetDuration()) { 
      time = 0; 
    } 
    else { 
      time++;
    } 
  }
  
  // Implement this in derived classes
  // Each of those should call UpdateTime() and pass the time parameter
  // Call that function FIRST to ensure proper synching of animations
  abstract void Update(float time);
}

class ShapeInterpolator extends Interpolator
{
  
  // The result of the data calculations - either snapping or interpolating
  PShape currentShape;
  
  // Changing mesh colors
  color fillColor;
  
  PShape GetShape()
  {
    return currentShape;
  }
  
  void Update(float time)
  {
    UpdateTime(time); 
    // TODO: Create a new PShape by interpolating between two existing key frames
    // using linear interpolation

   // PShape shapey = ..
  }
}

class PositionInterpolator extends Interpolator
{
   //This is the current position, so the PVector in points arraylist
  PVector currentPosition;
  PVector number;  //<>//
  
  void Update(float time)
  {
    UpdateTime(time); 
    
    // The same type of process as the ShapeInterpolator class... except
    // this only operates on a single point
    println("this is the time: time"); 
     println("do it");  //<>//
     time++; 
   
   for (int i= 0; i < animation.keyFrames.size(); i++) { 
     KeyFrame nextT = new KeyFrame(); 
     KeyFrame prevT = new KeyFrame(); 
   
     
     //We are going to iterate and find our previous and next keyframes
      for (int j = 0; j < animation.keyFrames.size(); j++) { 
      
       // Keep track of the next keyframe
        KeyFrame tracker = animation.keyFrames.get(j+1); 
      
      if (tracker.time > time) { 
          nextT = tracker;
          nextT.time = tracker.time; 
          prevT = animation.keyFrames.get(j);
          prevT.time = animation.keyFrames.get(j).time; 
          break; 
        } 
      
      println("in the for loop"); 
      
    } 
    
   float ratio = (time - prevT.time) / (nextT.time - prevT.time); 
    
    
   for (int k=0; k < nextT.points.size(); k++) {  //<>//
     
      
     number = new PVector(); 
      number = (nextT.points.get(k).sub(prevT.points.get(k))).mult(ratio); 
     
    currentPosition =  prevT.points.get(k).add(number); 
 
    
   
    
     } 
    } 
   

    
    
   } 
  }
 
