program Ueb03;
{Das Programm prüft das eingegebene Datum auf seine Richtigkeit.

Autor: Gürkan Aslan und Serkan Arkar}

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils,
  Math;

var
  isValidIf: Boolean;
  isValidCase: Boolean;
  isValidAlloc: Boolean;
  tag: Integer;
  monat: Integer;
  jahr: Integer;
  stunde: Integer;
  minute: Integer;

begin
  write('Bitte Datum (in Zahlen) und Uhrzeit eingeben(Tag/Monat/Jahr/Stunde/Minute): ');
  readln(tag, monat, jahr, stunde, minute);
  writeln('Datum: ', tag, '.', monat, '.', jahr, ' und Uhrzeit: ', stunde,
    ':', minute);

  if (stunde < 24) and (stunde >= 0) then
    if (minute < 60) and (minute >= 0) then
      if (jahr < 2100) and (jahr > 1999) then
        if ((monat = 1) or (monat = 3) or (monat = 5) or (monat = 7) or
          (monat = 8) or (monat = 10) or (monat = 12)) then
          if (tag < 32) and (tag > 0) then
            isValidIf := True
          else
            isValidIf := False
        else if monat = 2 then
          if (tag < 30) and (tag > 0) then
            isValidIf := True
          else
            isValidIf := False
        else if ((monat = 4) or (monat = 6) or (monat = 9) or (monat = 11)) then
          if (tag < 31) and (tag > 0) then
            isValidIf := True
          else
            isValidIf := False
        else
          isValidIf := False
      else
        isValidIf := False
    else
      isValidIf := False;

  writeln('If: ', isValidIf);

  case jahr of
    2000 .. 2099:
      case monat of
        1, 3, 5, 7, 8, 10, 12:
          case tag of
            1 .. 31:
              case stunde of
                0 .. 23:
                  case minute of
                    0 .. 59:
                      isValidCase := True
                  else
                    isValidCase := False
                  end;
              else
                isValidCase := False
              end;
          else
            isValidCase := False
          end;

        4, 6, 9, 11:
          case tag of
            0 .. 30:
              case stunde of
                0 .. 23:
                  case minute of
                    0 .. 59:
                      isValidCase := True
                  else
                    isValidCase := False
                  end;
              else
                isValidCase := False
              end;
          else
            isValidCase := False
          end;

        2:
          case tag of
            0 .. 29:
              case stunde of
                0 .. 23:
                  case minute of
                    0 .. 59:
                      isValidCase := True
                  else
                    isValidCase := False
                  end;
              else
                isValidCase := False
              end;
          else
            isValidCase := False
          end;
      end;
  end;

  writeln('Case: ', isValidCase);

  isValidAlloc := ((monat = 1) or (monat = 3) or (monat = 5) or (monat = 7) or
    (monat = 8) or (monat = 10) or (monat = 12)) and (tag < 32) and (tag > 0)
    and (jahr > 1999) and (jahr < 2100) and (stunde < 24) and (stunde >= 0) and
    (minute >= 0) and (minute < 60)

    or (monat = 4) or (monat = 6) or (monat = 9) or (monat = 11) and (tag < 31)
    and (tag > 0) and (jahr > 1999) and (jahr < 2100) and (stunde < 24) and
    (stunde >= 0) and (minute >= 0) and (minute < 60)

    or (monat = 2) and (tag < 30) and (tag >= 0) and (jahr > 1999) and
    (jahr < 2100) and (stunde < 24) and (stunde >= 0) and (minute >= 0) and
    (minute < 60);

  writeln('Alloc', isValidAlloc);

  readln;

end.
