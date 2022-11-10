unit UniDSAColor;

interface

uses
  System.Classes, System.UITypes, Vcl.Graphics;

type
  TUniDSAColor = class(TPersistent)
  private
    FEnabled: Boolean;
    FColor: TColor;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
    property Color: TColor read FColor write FColor;
  end;

implementation

{ TUniDSAColor }

constructor TUniDSAColor.Create;
begin
  Enabled := False;
  FColor := clAqua;
end;

destructor TUniDSAColor.Destroy;
begin
  inherited;
end;

end.
