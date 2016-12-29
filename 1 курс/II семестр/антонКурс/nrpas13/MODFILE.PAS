    TYPE double = real; char12 = string[12];
    FUNCTION sngl(x:real):real; BEGIN sngl := x END;
    PROCEDURE glopen(VAR infile:text; filename:char12);
        BEGIN assign(infile,filename); reset(infile) END;
