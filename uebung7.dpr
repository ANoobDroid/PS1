program uebung7;

{$APPTYPE CONSOLE}
{$R+Q+X-}

uses
  System.SysUtils,
  Math;

type
  TAttraction = (Bratapfel, Bratwurst, Glühwein, Räuchermännchen,
    Weihnachtsmann);
  TAttractionSet = set of TAttraction;

  TMarkt = record
    Stadt: string;
    Buden: Integer;
    Baum: Boolean;
    AMenge: TAttractionSet;
  end;

  TMärkte = array [1 .. 5] of TMarkt;

const
  ATTRACTION_NAMES: array [TAttraction] of string = ('Bratapfel', 'Bratwurst',
    'Glühwein', 'Räuchermännchen', 'Weihnachtsmann');
  maxima = 5;

var
  Markt: TMärkte;
  beliebt, c: TAttraction;
  alles: TAttractionSet;
  EingabeStadt, EingabeBaum, EingabeAMenge: string;
  EingabeBuden: string[200];
  z, j, i, code, Budenint: Integer;
  boolbaum: Boolean;
  unbeliebt: TAttractionSet;
  MehrfacheAttraktionen: TAttractionSet;

begin
  z := 0;
  repeat

    inc(z); // Zähler für die Anzahl der beschreibenden Stadt
    repeat
      write('Stadt eingeben (min. 4 Zeichen): ');
      readln(EingabeStadt);
    until (length(EingabeStadt) >= 4) or (EingabeStadt = 'x');
    // Eingelesene Eingabe wird nur akzeptiert, wenn sie größer/gleich 3 ist
    // oder mit 'x' die Eingabe beendet wird

    if EingabeStadt <> 'x' then // Folgende Scleife wird ausgeführt,
      repeat // wenn Programm nicht mit 'x' beendet wurde
        write('Buden eingeben: ');
        readln(EingabeBuden);
        val(EingabeBuden, Budenint, code);
        // Eingelesenen Zahl als String in einen Integer umwandeln
      until (code = 0) or (EingabeBuden = 'x');
    // Eingabe wird nur akzeptiert, wenn es eine Normale Zahl ist oder
    // mi 'x' die Eingabe beendet wird

    if (EingabeBuden <> 'x') and (EingabeStadt <> 'x') then
      repeat // Schleife wird ausgeführt wenn Programm nicht mit 'x'beendet wurde
        write('Großer Baum Vorhanden? (ja/nein): ');
        readln(EingabeBaum);
      until (EingabeBaum = 'ja') or (EingabeBaum = 'nein') or
        (EingabeBaum = 'x'); // Eingabe wird nur bei já, nein oder x beendet
    if EingabeBaum = 'ja' then
      boolbaum := True // Bei 'ja' wird die Hilfsvariable TRUE
    else if EingabeBaum = 'nein' then
      boolbaum := False; // Bei 'nein' FALSE

    if (EingabeBaum <> 'x') and (EingabeBuden <> 'x') and (EingabeStadt <> 'x')
    then // Schleife wird ausgeführt wenn Programm nicht mit 'x' beendet wurde
      repeat
        write('Was hat der Weihnachtsmarkt? ');
        readln(EingabeAMenge); // Eingabe der Attraktionen in Eingabevariable
        for c := low(TAttraction) to high(TAttraction) do
          // Durchlaufen der Attraktionen
          if copy(EingabeAMenge, 2, length(EingabeAMenge) - 1)
            = ATTRACTION_NAMES[c] then
            // Wenn die Attraktion richtig eingegeben wurde, dann wird sie
            if EingabeAMenge[1] = '+' then
              Markt[z].AMenge := Markt[z].AMenge + [c]
              // Bei einem '+' in die Menge der Attraktionen direkt in den Record hinzugefügt
            else if EingabeAMenge[1] = '-' then
              Markt[z].AMenge := Markt[z].AMenge - [c]
              // Bei einem '-' aus der Menge der Attratkionen aus dem Record entfernt
                until (EingabeAMenge = 'x');
        // Eingabe der Attraktionen wird erst mit 'x' beendet

        // Schleife wird ausgeführt wenn Programm nicht mit 'x' beendet wurde
        if (EingabeStadt <> 'x') and (EingabeBuden <> 'x') and
          (EingabeBaum <> 'x') then
        begin // Belegen des Records mit den in die Hilfsvariablen abgelegten Eingaben
          Markt[z].Stadt := EingabeStadt;
          Markt[z].Buden := Budenint;
          Markt[z].Baum := boolbaum;
        end;
      until (z = maxima) or (EingabeStadt = 'x') or (EingabeBuden = 'x') or
        (EingabeBaum = 'x');
    // Programm wird beendet, wenn maximale Größe des Records erreicht oder
    // das Programm mit 'x' abgebrochen wurde

    alles := [Bratapfel, Bratwurst, Glühwein, Räuchermännchen, Weihnachtsmann];

    for i := 1 to z do
    begin // Ausgabe aller eingetragenen Weihnachtsmärkte
      writeln(i, '. EINGEGEBENER WEIHNACHTSMARKT:');
      writeln('Stadt: ', Markt[i].Stadt);
      writeln('Anzahl Buden: ', Markt[i].Buden);
      writeln('Hat Weihnachtsbaum: ', Markt[i].Baum);
      write('Attraktionen: ');
      for c in Markt[i].AMenge do // Ausgabe aller Attraktionen aus dem Record
        write(' ', ATTRACTION_NAMES[c]);
      writeln('');

    end;

    for i := 1 to z do // Durchlaufen aller Märkte
      for j := i + 1 to z do
        alles := alles - Markt[i].AMenge;
    // Entfernen aller Auftretenden Märkte aus der Liste, sodass
    // nicht auftretende Märkte übrig bleiben

    MehrfacheAttraktionen := []; // Leere Menge

    for i := 1 to z do // Durchlaufen aller Märkte
      for j := i + 1 to z do
        MehrfacheAttraktionen := MehrfacheAttraktionen +
          (Markt[i].AMenge * Markt[j].AMenge);
    // Einfügen aller Attratkionen, die mindestens 2 mal auftauchen

    writeln('mehrfach vorkommende Attraktionen: ');
    for beliebt in MehrfacheAttraktionen do
      write(' ', ATTRACTION_NAMES[beliebt]);
    // Ausgabe aller "beliebten" Attraktionen
    writeln(' ');

    writeln('Nie vorkommende Attraktionen: ');
    for beliebt in alles do
      write(' ', ATTRACTION_NAMES[beliebt]);
    // Ausgabe aller "unbeliebten" Attraktionen
    writeln(' ');

    write('Programm beendet.');
    readln;

end.
