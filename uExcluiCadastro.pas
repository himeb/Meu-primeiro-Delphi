unit uExcluiCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, uBanco, Vcl.Imaging.pngimage;

type
  TForm5 = class(TForm)
    dbGrid: TDBGrid;
    Panel1: TPanel;
    lblTitulo: TLabel;
    Image1: TImage;
    txtNome: TEdit;
    lblNome: TLabel;
    btnExclui: TButton;
    procedure btnExcluiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtNomeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}
procedure TForm5.btnExcluiClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente excluir este registro?','Confirmação de Exclusão',mb_YesNo+mb_Iconerror+mb_DefButton2) = mrYes then
  begin
    Banco.qryDelete.Close;
    Banco.qryDelete.ParamByName('ID').AsInteger := Banco.tbSQL.FieldByName('ID').AsInteger;
    Banco.qryDelete.Execute;
    Banco.Conexao.Commit;
    Application.MessageBox('Registro excluído com sucesso!','Exclusão Confirmada',MB_ICONINFORMATION+MB_OK);
    txtNome.Text := '';
    dbGrid.DataSource.DataSet.Refresh;
  end
  else
  begin
   Banco.Conexao.Rollback;
   dbGrid.DataSource.DataSet.Refresh;
  end;
end;

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  txtNome.Text := '';
  dbGrid.DataSource.DataSet.Refresh;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  dbGrid.DataSource.DataSet.Refresh;
end;

procedure TForm5.txtNomeChange(Sender: TObject);
begin
  Banco.tbSQL.Filtered := False;
  Banco.tbSQL.Filter := 'Nome like' + QuotedStr('%'+txtNome.Text+'%');
  Banco.tbSQL.Filtered := True;
end;
end.
