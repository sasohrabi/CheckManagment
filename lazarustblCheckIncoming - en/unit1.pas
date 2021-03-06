  unit Unit1;

  {$mode objfpc}{$H+}

  interface

  uses
    Classes, SysUtils, odbcconn, sqldb, sqlite3conn, db, FileUtil, PrintersDlgs,
    LR_DBSet, LR_Class, Forms, Controls, Graphics, Dialogs,
    DBGrids, DbCtrls, StdCtrls, LCLType, MaskEdit, Buttons, PairSplitter,
    ComCtrls, ExtCtrls, Grids, LR_DSet;


  type

    { TForm1 }

    TForm1 = class(TForm)
      Button2: TButton;
      ComboBox1: TComboBox;
      Edit5: TMaskEdit;
      Edit7: TMaskEdit;
      frDBDataSet1: TfrDBDataSet;
      frReport1: TfrReport;
      select: TButton;
      Button3: TButton;
      Button4: TButton;
      CheckBox1: TCheckBox;
      insert: TButton;
      Datasource1: TDatasource;
      DBGrid1: TDBGrid;
      Edit1: TEdit;
      Edit2: TEdit;
      Edit3: TEdit;
      Edit4: TEdit;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      Label6: TLabel;
      Label7: TLabel;
      Label8: TLabel;
      SpeedButton1: TSpeedButton;
      SpeedButton2: TSpeedButton;
      SpeedButton3: TSpeedButton;
      SQLite3Connection1: TSQLite3Connection;
      SQLQuery1: TSQLQuery;
      SQLQuery2: TSQLQuery;
      SQLQuery3: TSQLQuery;
      SQLQuery3sip: TLargeintField;
      SQLQuery4: TSQLQuery;
      SQLQuery4siup: TLargeintField;
      SQLTransaction1: TSQLTransaction;
      procedure Button1Click(Sender: TObject);
      procedure Button2Click(Sender: TObject);
      procedure Button3Click(Sender: TObject);
      procedure Button4Click(Sender: TObject);
      procedure CheckBox1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
      procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
      procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure Edit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure Edit5KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure Edit6KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure Edit7KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure frDBDataSet1CheckEOF(Sender: TObject; var Eof: Boolean);
      procedure insertClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
      procedure FormCreate(Sender: TObject);
      procedure selectClick(Sender: TObject);
      procedure SpeedButton1Click(Sender: TObject);
      procedure SpeedButton2Click(Sender: TObject);
      procedure SpeedButton3Click(Sender: TObject);
    private
      { private declarations }
      var
        id:Integer;
      const
        strSQL:string='SELECT tblCheckIncoming.id,tblCheckIncoming.DescCheck, tblCheckIncoming.NameBank, tblCheckIncoming.NumberCheck' +
          ', tblCheckIncoming.AmountCheck' +
          ', tblCheckIncoming.DateIssuance, tblCheckIncoming.PartyAccount, tblCheckIncoming.DateUsance,' +
          ' tblCheckIncoming.pass, tblPartyAccount.PartyAccount as namefamilyparty ' +
          ' FROM tblPartyAccount INNER JOIN tblCheckIncoming ON tblPartyAccount.[code] = tblCheckIncoming.[PartyAccount];';
    public
      { public declarations }
        procedure ShowInEditBoxes;
        procedure SQLiteUpdate;
        procedure SQLiteDelete;
        procedure SQLiteInsert;
        procedure RefreshForm;
        procedure fillcomboPartyAccount;
    end;

  var
    Form1: TForm1;

  implementation

  uses
  Unit3;

  {$R *.lfm}

  { TForm1 }
  procedure TForm1.fillcomboPartyAccount;
  begin
    SQLQuery2.Open;
    while not SQLQuery2.EOF do
      begin
       {$ifdef win32}
       ComboBox1.Items.AddObject(SQLQuery2.FieldByName('PartyAccount').AsString, TObject(SQLQuery2.FieldByName('code').AsInteger));
       {$endif}
       {$ifdef Unix}
       ComboBox1.Items.AddObject(SQLQuery2.FieldByName('PartyAccount').AsString, TObject(SQLQuery2.FieldByName('code').AsLargeInt));
       {$endif}
        
       SQLQuery2.Next;
      end;
    SQLQuery2.close;
  end;

  procedure TForm1.RefreshForm;
  begin
    SQLQuery1.Close;
   // SQLQuery1.SQL.Text:='Select id,DescCheck,NameBank,NumberCheck,AmountCheck,DateIssuance,PartyAccount,DateUsance,pass FROM tblCheckIncoming';
    SQLQuery1.SQL.Text:= strSQL;
    SQLQuery1.Open;
  end;

  procedure TForm1.ShowInEditBoxes;
  begin
    id:= DBGrid1.Datasource.Dataset.Fields[0].AsInteger ;
    edit1.text:=DBGrid1.Datasource.Dataset.Fields[1].AsString;
    edit2.text:=DBGrid1.Datasource.Dataset.Fields[2].AsString;
    edit3.text:=DBGrid1.Datasource.Dataset.Fields[3].AsString;
    edit4.text:=DBGrid1.Datasource.Dataset.Fields[4].AsString;
    edit5.text:=DBGrid1.Datasource.Dataset.Fields[5].AsString;
    ComboBox1.Text:=DBGrid1.Datasource.Dataset.Fields[9].AsString;
    edit7.text:=DBGrid1.Datasource.Dataset.Fields[7].AsString;

    if DBGrid1.Datasource.Dataset.Fields[8].AsBoolean = True then
     CheckBox1.State := cbChecked
    else
     CheckBox1.State := cbUnchecked;
  end;

  procedure TForm1.SQLiteUpdate;
  begin
    SQLQuery1.Close;
    SQLQuery1.SQL.text:='Update tblCheckIncoming SET DescCheck = :DescCheck, NameBank = :NameBank, NumberCheck = :NumberCheck, AmountCheck =:AmountCheck,DateIssuance = :DateIssuance, PartyAccount = :PartyAccount, DateUsance = :DateUsance,pass = :pass WHERE id = :id;';
    SQLQuery1.Params.ParamByName('DescCheck').AsString:=edit1.text;
    SQLQuery1.Params.ParamByName('NameBank').AsString:=edit2.text;
    SQLQuery1.Params.ParamByName('NumberCheck').AsString:=edit3.text;
    SQLQuery1.Params.ParamByName('AmountCheck').AsString:=edit4.text;
    SQLQuery1.Params.ParamByName('DateIssuance').AsString:=edit5.text;
    //SQLQuery1.Params.ParamByName('PartyAccount').AsInteger:=StrToInt(edit6.text);
    {$ifdef win32}
    SQLQuery1.Params.ParamByName('PartyAccount').AsInteger:=Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
    {$endif}
    {$ifdef Unix}
    SQLQuery1.Params.ParamByName('PartyAccount').AsLargeInt:=LargeInt(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
    {$endif}
    SQLQuery1.Params.ParamByName('DateUsance').AsString:=edit7.text;
    SQLQuery1.Params.ParamByName('id').AsInteger:=id;
    if CheckBox1.State = cbChecked then
     SQLQuery1.Params.ParamByName('pass').AsBoolean:=True
    else
     SQLQuery1.Params.ParamByName('pass').AsBoolean:=False;
    SQLQuery1.ExecSQL;
    SQLTransaction1.commit;
    RefreshForm;
  end;

  procedure TForm1.SQLiteDelete;
  var
    rownumber:Integer;
  begin
    rownumber := DBGrid1.Datasource.Dataset.Fields[0].AsInteger;
    SQLQuery1.Close;
    SQLQuery1.SQL.Text:='DELETE FROM tblCheckIncoming WHERE id= (:rownumber);';
    SQLQuery1.Params.ParamByName('rownumber').AsInteger:=rownumber;
    SQLQuery1.ExecSQL;
    SQLTransaction1.commit;
    RefreshForm;
  end;

  procedure TForm1.SQLiteInsert;
  begin
    SQLQuery1.Close;
    SQLQuery1.SQL.text:='INSERT INTO tblCheckIncoming(id,DescCheck,NameBank,NumberCheck,AmountCheck,DateIssuance,PartyAccount,DateUsance,pass) VALUES (NULL,:DescCheck, :NameBank, :NumberCheck, :AmountCheck,:DateIssuance,:PartyAccount,:DateUsance,:pass);';
    SQLQuery1.Params.ParamByName('DescCheck').AsString:=edit1.text;
    SQLQuery1.Params.ParamByName('NameBank').AsString:=edit2.text;
    SQLQuery1.Params.ParamByName('NumberCheck').AsString:=edit3.text;
    SQLQuery1.Params.ParamByName('AmountCheck').AsString:=edit4.text;
    SQLQuery1.Params.ParamByName('DateIssuance').AsString:=edit5.text;
    {$ifdef win32}
    SQLQuery1.Params.ParamByName('PartyAccount').AsInteger:=Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
    {$endif}
    {$ifdef Unix}
    SQLQuery1.Params.ParamByName('PartyAccount').AsInteger:=LargeInt(ComboBox1.Items.Objects[ComboBox1.ItemIndex]); 
    {$endif}
    SQLQuery1.Params.ParamByName('DateUsance').AsString:=edit7.text;
    if CheckBox1.State = cbChecked then
     SQLQuery1.Params.ParamByName('pass').AsBoolean:=True
    else
     SQLQuery1.Params.ParamByName('pass').AsBoolean:=False;

    SQLQuery1.ExecSQL;
    SQLTransaction1.commit;
    RefreshForm;
  end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     {$ifdef win32}
     SQLiteLibraryName:='sqlite3.7.11.dll';
     SQLite3Connection1.DatabaseName:= ExtractFilePath(Application.ExeName) + 'checkrecived.sqlite';
     {$endif}
     {$ifdef Unix}
     SQLiteLibraryName:= ExtractFilePath(Application.ExeName) + 'libdbdsqlite3.so';
     SQLite3Connection1.DatabaseName := 'checkrecived.sqlite';  
     {$endif}

     SQLite3Connection1.Connected:=true;

     SQLTransaction1.Database:=SQLite3Connection1;

     SQLQuery1.Database:=SQLite3Connection1; SQLQuery2.DataBase:= SQLite3Connection1; SQLQuery3.DataBase:=SQLite3Connection1; SQLQuery4.DataBase:= SQLite3Connection1;
     SQLQuery1.SQL.text:=strSQL; SQLQuery2.sql.Text:='select code,PartyAccount from tblPartyAccount';SQLQuery3.sql.text := 'SELECT sip FROM passincoming'; SQLQuery4.sql.text := 'SELECT siup FROM unpassincoming';
     SQLQuery1.open; SQLQuery3.open; SQLQuery4.open;

     DataSource1.DataSet:=SQLQuery1;

     DBGrid1.DataSource:=DataSource1;

     DBGrid1.AutoFillColumns:=true;

     frDBDataSet1.DataSet:=SQLQuery1;
     frDBDataSet1.DataSet.Active:=true;
     frReport1.DataSet:=frDBDataSet1;

     RefreshForm;
     fillcomboPartyAccount;
end;


procedure TForm1.selectClick(Sender: TObject);
begin
    ShowInEditBoxes;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  halt;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  Edit5.EditText:=MiladyToShamsi(date);
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  edit7.EditText:=MiladyToShamsi(date);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   SQLiteUpdate;
end;

procedure TForm1.CheckBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key=VK_RETURN then SelectNext(ActiveControl, true, true);
end;

procedure TForm1.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_RETURN then SelectNext(ActiveControl, true, true);
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key=VK_RETURN then
   begin
        SelectNext(ActiveControl, true, true);
   end;
end;

procedure TForm1.Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then SelectNext(ActiveControl, true, true);
end;

procedure TForm1.Edit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then SelectNext(ActiveControl, true, true);
end;

procedure TForm1.Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then SelectNext(ActiveControl, true, true);
end;

procedure TForm1.Edit5KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then SelectNext(ActiveControl, true, true);
end;

  procedure TForm1.Edit6KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then SelectNext(ActiveControl, true, true);
end;

procedure TForm1.Edit7KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then SelectNext(ActiveControl, true, true);
end;

procedure TForm1.frDBDataSet1CheckEOF(Sender: TObject; var Eof: Boolean);
begin

end;

procedure TForm1.insertClick(Sender: TObject);
begin
  Edit1.Text:=''; Edit2.Text:=''; Edit3.Text:=''; Edit4.Text:='';
  Edit5.Clear; ComboBox1.Text:=''; Edit7.Clear; CheckBox1.State:=cbUnchecked;
  ComboBox1.SetFocus;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  SQLiteDelete;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

  frReport1.LoadFromFile('lrfincoming.lrf');
  frReport1.ShowReport;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  SQLiteInsert;
  insertClick(insert); // or use-> insert.click;
end;
procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    SQLQuery1.Close;
    SQLQuery2.Close;
    SQLQuery3.Close;
    SQLQuery4.Close;
    //Edit1.Text:=DBEdit9.Text;
end;

end.

