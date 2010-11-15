# language: de
Funktionalität: Feedbachbogen verwalten
  Um Feedbackbogen verwalten zu können
  möchte ich als Student
  den Feedbackbogen erstellen, ansehen und editieren

  Szenario: Anzeigen eines Feedbackbogens
    Angenommen ich habe einen "Feedbackbogen" mit folgenden Daten:
        | Firma | Semester  | Gehalt | Ort        |
        | BMW   | WS2010/11 | 700€   | Regensburg |
    Wenn ich gehe auf die Anzeigeseite des Feedbackbogens
    Dann sollte ich folgendes sehen:
        | BMW   | WS2010/11 | 700€   | Regensburg |


  Szenariogrundriss: Anzeigen der Attribute
    Angenommen ich habe einen "Feedbackbogen" mit "<attribut>" gleich "<value>"
    Wenn ich gehe auf die Anzeigeseite des Feedbackbogens
    Dann sollte ich "<attribut>" sehen
    Und ich sollte "<value> sehen"

  Beispiele:
    | attribut  | value     |
    | Firma     | Audi      |
    | Semester  | SS2009    |
    | Gehalt    | 750€      |
    | Ort       | München   |
    | Dauer     | 20 Wochen |

