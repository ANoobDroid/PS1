program Schleifen;
// Schleifen V1
// Autor: Gürkan Aslan, Serkan Arkar

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils, Math;

const
  LOWER_BORDER = 1; // unter- und obergrenze
  UPPER_BORDER = 50;

var
  gerade: Boolean; // Deklarationen
  ungerade: Boolean;
  groesste_ziffer: Word;
  kleinste_ziffer: Word;
  linke_ziffer, rechte_ziffer: byte;
  kleinere, groessere: Word;
  prim: Boolean;
  i, a, b, j, d, e, p: Word;

begin

  for i := LOWER_BORDER to UPPER_BORDER do
  // durchgang von untergrenze bis obergrenze
  begin
    gerade := i mod 2 = 0; // gerade und ungerade zahlen rausfinden
    ungerade := i mod 2 = 1;
    b := i;

    kleinste_ziffer := b mod 10; // kleinste und größte ziffer verankern
    groesste_ziffer := b mod 10;

    repeat
      a := b mod 10;
      b := b div 10; // zahl zerlegen

      kleinste_ziffer := min(kleinste_ziffer, a);
      groesste_ziffer := max(groesste_ziffer, a);
      // kleinste und größte ziffer zuweisen
    until b = 0; // schleife wird bei erfolgreicher zerlegung beendet

    p := 0;
    j := 1;
    d := i;

    repeat
      d := d + 1; // den wert von d (für i) immer um 1 erhöhen...

      while j <= d do
      begin
        if d mod j = 0 then
          p := p + 1;
        j := j + 1;
      end; // wenn restlos teilbar, dann p und j um 1 erhöhen
      prim := p = 2; // wenn der zähler bei 2 ist, ist primzahl = 0
      p := 0;
      j := 1; // p und j wieder auf 0 und 1 setzen

    until (prim); // ...bis eine primzahl gefunden wurde

    groessere := d; // die größere Primzahl wird auf groessere abgelegt

    e := i;

    if i <= 1 then // wenn die zahl 0 oder kleiner ist,
      kleinere := 0 // ist die kleinere Primzahl = 0
    else if i = 2 then // wenn die zahl 2 ist, ist die kleinere Primzahl 1
      kleinere := 1
    else if i = 3 then // -''-   3 ist -''- 2
      kleinere := 2
    else
    begin

      repeat
        e := e - 1; // zieht von (d für i) immer 1 ab...

        while j <= e do
        begin
          if e mod j = 0 then // wenn restlos teilbar, dann p und j um 1 erhöhen
            p := p + 1; // dem zähler für den durchgang einen dazu geben
          j := j + 1; // dem teiler einen dazu geben
        end;
        prim := p = 2;
        // wert der primzahl ist richtig, wenn der druchgangszähler bei 2 ist
        j := 1;
        p := 0;

      until (prim); // ...bis eine primzahl gefunden wurde

      kleinere := e; // die kleinere Primzahl wird auf kleinere abgelegt
    end;

    Writeln(i, ': Zahl ist gerade: ', gerade, ', Zahl ist ungerade: ',
      ungerade);
    Writeln('Größte Ziffer: ', groesste_ziffer, '   Kleinste Ziffer: ',
      kleinste_ziffer); // alle Ausgaben
    if kleinere = 0 then
      Writeln('kleinere Prim: - ', '     größere Prim: ', groessere)
    else
      Writeln('kleinere Prim: ', kleinere, '     größere Prim: ', groessere);
  end; // Wenn die kleinere Primzahl 0 ist, soll "-" ausgegeben werden, ansonsten die normale kleinere Primzahl

  readln;

end.
