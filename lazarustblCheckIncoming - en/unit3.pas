unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil;

type
  TDataModule1 = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }

  end;

var
  DataModule1: TDataModule1;
  //function MiladyToShamsi(DTime:TDateTime):TDateTime;
  function MiladyToShamsi(DTime:TDateTime):String;

implementation
    function MiladyToShamsi(DTime:TDateTime):String;
    var
      YearEqual:array[0..2,0..2] of integer;
      AddOneDay,AddFarDay:boolean;
      AddTodays:byte;
      Farday:byte;
      ThisDay:word;
      ThisMonth:word;
      ThisYear:word;
      YearDif1:Integer;
      YearDif2:Integer;
      TestRange1,testRange2,
      FarsiRange1,FarsiRange2,P:Integer;
      CurM,CurD:string;
      sYear,sMonth,sDay:Variant;
      Counter:Integer;
      CurDay,CurMonth,CurYear:word;
      Begin
        CurM:='';
        CurD:='';
        YearEqual[1,1]:=1997;
        YearEqual[1,2]:=1998;
        YearEqual[2,1]:=1376;
        YearEqual[2,2]:=1377;
        DecodeDate(DTime,thisyear,thismonth,thisday);
        YearDif1:=ThisYear-1997;
        YearDif2:=ThisYear-1998;
        Testrange1:=1996-(100*4);
        Testrange2:=1996+(100*4);
        FarsiRange1:=1375-(100*4);
        FarsiRange2:=1375+(100*4);
        AddOneDay:=false;
        //Rem------------------------------
        Counter:=TestRange1;
      while TestRange2>=Counter do begin /////////////////////////
        If thisYear=counter then begin
          AddOneDay:=true;
          break;
        end;
        If counter=TestRange2 then break;
          counter:=counter+4
        end;//while

      If AddOneDay then
        addtodays:=1
      Else
        AddTodays:=0;
      //Rem---------------------------------/////////////////
      If (((ThisMonth = 3) and (thisday<(20+AddtoDays)))
      or ( ThisMonth<3)) then
        YearDif1:=yearDif1-1;
      //Rem------------
      If (((thisYear mod 2)<>0) and
      (((thismonth=3) and (thisday>(20-addTodays)))
      or (thisMonth>4))) then
        CurYear:=yearEqual[2,1]+YearDif1
      else begin
        CurYear:=YearEqual[2,1]+YearDif2;
        Counter:=FarsiRange1;
      while counter>FarsiRange2 do begin /////////////////////////
        If CurYear=Counter then begin
          AddFarDay:=true;
          break;
        end;
      end;//while

      If AddFarDay then
      FarDay:=1 else Farday:=0;

      If (((thismonth=3) and (thisday>20-(addToDays)+FarDay)) or (thismonth>3) ) then
        CurYear:=CurYear+1;
      end; //First If

      If AddtoDays=1 then FarDay:=0;
        //Rem---------------------------------
        Case thismonth of
          1:Begin
            If thisday<(21-Farday) then begin
              CurMonth:=10;
              CurDay:=(ThisDay+10)+FarDay;
            end else begin
              CurMonth:=11;
              CurDay:=(ThisDay-20)+FarDay;
        end;
        end;

          2:Begin
                If thisday<(20-Farday) then begin
                CurMonth:=11;
                CurDay:=(ThisDay+11)+FarDay;
                end else begin
                CurMonth:=12;
                CurDay:=(ThisDay-19)+FarDay;
                end;
          End;

          3:Begin
              If thisday<(21-AddToDays) then begin
                CurMonth:=12;
                CurDay:=(ThisDay+9)+AddToDays+FarDay;
              end else begin
                CurMonth:=1;
                CurDay:=(ThisDay-20)+AddToDays;
              end;
          End;

          4:Begin
            If thisday<(21-AddToDays) then begin
              CurMonth:=1;
              CurDay:=(ThisDay+11)+AddToDays;
            end else begin
              CurMonth:=2;
              CurDay:=(ThisDay-20)+AddToDays;
            end;
            End;

          5:Begin
                If thisday<(22-AddToDays) then begin
                  CurMonth:=2;
                  CurDay:=(ThisDay+10)+AddToDays;
                end else begin
                  CurMonth:=3;
                  CurDay:=(ThisDay-21)+AddToDays;
                end;
          End;

          6:Begin
              If thisday<(22-AddToDays) then begin
                CurMonth:=3;
                CurDay:=(ThisDay+10)+AddToDays;
              end else begin
                CurMonth:=4;
                CurDay:=(ThisDay-21)+AddToDays;
              end;
          End;

          7:Begin
              If thisday<(23-AddToDays) then begin
                CurMonth:=4;
                CurDay:=(ThisDay+9)+AddToDays;
              end else begin
                CurMonth:=5;
                CurDay:=(ThisDay-22)+AddToDays;
              end;
          End;

          8:Begin
            If thisday<(23-AddToDays) then begin
                CurMonth:=5;
                CurDay:=(ThisDay+9)+AddToDays;
            end else begin
            CurMonth:=6;
            CurDay:=(ThisDay-22)+AddToDays;
            end;
          End;

        9:Begin
          If thisday<(23-AddToDays) then begin
            CurMonth:=6;
            CurDay:=(ThisDay+9)+AddToDays;
          end else begin
            CurMonth:=7;
            CurDay:=(ThisDay-22)+AddToDays;
          end;
        End;

        10:Begin
          If thisday<(23-AddToDays) then begin
            CurMonth:=7;
            CurDay:=(ThisDay+8)+AddToDays;
          end else begin
            CurMonth:=8;
            CurDay:=(ThisDay-22)+AddToDays;
          end;
        End;

        11:Begin
          If thisday<(22-AddToDays) then begin
            CurMonth:=8;
            CurDay:=(ThisDay+9)+AddToDays;
          end else begin
            CurMonth:=9;
            CurDay:=(ThisDay-21)+AddToDays;
          end;
        End;

          12:Begin
            If thisday<(22-AddToDays) then begin
              CurMonth:=9;
              CurDay:=(ThisDay+9)+AddToDays;
            end else begin
              CurMonth:=10;
              CurDay:=(ThisDay-21)+AddToDays;
            end;
          End;

      end;//case
      //Rem-----------------
      CurM:=Trim(IntTostr(CurMonth));
      CurD:=Trim(IntTostr(CurDay));
      //Rem-----------------
      If CurMonth<10 then
        CurM:='0'+Trim(IntToStr(CurMonth));
      If CurDay<10 then
        CurD:='0'+Trim(IntTostr(CurDay));

      //MiladyToShamsi:=EncodeDate(CurYear,CurMonth,CurDay);
      MiladyToShamsi:=IntTostr(CurYear) + '\' + CurM + '\' + CurD;
    end;
{$R *.lfm}

end.

