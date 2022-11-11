unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, uBanco, uRealizaCadastro, uPesquisaCadastro,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls, uEditaCadastro, uExcluiCadastro;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    NovoCadastro1: TMenuItem;
    NovoCadastro2: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    AlterarCadastro1: TMenuItem;
    procedure NovoCadastro1Click(Sender: TObject);
    procedure NovoCadastro2Click(Sender: TObject);
    procedure AlterarCadastro1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.AlterarCadastro1Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm2.N2Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TForm2.NovoCadastro1Click(Sender: TObject);
begin
  Form1.Show;
end;

procedure TForm2.NovoCadastro2Click(Sender: TObject);
begin
  Form3.show;
end;
end.
