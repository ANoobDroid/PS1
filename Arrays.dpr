{
  Autor: Gürkan Aslan, Serkan Arkar
  Generieren einer Landschaft
}
program Arrays;

{$APPTYPE CONSOLE}
{$R+Q+X-}

uses
  System.SysUtils,
  Math,
  Windows;

// Setzt die Textfarbe der Konsole auf den übergebenen Wert.
// 0 = schwarz, 1 = dunkelblau, 2 = dunkelgrün, 3 = türkis, 4 = rot, 5 = lila,
// 6 = gelbbraun, 7 = hellgrau, 8 = dunkelgrau, 9 = blau, 10 = hellgrün,
// 11 = hellblau, 12 = hellrot, 13 = magenta, 14 = gelb, 15 = weiß
procedure setzeTextFarbe(color: word);
begin
  if SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color) then;
end;

// Setzt die Ausgabeposition der Konsole auf die angegebene Koordinate.
// 0/0 ist oben links.
procedure konsolePositionieren(x, y: byte);
var
  koord: _COORD;
begin
  koord.x := x;
  koord.y := y;
  if SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), koord) then;
end;

const
  FBREITE = 20;
  FHOEHE = 20;

type
  TBreite = 1 .. FBREITE;
  THoehe = 1 .. FHOEHE;
  farben = (Rot, Hellrot, Gelb, Hellgrün, Grün, Blau, Hellblau, Magenta);
  arr2D = array [TBreite, THoehe] of farben;
  arr1D = array [farben] of word;

  // 2 = grün, 4 = rot, 9 = blau, 10 = hellgrün,
  // 11 = hellblau, 12 = hellrot, 13 = magenta, 14 = gelb
var
  spielfeld: arr2D;
  kopie: arr2D;
  farbe: arr1D;
  color: farben;
  h, b, h2, b2: integer;
  x: string;
  teiler, summe, produkt: integer;
  gleich: Boolean;

begin
  repeat

    randomize;

    for color := Rot to Magenta do
      farbe[color] := 0;

    for h := low(TBreite) to High(TBreite) do
      for b := Low(THoehe) to High(THoehe) do
      begin
        spielfeld[b, h] := farben(random(8));
      end;

    konsolePositionieren(0, 0);
    for h := low(TBreite) to High(TBreite) do
    begin
      for b := Low(THoehe) to High(THoehe) do
      begin
        case spielfeld[b, h] of
          Rot: // Farben durch Farbwerte ersetzen...
            setzeTextFarbe(4);
          Hellrot:
            setzeTextFarbe(12);
          Gelb:
            setzeTextFarbe(14);
          Hellgrün:
            setzeTextFarbe(10);
          Grün:
            setzeTextFarbe(2);
          Blau:
            setzeTextFarbe(9);
          Hellblau:
            setzeTextFarbe(11);
          Magenta:
            setzeTextFarbe(13);

        end;
        write('█'); // ...und mit dem Kasten ausgeben
      end;
      writeln; // Zeilenumbruch, wenn eine Zeile beendet wurde
    end;

    for h := low(TBreite) to High(TBreite) do
      for b := Low(THoehe) to High(THoehe) do
      begin
        inc(farbe[spielfeld[b, h]]);
      end;

    konsolePositionieren(0, b);
    write('                                                     ');
    konsolePositionieren(0, b);
    setzeTextFarbe(4); // Zähler für farben ausgeben
    write(farbe[Rot], ' ');
    setzeTextFarbe(12);
    write(farbe[Hellrot], ' ');
    setzeTextFarbe(14);
    write(farbe[Gelb], ' ');
    setzeTextFarbe(10);
    write(farbe[Hellgrün], ' ');
    setzeTextFarbe(2);
    write(farbe[Grün], ' ');
    setzeTextFarbe(9);
    write(farbe[Blau], ' ');
    setzeTextFarbe(11);
    write(farbe[Hellblau], ' ');
    setzeTextFarbe(13);
    write(farbe[Magenta], ' ');

    repeat
      readln(x);
      if x = '' then // Ausführen des Programms bei leerem String
      begin

        for color := Rot to Magenta do
          farbe[color] := 0;

        konsolePositionieren(0, 0);
        for h := low(TBreite) to High(TBreite) do
        begin
          for b := Low(THoehe) to High(THoehe) do
          begin
            teiler := 0;
            summe := 0;
            produkt := 0;
            for h2 := h - 1 to h + 1 do
              // Von der Zeile darüber bis zur Zeile darunter
              for b2 := b - 1 to b + 1 do
              // Von der Zelle links daneben bis zur Zelle rechts daneben
              begin
                if (h2 and b2 > 0) and (h2 <= FHOEHE) and (b2 <= FBREITE) then
                begin // Bedingung: Zelle muss im Array sein
                  inc(teiler);
                  summe := summe + ord(spielfeld[b2, h2]);
                  // Erhöhen des Teilers für jedes vorhandene Feld (wichtig für die Ränder)
                end;

              end;
            produkt := round(summe / teiler);
            spielfeld[b, h] := farben(produkt);
          end;
        end;

        for h := 1 to High(TBreite) do
        begin
          for b := low(THoehe) to High(THoehe) do
          begin
            case spielfeld[b, h] of
              Rot: // Setzung der neuen Farben
                setzeTextFarbe(4);
              Hellrot:
                setzeTextFarbe(12);
              Gelb:
                setzeTextFarbe(14);
              Hellgrün:
                setzeTextFarbe(10);
              Grün:
                setzeTextFarbe(2);
              Blau:
                setzeTextFarbe(9);
              Hellblau:
                setzeTextFarbe(11);
              Magenta:
                setzeTextFarbe(13);

            end;
            write('█');
          end;
          // Ausgabe der neuen landschaft
          writeln;
        end;

        for h := low(TBreite) to High(TBreite) do
          for b := Low(THoehe) to High(THoehe) do
          begin
            inc(farbe[spielfeld[b, h]]);
          end;

        konsolePositionieren(0, b);
        write('                                                     ');
        konsolePositionieren(0, b);
        setzeTextFarbe(4); // Zähler für farben ausgeben
        write(farbe[Rot], ' ');
        setzeTextFarbe(12);
        write(farbe[Hellrot], ' ');
        setzeTextFarbe(14);
        write(farbe[Gelb], ' ');
        setzeTextFarbe(10);
        write(farbe[Hellgrün], ' ');
        setzeTextFarbe(2);
        write(farbe[Grün], ' ');
        setzeTextFarbe(9);
        write(farbe[Blau], ' ');
        setzeTextFarbe(11);
        write(farbe[Hellblau], ' ');
        setzeTextFarbe(13);
        write(farbe[Magenta], ' ');
      end;

      gleich := True;
      for h := low(TBreite) to High(TBreite) do
        for b := Low(THoehe) to High(THoehe) do
          if spielfeld[b, h] <> kopie[b, h] then
            gleich := False; // bei Ungleichheit weiter transformieren lassen
      // Vergleich der aktuellen Landschaften und der Landschaft aus der Kopie

      for h := low(TBreite) to High(TBreite) do
        for b := Low(THoehe) to High(THoehe) do
          kopie[b, h] := spielfeld[b, h];
      // Ablegen der gesamten aktuellen Landschaft in eine Vergleichskopie

    until (x <> '') or (gleich);
    // Veränderungen laufen weiter, bis etwas in den String engegeben wurde oder
    // es keine Veränderungen in der Landschaft gab

    setzeTextFarbe(15);

  until (x <> '');
  // Programm wird beendet, wenn kein leerer String mehr vorhanden ist

  write('Programm wurde beendet. Bitte ENTER drücken');
  readln;

end.
