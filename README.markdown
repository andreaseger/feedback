Feedback
========

Eine Webapplikation zur Erstellung, Verwaltung und organisation von Feedbackbögen im Praktikumssemester.
Wird im Rahmen einer Bachelorarbeit der HS Regensburg entwickelt.

Neuste Features
---------------

- deutsche Lokalisierung


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
- Matrikelnummer aus LDAP
- Adminitrationsbereich für Semester
- Umstellung der Praktikantenverwaltung
- Semester als eigenes Model


Known Issues / Bugs
-------------------

- Länderliste im Moment noch mit englischen Namen
- Praktikant muss Student sein: wir nicht direkt geprüft, allerdings haben nur Studenten Matrikelnummern
- bei der ersten Anmeldung eines neuen Users wird nur das aktuelle Semester getestet ob er Praktikant ist. Also wenn das nächste Semester schon erstellt wurde und dort Praktikanten angelegt sind wird der neue User nicht zugewiesen. Könnte in einem Background worker gemacht werden: zb Beanstalkd and Stalker(http://railscasts.com/episodes/243-beanstalkd-and-stalker)

Features TODO
-------------

- vollständige Lokalisierung
- Multistep Formular für den FB, entweder über JS oder über ne StateMachine(http://railscasts.com/episodes/217-multistep-forms)
- Indexe zur schnelleren Suche einbauen oder Volltextsuche via SORL Sphinx
- Sortierung der Suchergebnisse
- Adminitrationsbereich, weitere Funktionen
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

