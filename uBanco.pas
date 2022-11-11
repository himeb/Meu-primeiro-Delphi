unit uBanco;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Comp.UI;

type
  TBanco = class(TDataModule)
    Conexao: TFDConnection;
    tbSQL: TFDTable;
    qrySelect: TFDQuery;
    qryUpdate: TFDQuery;
    qryDelete: TFDQuery;
    qryInsert: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    tbSQLid: TFDAutoIncField;
    tbSQLnome: TStringField;
    tbSQLidade: TIntegerField;
    tbSQLendereco: TStringField;
    tbSQLnumero: TIntegerField;
    tbSQLtelefone: TStringField;
    tbSQLcelular: TStringField;
    tbSQLsexo: TStringField;
    tbSQLnotificacao: TBooleanField;
    dsSQL: TDataSource;
    dsSQL1: TDataSource;
    dsSQL2: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  Banco: TBanco;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TBanco }

procedure TBanco.DataModuleCreate(Sender: TObject);
  begin
    if Conexao.Connected = false then
    begin
    Conexao.Connected := true;
    end;
  end;
end.
