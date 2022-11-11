unit uPesquisaCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, uBanco, Vcl.Buttons, uRealizaCadastro,
  Vcl.Imaging.pngimage;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    lblNome: TLabel;
    Label5: TLabel;
    Sair: TButton;
    lblCelular: TLabel;
    dbGrid: TDBGrid;
    txtNome: TEdit;
    txtCelular: TEdit;
    Panel2: TPanel;
    lblNomeP: TLabel;
    lblIdadeP: TLabel;
    lblSexoP: TLabel;
    lblEnderecoP: TLabel;
    lblNumeroP: TLabel;
    lblTelefoneP: TLabel;
    lblCelularP: TLabel;
    lblIdP: TLabel;
    lblTitulo: TLabel;
    btnSairP: TButton;
    bbtEdit: TBitBtn;
    txtNomeP: TEdit;
    txtEnderecoP: TEdit;
    txtIdadeP: TEdit;
    txtNumeroP: TEdit;
    txtTelefoneP: TEdit;
    txtCelularP: TEdit;
    txtIdP: TEdit;
    btnSalvaP: TButton;
    cbNotificacaoP: TCheckBox;
    Image1: TImage;
    cbSexo: TComboBox;
    procedure txtCelularChange(Sender: TObject);
    procedure btnSairPClick(Sender: TObject);
    procedure SairClick(Sender: TObject);
    procedure dbGridCellClick(Column: TColumn);
    procedure txtNomeChange(Sender: TObject);
    procedure bbtEditClick(Sender: TObject);
    procedure btnSalvaPClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.bbtEditClick(Sender: TObject);
begin
  txtNomeP.Enabled := true;
  txtIdadeP.Enabled := true;
  cbSexo.Enabled := true;
  txtEnderecoP.Enabled := true;
  txtNumeroP.Enabled := true;
  txtTelefoneP.Enabled := true;
  txtCelularP.Enabled := true;
  cbNotificacaoP.Enabled := true;
  btnSalvaP.Enabled := true;
end;

procedure TForm3.btnSairPClick(Sender: TObject);
begin
  txtNomeP.Enabled := false;
  txtIdadeP.Enabled := false;
  cbSexo.Enabled := false;
  txtEnderecoP.Enabled := false;
  txtNumeroP.Enabled := false;
  txtTelefoneP.Enabled := false;
  txtCelularP.Enabled := false;
  cbNotificacaoP.Enabled := false;
  Panel2.Visible := false;
  txtNome.Text :='';
  txtCelular.Text :='';
end;

procedure TForm3.btnSalvaPClick(Sender: TObject);
begin
  try
    Banco.qryUpdate.Close;
    Banco.qryUpdate.ParamByName('ID').AsInteger := Banco.tbSQLId.AsInteger;
    Banco.qryUpdate.ParamByName('NOME').AsString := txtnomeP.Text;
    Banco.qryUpdate.ParamByName('IDADE').AsString := txtIdadeP.Text;
    Banco.qryUpdate.ParamByName('SEXO').AsString := cbSexo.Text;
    Banco.qryUpdate.ParamByName('ENDERECO').AsString := txtEnderecoP.Text;
    Banco.qryUpdate.ParamByName('NUMERO').AsInteger := strToInt(txtNumeroP.Text);
    Banco.qryUpdate.ParamByName('TELEFONE').AsString := txtTelefoneP.Text;
    Banco.qryUpdate.ParamByName('CELULAR').AsString := txtCelularP.Text;
    Banco.qryUpdate.ParamByName('NOTIFICACAO').AsBoolean := cbNotificacaoP.Checked;
    Banco.qryUpdate.Execute;
    //Banco.Conexao.Commit;  precisa startar a transação pra utilizar
    DBGrid.DataSource.DataSet.Refresh;
    Application.MessageBox('Alteração realizada com sucesso','Confirmação',MB_ICONINFORMATION+MB_OK);
    var
    C : Integer;
    begin
      for C := 0 to Self.ComponentCount - 1 do
      if (Self.Components[C] is TEdit) then
      (Self.Components[C] as TEdit).Clear;
    end;
    cbSexo.Text := '';
    cbNotificacaop.Checked := false;
    Panel2.Visible := false;
  except
    on e:exception do
    begin
      //Banco.Conexao.Rollback;    precisa startar transação
      ShowMessage('ERRO '+ e.Message);
    end;
  end;

  end;

procedure TForm3.SairClick(Sender: TObject);
begin
  close;
end;

procedure TForm3.dbGridCellClick(Column: TColumn);
begin
  if (txtNome.Text <> '' )or (txtCelular.Text <> '') then
  begin
    Panel2.Visible := true;
    txtIdP.Text := DbGrid.SelectedField.DataSet.FieldByName('id').AsString;      //b.s.d (table.fbn ...)
    txtNomeP.Text := DbGrid.SelectedField.DataSet.FieldByName('nome').AsString;
    txtIdadeP.Text := DbGrid.SelectedField.DataSet.FieldByName('idade').AsString;
    cbSexo.Text := DbGrid.SelectedField.DataSet.FieldByName('sexo').AsString;
    txtEnderecoP.Text := DbGrid.SelectedField.DataSet.FieldByName('endereco').AsString;
    txtNumeroP.Text := DbGrid.SelectedField.DataSet.FieldByName('numero').AsString;
    txtTelefoneP.Text := DbGrid.SelectedField.DataSet.FieldByName('telefone').AsString;
    txtCelularP.Text := DbGrid.SelectedField.DataSet.FieldByName('celular').AsString;
    cbNotificacaoP.Checked := DbGrid.SelectedField.DataSet.FieldByName('Notificacao').AsBoolean;
  end
  else
  begin
    ShowMessage('Pelo menos um dos campos de pesquisa precisam ser preenchidos.');
  end;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  btnSairPClick(btnSairP);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  DbGrid.DataSource.DataSet.Refresh;
end;

procedure TForm3.txtCelularChange(Sender: TObject);
begin
  if txtCelular.Text = '' then
  begin
    DbGrid.DataSource.Enabled := false;
  end
  else
  begin
    DbGrid.DataSource.Enabled := true;
    Banco.tbSQL.Filtered := False;
    Banco.tbSQL.Filter := 'Celular like' + QuotedStr('%'+txtCelular.Text+'%');
    Banco.tbSQL.Filtered := True;
  end;
end;

procedure TForm3.txtNomeChange(Sender: TObject);
begin
  if txtNome.Text = '' then
  begin
    DbGrid.DataSource.Enabled := false;
  end
  else
  begin
    DbGrid.DataSource.Enabled := true;
    Banco.tbSQL.Filtered := False;
    Banco.tbSQL.Filter := 'Nome like' + QuotedStr('%'+txtNome.Text+'%');
    Banco.tbSQL.Filtered := True;
  end;
 end;
end.

