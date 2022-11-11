unit uEditaCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uBanco, Vcl.Imaging.pngimage;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    lblTitulo: TLabel;
    txtId: TEdit;
    lblId: TLabel;
    txtNome: TEdit;
    lblNome: TLabel;
    txtEndereco: TEdit;
    lblEndereco: TLabel;
    lblTelefone: TLabel;
    txtTelefone: TEdit;
    lblCelular: TLabel;
    txtCelular: TEdit;
    cbNotificacao: TCheckBox;
    txtNumero: TEdit;
    lblSexo: TLabel;
    lblIdade: TLabel;
    txtIdade: TEdit;
    lblNumero: TLabel;
    btnSair: TButton;
    btnSalva: TButton;
    dbGrid: TDBGrid;
    Image1: TImage;
    btnCancela: TButton;
    cbSexo: TComboBox;
    procedure dbGridCellClick(Column: TColumn);
    procedure txtNomeChange(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    procedure verificaUsuario;
    procedure atualizaCadastro;
  public
    vgEDT : boolean;
  end;

var
  Form4: TForm4;


implementation

{$R *.dfm}

procedure TForm4.btnCancelaClick(Sender: TObject);
begin
  vgEDT := true;
   var
  C : Integer;
  begin
    for C := 0 to Self.ComponentCount - 1 do
    if (Self.Components[C] is TEdit) then
    (Self.Components[C] as TEdit).Clear;
  end;
  cbSexo.itemIndex := -1;
  cbNotificacao.Checked := false;
  txtNome.SetFocus;
end;

procedure TForm4.btnSairClick(Sender: TObject);
begin
  btnCancelaClick(btnCancela);
  close;
end;

procedure TForm4.btnSalvaClick(Sender: TObject);
  var
  vNome : string;
  begin
    var
    I : Integer;
    begin
      for I := 0 to Self.ComponentCount - 1 do
      begin
        if (Self.Components[i]).tag = 1 then
        begin
          if (Self.Components[i]).Tag <> 999 then
          begin
            vNome := Copy((Self.Components[i]).Name,4,20);
            if ((TEdit(Self.Components[i])).Text = ('')) then
            begin
              TLabel(Form4.FindComponent('lbl'+vNome)).Caption := (vNome+'*');
              TLabel(Form4.FindComponent('lbl'+vNome)).Font.Color := clred;
              lblEndereco.Caption := 'Endereço*';
            end
            else
            begin
              TLabel(Form4.FindComponent('lbl'+vNome)).Caption := vNome;
              TLabel(Form4.FindComponent('lbl'+vNome)).Font.Color := clblack;
            end;
          end;
        end;

      end;
      if (lblNome.Font.Color = clred) or (lblIdade.Font.Color = clred) or
      (lblEndereco.Font.Color = clred) or (lblNumero.Font.Color = clred) or
      (lblCelular.Font.Color = clred) then
      begin
        Application.MessageBox('Favor preencher os campos obrigatórios','Atenção',MB_ICONEXCLAMATION+MB_OK);
        dbGrid.DataSource.DataSet.Refresh;
      end
      else
      begin
        verificaUsuario;
        dbGrid.DataSource.DataSet.Refresh;
      end;
    end;
  end;

procedure TForm4.atualizaCadastro;
begin
  try
    Banco.qryUpdate.Close;
    Banco.qryUpdate.ParamByName('ID').AsInteger := Banco.tbSQLId.AsInteger;
    Banco.qryUpdate.ParamByName('NOME').AsString := txtnome.Text;
    Banco.qryUpdate.ParamByName('IDADE').AsString := txtIdade.Text;
    Banco.qryUpdate.ParamByName('SEXO').AsString := cbSexo.Text;
    Banco.qryUpdate.ParamByName('ENDERECO').AsString := txtEndereco.Text;
    Banco.qryUpdate.ParamByName('NUMERO').AsInteger := strToInt(txtNumero.Text);
    Banco.qryUpdate.ParamByName('TELEFONE').AsString := txtTelefone.Text;
    Banco.qryUpdate.ParamByName('CELULAR').AsString := txtCelular.Text;
    Banco.qryUpdate.ParamByName('NOTIFICACAO').AsBoolean := cbNotificacao.Checked;
    Banco.qryUpdate.Execute;
    //Banco.Conexao.Commit;
    dbGrid.DataSource.DataSet.Refresh;
    Application.MessageBox('Alteração realizada com sucesso','Confirmação',MB_ICONINFORMATION+MB_OK);
    var
    C : Integer;
    begin
      for C := 0 to Self.ComponentCount - 1 do
      if (Self.Components[C] is TEdit) then
      (Self.Components[C] as TEdit).Clear;
    end;
    cbSexo.itemindex := -1;
    cbNotificacao.Checked := false;
    vgEDT := true;
  except
    on e:exception do
    begin
      //Banco.Conexao.Rollback;
      ShowMessage('ERRO '+ e.Message);
    end;
  end;
end;

procedure TForm4.dbGridCellClick(Column: TColumn);
begin
  vgEDT := false;
  txtId.Text := dbGrid.SelectedField.DataSet.FieldByName('id').AsString;
  txtNome.Text := dbGrid.SelectedField.DataSet.FieldByName('nome').AsString;
  txtIdade.Text := dbGrid.SelectedField.DataSet.FieldByName('idade').AsString;
  cbSexo.Text := dbGrid.SelectedField.DataSet.FieldByName('sexo').AsString;
  txtEndereco.Text := dbGrid.SelectedField.DataSet.FieldByName('endereco').AsString;
  txtNumero.Text := dbGrid.SelectedField.DataSet.FieldByName('numero').AsString;
  txtTelefone.Text := dbGrid.SelectedField.DataSet.FieldByName('telefone').AsString;
  txtCelular.Text := dbGrid.SelectedField.DataSet.FieldByName('celular').AsString;
  cbNotificacao.Checked := dbGrid.SelectedField.DataSet.FieldByName('Notificacao').AsBoolean;
  end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  dbGrid.DataSource.DataSet.Refresh;
end;

procedure TForm4.txtNomeChange(Sender: TObject);
begin
  if vgEDT = true then
  begin
    Banco.tbSQL.Filtered := False;
    Banco.tbSQL.Filter := 'Nome like' + QuotedStr('%'+txtNome.Text+'%');
    Banco.tbSQL.Filtered := True;
  end;
end;

procedure TForm4.verificaUsuario;
begin
  Banco.Conexao.StartTransaction;
  Banco.qrySelect.close;
  Banco.qrySelect.ParamByName('Nome').AsString := txtNome.Text;
  Banco.qrySelect.Open;

  if not Banco.qrySelect.IsEmpty then
  begin
    ShowMessage('A pessoa Informada já está cadastrada!');
    txtNome.SetFocus;
  end
  else
  begin
   atualizaCadastro;
  end;
end;
end.
