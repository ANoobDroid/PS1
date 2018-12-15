program Strings;

{$APPTYPE CONSOLE}
{$R+Q+X-}

uses
  System.SysUtils, Math;

var
  auswahl: char; // Deklaration
  eingabe, kopie, k: string;
  i, n, j: integer;
  temp: char;
  zahl_vokal, zahl_konso: integer;

begin

  repeat
    k := ''; // Initialisierung
    writeln('Bitte ausw�hlen: '); // immer wieder vorkommendes Men�
    writeln('A: Satzeingabe');
    writeln('B: Anzahl Vokale und Konsonanten bestimmen');
    writeln('C: Ziffern durch W�rter ersetzen');
    writeln('D: Satz wortweise sortieren');
    writeln('X: Ende');
    readln(auswahl); // Auswahl des Men�punkts, ploppt immer wieder auf
    case auswahl of
      'a', 'A': // wenn a im Men� ausgew�hlt wird
        begin
          write('Satz eingeben: ');
          readln(eingabe); // Satz Eingabe
        end;
      'b', 'B':
        begin
          zahl_vokal := 0; // Initialisierung um Hinweise zu mindern :)
          zahl_konso := 0;
          for i := 1 to length(eingabe) do
          begin
            case eingabe[i] of
              'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U':
                begin
                  inc(zahl_vokal);
                  // wenn ein Vokal in der Eingabe auftaucht: Vokal-Z�hler um 1 erh�hen
                end;
            end;

            case eingabe[i] of
              'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q',
                'r', 's', 't', 'v', 'w', 'x', 'y', 'z', 'B', 'C', 'D', 'F', 'G',
                'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'V', 'W',
                'X', 'Y', 'Z':
                begin
                  inc(zahl_konso);
                  // wenn ein Konsonant in der Eingabe auftaucht: Konsonanten-Z�hler um 1 erh�hen
                end;
            end;

          end;
          writeln('Anzahl Vokale: ', zahl_vokal); // Ausgabe
          writeln('Anzahl Konsonanten: ', zahl_konso);
        end;
      'c', 'C': // wenn c im men� ausgew�hlt wird
        begin
          i := 1;
          while i <= length(eingabe) do
          begin // Die auftauchenen Zahlen werden gel�scht und ausgeschrieben
            case eingabe[i] of

              '1':
                begin

                  insert('eins', eingabe, Pos('1', eingabe));
                  delete(eingabe, Pos('1', eingabe), 1);

                end;
              '2':
                begin

                  insert('zwei', eingabe, Pos('2', eingabe));
                  delete(eingabe, Pos('2', eingabe), 1);

                end;
              '3':
                begin

                  insert('drei', eingabe, Pos('3', eingabe));
                  delete(eingabe, Pos('3', eingabe), 1);

                end;
              '4':
                begin

                  insert('vier', eingabe, Pos('4', eingabe));
                  delete(eingabe, Pos('4', eingabe), 1);

                end;
              '5':
                begin

                  insert('f�nf', eingabe, Pos('5', eingabe));
                  delete(eingabe, Pos('5', eingabe), 1);

                end;
              '6':
                begin

                  insert('sechs', eingabe, Pos('6', eingabe));
                  delete(eingabe, Pos('6', eingabe), 1);

                end;
              '7':
                begin

                  insert('sieben', eingabe, Pos('7', eingabe));
                  delete(eingabe, Pos('7', eingabe), 1);

                end;
              '8':
                begin

                  insert('acht', eingabe, Pos('8', eingabe));
                  delete(eingabe, Pos('8', eingabe), 1);

                end;
              '9':
                begin

                  insert('neun', eingabe, Pos('9', eingabe));
                  delete(eingabe, Pos('9', eingabe), 1);

                end;
              '0':
                begin

                  insert('null', eingabe, Pos('0', eingabe));
                  delete(eingabe, Pos('0', eingabe), 1);

                end;
            end;
            inc(i);
          end;
          writeln('In Worten: ', eingabe)
        end; // Ausgabe der gesammten Eingabe mit ausgeschriebenen Zahlen
      'd', 'D': // i, j, n, kopie, temp, start, ende
        begin
          repeat

          begin
            if (Pos(' ', eingabe) = 0) then
            begin
              kopie := copy(eingabe, 1, length(eingabe));
              delete(eingabe, 1, length(eingabe));
            end
            // kopiert gesammte Eingabe, wenn kein Leerzeichen mehr Vorhanden ist und l�scht gesammte Eingabe
            else

            begin
              kopie := copy(eingabe, 1, Pos(' ', eingabe));
              delete(eingabe, 1, Pos(' ', eingabe));
            end;
            // kopiert das Wort bis zum Leerzeichen und l�scht es aus der Eingabe

            for n := length(kopie) downto 2 do // Von der L�nge bis 2
            begin

              for j := 2 to n do // Von 2 bis zur l�nge von n
              begin
                if kopie[j - 1] > kopie[j] then // Eintrittsbedingung
                begin
                  temp := kopie[j - 1];
                  kopie[j - 1] := kopie[j];
                  kopie[j] := temp;
                  // Stellen der zwei Buchstaben werden vertauscht mithilfe der "temp" Variable
                end;

              end;
            end;
            k := k + kopie + ' ';
            // Verarbeitete Kopie wird in "k" abgelegt und ein Leerzeichen angef�gt (um Fehler zu vermeiden)
          end;
          until (length(eingabe) = 0);
          // Vorgang wiederholt sich, bis die ganze Eingabe verarbeitet wurde
          writeln('Neu Sortiert: ', k);
        end;
    end;
  until (upcase(auswahl) = 'X');

  // Programm schlie�t erst, wenn x ausgew�hlt wird

  writeln('Enter zum beenden');

  readln;

  { Wenn "a" nicht zu Anfang ausgew�hlt wurde, ploppt das Men� immer wieder auf.
    Wenn eine Funktion ausgew�hlt wird, ohne vorherige Satzeingabe unter "a", wird
    die gew�nschte Funktion zwar ausgef�hrt, das Ergebnis bleibt aber leer.
    Das Men� wird unendlich oft hervorgerufen, bis es mit der Eingabe von "x" manuell
    beendet wird. }
end.

