Feedback
========

Eine Webapplikation zur Erstellung, Verwaltung und organisation von Feedbackbögen im Praktikumssemester.
Wird im Rahmen einer Bachelorarbeit der HS Regensburg entwickelt.

Neuste Features
---------------

- Pagination bei Suche und Userübersicht
- Script zum seeden der Datenbank -> 1000-5000 User inkl FBs
- Versionierung der Feedbackbögen
- Suche über fast alle Felder, über Spike und TDD Refactoring - noch nicht perfect
  - AJAX Suche
  - Instant Search als Gimmick - macht bei jedem Tastendruck ne Abfrage in der DB. Ist wahrscheinlich bei steigender Documentzahl recht langsam und unpraktisch, vor allem da keine Indexe gesetzt sind. - scheint bei ca 500 Sheets ohne indexe noch recht schnell zu sein, allerdings greift auch nur ein user darauf zu...


Implementierte Features
-----------------------

- Anzeige des Feedbackbogens
- Erstellen des Feedbackbogens
- Pflichtattribute
- Benötigte Sprachen als Array
- Adressen in eigenes Dokument
- Authentifizierung als Student, Praktiant, Extern und Admin
- Administrieren einzelner User möglich
- Administrieren mehrer User gleichzeitig möglich
- Praktikant muss Student sein
- Student darf kein extern sein
- LDAP Authentifizierung
- Suche
- Versionierung der Feedbackbögen

Known Issues / Bugs
-------------------

- Länderliste im Moment noch mit englischen Namen


Features TODO
-------------

- Cucumber Features für die Suche
- Struktur des FB verbessern ...
- Multistep Formular für den FB, entweder über JS oder über ne StateMachine
- Indexe zur schnelleren suche einbauen
- Sortierung der Suchergebnisse
- Sortierfunktion für Semester ( WS2009/2010 -> SS2010 -> WS2010/2011 -> ...)
  - Automatisch setzen des aktuellen Semesters (SS von März bis Juli; WS von Oktober bis Januar; evtl lücken sinnvoll schließen)
- deutsche Lokalisierung
- Adminitrationsbereich, mehr Funktionen
- User Statistics
  - login count
  - ...
- automatisiertes deployment auf Apache + Passanger


Hintergrund
-----------

- Ruby 1.9.2 & REE
- Rails 3.0.3
- RSpec
- Mocha
- Cucumber

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">feedback</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/sch1zo/feedback" rel="dct:source">github.com</a>.

Eger Andreas 2010

