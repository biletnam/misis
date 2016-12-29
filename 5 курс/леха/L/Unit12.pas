unit Unit12;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls;

type
  TForm12 = class(TForm)
    Table1: TTable;
    GroupBox1: TGroupBox;
    Chart1: TChart;
    Series1: TBarSeries;
    GroupBox2: TGroupBox;
    Chart2: TChart;
    BarSeries1: TBarSeries;
    GroupBox3: TGroupBox;
    Chart3: TChart;
    BarSeries2: TBarSeries;
    GroupBox4: TGroupBox;
    Chart4: TChart;
    BarSeries3: TBarSeries;
    GroupBox5: TGroupBox;
    Chart5: TChart;
    BarSeries4: TBarSeries;
    GroupBox6: TGroupBox;
    Chart6: TChart;
    BarSeries5: TBarSeries;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

{$R *.dfm}

procedure TForm12.FormShow(Sender: TObject);
var kkk, year, count : integer;
i,r,t,d,s,oa,ddz,zup,ko,ta,z,to2,ds,kf: double;
r1,r2,r3,r4,r5,r6: double;
str: string;
begin
  Table1.Last;
  count := Table1.RecordCount;

  for kkk := count downto 1 do
    begin
      year := Table1.FieldByName('god').Value;
      i := Table1.FieldByName('i').Value;
      r := Table1.FieldByName('r').Value;
      t := Table1.FieldByName('t').Value;
      d := Table1.FieldByName('d').Value;
      s := Table1.FieldByName('c').Value;
      oa := Table1.FieldByName('oa').Value;
      ddz := Table1.FieldByName('ddz').Value;
      zup := Table1.FieldByName('zup').Value;
      ko := Table1.FieldByName('ko').Value;
      ta := Table1.FieldByName('ta').Value;
      z := Table1.FieldByName('z').Value;
      to2 := Table1.FieldByName('to').Value;
      ds := Table1.FieldByName('ds').Value;
      kf := Table1.FieldByName('kf').Value;






      r1 := r+i+r*i;
      r2 := (s*d)/t;
      r3 := t/s;
      r4 := (oa-ddz-zup)/ko;
      r5 := (ta-z)/to2;
      r6 := (ds+kf)/to2;



      Chart1.Series[0].Add(r1, IntToStr(year));
      Chart2.Series[0].Add(r2, IntToStr(year));
      Chart3.Series[0].Add(r3, IntToStr(year));
      Chart4.Series[0].Add(r4, IntToStr(year));
      Chart5.Series[0].Add(r5, IntToStr(year));
      Chart6.Series[0].Add(r6, IntToStr(year));
      Table1.Prior;
    end;
end;

end.
