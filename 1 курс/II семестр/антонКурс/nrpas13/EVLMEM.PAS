FUNCTION evlmem(fdt: real; cof: glmarray; m: integer; pm: real): real;
(* Programs using routine EVLMEM must define the types
TYPE
   glmarray = ARRAY [1..m] OF real;
where m is the dimension of the array of coefficients. *)
VAR
   wr,wi,wpr,wpi,wtemp,theta: double;
   sumi,sumr: real;
   i: integer;
BEGIN
   theta := 6.28318530717959*fdt;
   wpr := cos(theta);
   wpi := sin(theta);
   wr := 1.0;
   wi := 0.0;
   sumr := 1.0;
   sumi := 0.0;
   FOR i := 1 TO m DO BEGIN
      wtemp := wr;
      wr := wr*wpr-wi*wpi;
      wi := wi*wpr+wtemp*wpi;
      sumr := sumr-cof[i]*sngl(wr);
      sumi := sumi-cof[i]*sngl(wi)
   END;
   evlmem := pm/(sqr(sumr)+sqr(sumi))
END;
