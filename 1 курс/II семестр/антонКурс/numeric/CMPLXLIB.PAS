{library of elementary complex number operations. From 'Pascal Applications
for the Sciences', Crandall.}

(************ THIS DECLARATION IS REQUIRED ***********************
type   cmpl = record x, y: real end;
******************************************************************)

procedure sum(Z, W: cmpl; var S: cmpl);
begin
   with S do begin X := Z.X + W.X; Y := Z.Y + W.Y  end
end;

procedure dif(Z, W: cmpl;  var S: cmpl);
begin
   with S do begin X := Z.X - W.X;  Y := Z.Y - W.Y end
end;

procedure prd(Z, W: cmpl; var S: cmpl);
begin
   with S do begin
       X := Z.X * W.X - Z.Y * W.Y;
       Y := Z.X * W.Y + Z.Y * W.X
       end
end;

procedure quo(Z, W: cmpl; var S: cmpl);
var R: real;
begin
   with W do begin
       R := sqr(X) + sqr(Y);
       X := X/R;   Y := -Y/R
       end;
   prd(Z, W, S)
end;

function absl(Z: cmpl): real;
begin
   with Z do absl := sqrt(sqr(X) + sqr(Y))
end;

procedure polar(Z: cmpl; var R, TH: real);
begin
   R := absl(Z);
   if Z.X > 0 then TH := arctan(Z.Y/Z.X)
   else if Z.X < 0 then TH := pi + arctan(Z.Y/Z.X)
   else if Z.Y >= 0 then TH := 0.5*pi
   else TH := -0.5*pi
end;

