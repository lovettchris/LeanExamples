structure Point where
  x: Float
  y: Float
  deriving Repr

def Point.length (p: Point) : Float :=
  Float.sqrt (p.x*p.x + p.y*p.y)  

#eval 123