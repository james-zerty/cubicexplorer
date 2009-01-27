unit fCE_QuickViewPanel;

interface

uses
  // CE Units
  fCE_DockableForm, CE_QuickView, CE_GlobalCtrl, dCE_Images, CE_LanguageEngine,
  CE_Settings,
  // VSTools
  MPCommonUtilities,
  // PNG Controls
  PngImageList,
  // JVCL
  JvDockControlForm, JvDockVIDStyle,
  // SpTBX, Tb2k
  TB2Dock, SpTBXItem, 
  // System Units
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShlObj, ImgList, StdCtrls;

type
  TCEQuickViewPanel = class(TCECustomDockableForm)
    PngImageList: TPngImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure GlobalFocusChanged(Sender: TObject; NewPath: WideString); override;
        stdcall;
  public
    Viewer: TCEQuickView;
    procedure DoFormHide; override;
    procedure DoFormShow; override;
  end;

var
  CEQuickViewPanel: TCEQuickViewPanel;

implementation

{$R *.dfm}

{*------------------------------------------------------------------------------
  Get's called when TCEQuickViewPanel is created.
-------------------------------------------------------------------------------}
procedure TCEQuickViewPanel.FormCreate(Sender: TObject);
begin
  inherited;
  TopDock.Name:= 'QuickViewPanel_TopDock';
  BottomDock.Name:= 'QuickViewPanel_BottomDock';
  Caption:= _('Quickview');
  Viewer:= TCEQuickView.Create(self);
  Viewer.Parent:= self;
  Viewer.Align:= alClient;
  Viewer.UseThumbImage:= true;
  GlobalSettings.RegisterHandler(Viewer);
  GlobalPathCtrl.RegisterNotify(self);
  ImageList:= CE_Images.SmallIcons;
  ImageIndex:= 20;
end;

{*------------------------------------------------------------------------------
  Get's called when TCEQuickViewPanel is destroyed.
-------------------------------------------------------------------------------}
procedure TCEQuickViewPanel.FormDestroy(Sender: TObject);
begin
  Viewer.Free;
  inherited;
end;

{*------------------------------------------------------------------------------
  Get's called when Global focus has changed
-------------------------------------------------------------------------------}
procedure TCEQuickViewPanel.GlobalFocusChanged(Sender: TObject; NewPath:
    WideString);
begin
  Viewer.LoadFile(NewPath);
end;

{*------------------------------------------------------------------------------
  Get's called when form gets hidden.
-------------------------------------------------------------------------------}
procedure TCEQuickViewPanel.DoFormHide;
begin
  inherited;
  Viewer.Active:= false;
end;

{*------------------------------------------------------------------------------
  Get's called when form gets shown.
-------------------------------------------------------------------------------}
procedure TCEQuickViewPanel.DoFormShow;
begin
  inherited;
  Viewer.Active:= true;
end;

end.
