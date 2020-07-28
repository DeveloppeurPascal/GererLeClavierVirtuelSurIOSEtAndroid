unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.Controls.Presentation,
  FMX.ComboEdit, FMX.DateTimeCtrls, FMX.Layouts, FMX.ListBox, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    DateEdit1: TDateEdit;
    TimeEdit1: TTimeEdit;
    ComboEdit1: TComboEdit;
    Edit1: TEdit;
    TabItem4: TTabItem;
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    lbKeyboardTypeEdit: TListBox;
    lbKillFocusByReturnEdit: TListBox;
    lbReturnKeyTypeEdit: TListBox;
    GroupBox4: TGroupBox;
    lbKeyboardTypeMemo: TListBox;
    Button1: TButton;
    Button2: TButton;
    VertScrollBox1: TVertScrollBox;
    GroupBox5: TGroupBox;
    lbKeyboardTypeCombo: TListBox;
    GroupBox6: TGroupBox;
    lbKillFocusByReturnCombo: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure lbKillFocusByReturnEditItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure lbKeyboardTypeEditItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure lbReturnKeyTypeEditItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure lbKeyboardTypeMemoItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure lbKeyboardTypeComboItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure lbKillFocusByReturnComboItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private
    { Déclarations privées }
    /// <summary>
    /// initialise la propriété Text du composant TEdit1
    /// </summary>
    procedure CalculeTexteEdit;
    /// <summary>
    /// insère une ligne en haut du composant TMemo1
    /// </summary>
    procedure CalculeTexteMemo;
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.TypInfo;

procedure TForm1.CalculeTexteEdit;
begin
  Edit1.Text := GetEnumName(typeinfo(TVirtualKeyboardType),
    ord(Edit1.KeyboardType)) + ' / ' + Edit1.KillFocusByReturn.ToString + ' / '
    + GetEnumName(typeinfo(TReturnKeyType), ord(Edit1.ReturnKeyType));
end;

procedure TForm1.CalculeTexteMemo;
begin
  Memo1.lines.insert(0, GetEnumName(typeinfo(TVirtualKeyboardType),
    ord(Memo1.KeyboardType)));
  Memo1.GoToTextBegin;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Item: TListBoxItem;
  kt: TVirtualKeyboardType;
  rkt: TReturnKeyType;
begin
  // Activation du premier onglet lors de l'ouverture du programme
  TabControl1.ActiveTab := TabItem1;
  // Remplissage de la liste des types de clavier pour l'onglet du TComboBox1
  lbKeyboardTypeCombo.Clear;
  for kt := low(TVirtualKeyboardType) to high(TVirtualKeyboardType) do
  begin
    Item := TListBoxItem.Create(lbKeyboardTypeCombo);
    Item.Text := GetEnumName(typeinfo(TVirtualKeyboardType), ord(kt));
    Item.Tag := ord(kt);
    lbKeyboardTypeCombo.AddObject(Item);
  end;
  // Remplissage de la liste des types de clavier pour l'onglet du TEdit
  lbKeyboardTypeEdit.Clear;
  for kt := low(TVirtualKeyboardType) to high(TVirtualKeyboardType) do
  begin
    Item := TListBoxItem.Create(lbKeyboardTypeEdit);
    Item.Text := GetEnumName(typeinfo(TVirtualKeyboardType), ord(kt));
    Item.Tag := ord(kt);
    lbKeyboardTypeEdit.AddObject(Item);
  end;
  // Remplissage de la liste des types de touche ENTREE pour l'onglet du TEdit
  lbReturnKeyTypeEdit.Clear;
  for rkt := low(TReturnKeyType) to high(TReturnKeyType) do
  begin
    Item := TListBoxItem.Create(lbReturnKeyTypeEdit);
    Item.Text := GetEnumName(typeinfo(TReturnKeyType), ord(rkt));
    Item.Tag := ord(rkt);
    lbReturnKeyTypeEdit.AddObject(Item);
  end;
  // Remplissage du TEdit
  CalculeTexteEdit;
  // Remplissage de la liste des types de clavier pour l'onglet du TMemo
  lbKeyboardTypeMemo.Clear;
  for kt := low(TVirtualKeyboardType) to high(TVirtualKeyboardType) do
  begin
    Item := TListBoxItem.Create(lbKeyboardTypeMemo);
    Item.Text := GetEnumName(typeinfo(TVirtualKeyboardType), ord(kt));
    Item.Tag := ord(kt);
    lbKeyboardTypeMemo.AddObject(Item);
  end;
  // Remplissage du TMemo
  CalculeTexteMemo;
end;

procedure TForm1.lbKeyboardTypeComboItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  ComboEdit1.KeyboardType := TVirtualKeyboardType(Item.Tag);
end;

procedure TForm1.lbKeyboardTypeEditItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Edit1.KeyboardType := TVirtualKeyboardType(Item.Tag);
  CalculeTexteEdit;
end;

procedure TForm1.lbKeyboardTypeMemoItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Memo1.KeyboardType := TVirtualKeyboardType(Item.Tag);
  CalculeTexteMemo;
end;

procedure TForm1.lbKillFocusByReturnComboItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  ComboEdit1.KillFocusByReturn := (Item.Index = 1); // 0=>False, 1=>True
end;

procedure TForm1.lbKillFocusByReturnEditItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Edit1.KillFocusByReturn := (Item.Index = 1); // 0=>False, 1=>True
  CalculeTexteEdit;
end;

procedure TForm1.lbReturnKeyTypeEditItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Edit1.ReturnKeyType := TReturnKeyType(Item.Tag);
  CalculeTexteEdit;
end;

end.
