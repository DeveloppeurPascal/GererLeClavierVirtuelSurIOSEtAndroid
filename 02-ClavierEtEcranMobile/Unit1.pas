unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts;

type
  TForm1 = class(TForm)
    Conteneur: TVertScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure GestionClavierVirtuel(Sender: TObject; KeyboardVisible: Boolean;
      const Bounds: TRect);
    procedure AfficheComposantSelectionne;
    procedure FormFocusChanged(Sender: TObject);
  private
    { Déclarations privées }
    FKBVisible: Boolean;
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.AfficheComposantSelectionne;
var
  coord: tpointf;
  ctrl: tcontrol;
begin
  if FKBVisible then
    if (Focused is tcontrol) then
    begin
      ctrl := (Focused as tcontrol);
      coord := ctrl.LocalToAbsolute(pointf(0, 0));
      if (coord.y < 0) then
        Conteneur.ViewportPosition := pointf(Conteneur.ViewportPosition.X,
          ctrl.position.y - 10)
      else if (coord.y + ctrl.Height > Conteneur.Height) then
        Conteneur.ViewportPosition := pointf(Conteneur.ViewportPosition.X,
          ctrl.position.y + ctrl.Height + 50 - Conteneur.Height);
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
  edt: tedit;
begin
  for i := 1 to 50 do
  begin
     edt := tedit.Create(self);
     edt.parent := Conteneur;
     edt.align := talignlayout.Top;
     edt.margins := tbounds.Create(rectf(10, 10, 10, 10));
     edt.text := 'champ ' + i.tostring;
     edt.ReturnKeyType := TReturnKeyType.Next;
     edt.KillFocusByReturn := false;
  end;
end;

procedure TForm1.FormFocusChanged(Sender: TObject);
begin
  AfficheComposantSelectionne;
end;

procedure TForm1.GestionClavierVirtuel(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBVisible := KeyboardVisible;
  if FKBVisible then
  begin
    Conteneur.align := talignlayout.None;
    Conteneur.Height := Bounds.Top;
    Conteneur.Padding.Bottom := 100;
    AfficheComposantSelectionne;
  end
  else
  begin
    Conteneur.align := talignlayout.client;
    Conteneur.Padding.Bottom := 20;
  end;
end;

initialization

{$IF Defined(IOS) or Defined(ANDROID)}
//  VKAutoShowMode := TVKAutoShowMode.Always;
{$ENDIF}

end.
