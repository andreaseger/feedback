Feedback
========

Eine Webapplikation zur Erstellung, Verwaltung und organisation von Feedbackbögen im Praktikumssemester.
Wird im Rahmen einer Bachelorarbeit der HS Regensburg entwickelt.

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

- Ruby 1.9.2 & REE
- Rails 3.0.3
- RSpec
- Mocha
- Cucumber

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">feedback</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/sch1zo/feedback" rel="dct:source">github.com</a>.

Eger Andreas 2010

