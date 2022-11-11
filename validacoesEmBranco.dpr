program validacoesEmBranco;

uses
  Vcl.Forms,
  uRealizaCadastro in 'uRealizaCadastro.pas' {Form1},
  uBanco in 'uBanco.pas' {Banco: TDataModule},
  uMenu in 'uMenu.pas' {Form2},
  uPesquisaCadastro in 'uPesquisaCadastro.pas' {Form3},
  uEditaCadastro in 'uEditaCadastro.pas' {Form4},
  uExcluiCadastro in 'uExcluiCadastro.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TBanco, Banco);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
