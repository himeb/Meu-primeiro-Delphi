unit uRealizaCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uBanco,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.Menus, Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    lblNome: TLabel;
    txtNome: TEdit;
    Button1: TButton;
    lblIdade: TLabel;
    txtIdade: TEdit;
    Panel1: TPanel;
    txtEndereco: TEdit;
    lblEndereco: TLabel;
    lblTelefone: TLabel;
    lblNumero: TLabel;
    txtNumero: TEdit;
    lblCelular: TLabel;
    txtCelular: TEdit;
    cbNotificacao: TCheckBox;
    txtTelefone: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    cbSexo: TComboBox;
    Image1: TImage;
    lblSexo: TLabel;
    procedure txtNomeExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
    procedure cadastro;
    procedure verificaUsuario;
    procedure verificaCampo;
  end;

var
  Form1: TForm1;
implementation
   {$R *.dfm}

procedure TForm1.txtNomeExit(Sender: TObject);
begin
  verificaUsuario;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  verificaCampo;
end;

procedure TForm1.verificaCampo;
begin
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
            if ((TEdit(Self.Components[i])).Text = ('')) or
            ((TMaskEdit(Self.Components[i])).Text = ('')) then
            begin
              TLabel(Form1.FindComponent('lbl'+vNome)).Caption := (vNome+'*');
              TLabel(Form1.FindComponent('lbl'+vNome)).Font.Color := clred;
              lblEndereco.Caption := 'Endereço*';
            end
            else
            begin
              TLabel(Form1.FindComponent('lbl'+vNome)).Caption := vNome;
              TLabel(Form1.FindComponent('lbl'+vNome)).Font.Color := clblack;
            end;
          end;
        end;

      end;
      if (lblNome.Font.Color = clred) or (lblIdade.Font.Color = clred) or
      (lblEndereco.Font.Color = clred) or (lblNumero.Font.Color = clred) or
      (lblCelular.Font.Color = clred) then
      begin
        Application.MessageBox('Favor preencher os campos obrigatórios','Atenção',MB_ICONEXCLAMATION+MB_OK);
      end
      else
      begin
        cadastro;
      end;
    end;
  end;
end;

procedure TForm1.cadastro;
begin
  Banco.Conexao.StartTransaction;
  try
    Banco.qryInsert.Close;
    Banco.qryInsert.ParamByName('nome').AsString := txtNome.Text;
    Banco.qryInsert.ParamByName('idade').AsInteger := strtoint(txtIdade.Text);
    Banco.qryInsert.ParamByName('endereco').AsString := txtEndereco.Text;
    Banco.qryInsert.ParamByName('numero').AsInteger := strtoint(txtNumero.Text);
    Banco.qryInsert.ParamByName('telefone').AsString := (txtTelefone.Text);
    Banco.qryInsert.ParamByName('celular').AsString := (txtCelular.Text);
    if cbSexo.ItemIndex = 0 then
    begin
      Banco.qryInsert.ParamByName('sexo').AsString:='F';
    end
    else if cbSexo.ItemIndex = 1 then
    begin
      Banco.qryInsert.ParamByName('sexo').AsString:='M';
    end
    else
    begin
      Banco.qryInsert.ParamByName('sexo').AsString:='';
    end;
    if cbNotificacao.Checked = true then
    begin
      Banco.qryInsert.ParamByName('notificacao').AsBoolean:= true ;
    end
    else
    begin
      Banco.qryInsert.ParamByName('notificacao').AsBoolean:= false ;
    end;
    Banco.qryInsert.Execute;
    Banco.Conexao.Commit;
    Application.MessageBox('Cadastro realizado com sucesso','Confirmação',MB_ICONINFORMATION+MB_OK);
      var
      C : Integer;
      begin
        for C := 0 to Self.ComponentCount - 1 do
        if (Self.Components[C] is TEdit) then
        (Self.Components[C] as TEdit).Clear;
      end;
    cbSexo.ItemIndex := -1;
    cbNotificacao.Checked := false;
    Form1.Close;
  except
    on e:exception do
    begin
      Banco.Conexao.Rollback;
      ShowMessage('ERRO '+ e.Message);
    end;
  end;
end;

  procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  txtNome.Text :='';
  txtIdade.Text :='';
  txtEndereco.Text :='';
  txtNumero.Text :='';
  txtTelefone.Text :='';
  txtCelular.Text :='';
  cbNotificacao.Checked := false;
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
            vNome := Copy((Self.Components[i]).Name,4,20);
            begin
              TLabel(Form1.FindComponent('lbl'+vNome)).Caption := vNome;
              TLabel(Form1.FindComponent('lbl'+vNome)).Font.Color := clblack;
            end;
          end;
      end;
    end;
  end;
  cbSexo.ItemIndex := -1;
end;

procedure TForm1.verificaUsuario;
begin
  Banco.Conexao.StartTransaction;
  Banco.qrySelect.close;
  Banco.qrySelect.ParamByName('Nome').AsString := txtNome.Text;
  Banco.qrySelect.Open;

  if not Banco.qrySelect.IsEmpty then
  begin
  ShowMessage('A pessoa Informada já está cadastrada!');
  txtNome.SetFocus;
  end;
end;
end.



