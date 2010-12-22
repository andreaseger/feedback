Feedback
========

Eine Webapplikation zur Erstellung, Verwaltung und organisation von Feedbackbögen im Praktikumssemester.
Wird im Rahmen einer Bachelorarbeit der HS Regensburg entwickelt.

Neuste Features
---------------

- Matrikelnummer aus LDAP
- Adminitrationsbereich für Semester
- Umstellung der Praktikantenverwaltung
- Semester als eigenes Model


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
- Student darf kein extern sein
- LDAP Authentifizierung
- Suche
- Versionierung der Feedbackbögen
- Script zum seeden der Datenbank

Known Issues / Bugs
-------------------

- Länderliste im Moment noch mit englischen Namen
- Praktikant muss Student sein: wir nicht direkt geprüft, allerdings haben nur Studenten Matrikelnummern


Features TODO
-------------

- Cucumber Features für die Suche
- Struktur des FB verbessern ...
- Multistep Formular für den FB, entweder über JS oder über ne StateMachine
- Indexe zur schnelleren suche einbauen
- Sortierung der Suchergebnisse
- deutsche Lokalisierung
- Adminitrationsbereich, mehr Funktionen
- automatisiertes deployment auf Apache + Passanger
- Orts und Umkreissuche anhand der Adresse

Hintergrund
-----------

- Ruby 1.9.2 & REE
- Rails 3.0.3
- RSpec
- Mocha
- Cucumber

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a>

Eger Andreas 2010

