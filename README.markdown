Feedback
========

Eine Webapplikation zur Erstellung, Verwaltung und organisation von Feedbackbögen im Praktikumssemester.

Neuste Features
---------------

- LDAP Authentifizierung komplett
  - User erstellung automatisiert
  - LDAP fetchen der User daten
  - Komplettes Session Handling
  - Devise und Omniauth entfernt
  - LDAP auth, fetchen des DN
- Rolle prof entfernt, neue Rolle extern



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

Known Issues / Bugs
-------------------

- Länderliste im Moment noch mit englischen Namen




Features TODO
-------------

- Struktur des FB verbessern ...
- Versioning für FB
- paranoia mode => FB bei delete nicht wirklich löschen nur als gelöscht markieren
- Multistep Formular für den FB
- Suche für die Feedbackbögen
- Adminitrationsbereich, mehr Funktionen
- automatisiertes deployment auf Apache + Passanger


Hintergrund
-----------

- Ruby 1.9.2
- Rails 3.0.3
- RSpec
- Mocha
- Cucumber

Feedback &copy; Eger Andreas 2010

Wird im Rahmen einer Bachelorarbeit der HS Regensburg entwickelt.

