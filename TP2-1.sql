-- #############################################################################
-- # INF3180 - Groupe 32                                                       #
-- # A16 - TP2-1                                                               #
-- #                                                                           #
-- # Guillaume Gagnon                                                          #
-- # GAGG15048002                                                              #
-- #############################################################################

SET ECHO ON;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';
SET SERVEROUTPUT ON;

--
PROMPT Creation des tables
DROP TABLE Inscription
/
DROP TABLE GroupeCours
/
DROP TABLE Prealable
/
DROP TABLE Cours
/
DROP TABLE SessionUQAM
/
DROP TABLE Etudiant
/
DROP TABLE Professeur
/

CREATE TABLE Cours
(sigle 		  CHAR(7) 	    NOT NULL,
 titre 		  VARCHAR(50) 	NOT NULL,
 nbCredits 	INTEGER 	    NOT NULL,
 CONSTRAINT ClePrimaireCours PRIMARY KEY 	(sigle)
)
/
CREATE TABLE Prealable
(sigle 		      CHAR(7) 	NOT NULL,
 siglePrealable CHAR(7) 	NOT NULL,
 CONSTRAINT ClePrimairePrealable PRIMARY KEY 	(sigle,siglePrealable),
 CONSTRAINT CEsigleRefCours FOREIGN KEY 	(sigle) REFERENCES Cours,
 CONSTRAINT CEsiglePrealableRefCours FOREIGN KEY 	(siglePrealable) REFERENCES Cours(sigle)
)
/
CREATE TABLE SessionUQAM
(codeSession 	INTEGER		NOT NULL,
 dateDebut 	  DATE	  	NOT NULL,
 dateFin 	    DATE		  NOT NULL,
 CONSTRAINT ClePrimaireSessionUQAM PRIMARY KEY 	(codeSession)
)
/
CREATE TABLE Professeur
(codeProfesseur		CHAR(5)   	NOT NULL,
 nom			        VARCHAR(10)	NOT NULL,
 prenom		        VARCHAR(10)	NOT NULL,
 CONSTRAINT ClePrimaireProfesseur PRIMARY KEY 	(codeProfesseur)
)
/
CREATE TABLE GroupeCours
(sigle 		        CHAR(7) 	NOT NULL,
 noGroupe	        INTEGER		NOT NULL,
 codeSession	    INTEGER		NOT NULL,
 maxInscriptions	INTEGER		NOT NULL,
 codeProfesseur		CHAR(5)	  NOT NULL,
CONSTRAINT ClePrimaireGroupeCours PRIMARY KEY 	(sigle,noGroupe,codeSession),
CONSTRAINT CESigleGroupeRefCours FOREIGN KEY 	(sigle) REFERENCES Cours,
CONSTRAINT CECodeSessionRefSessionUQAM FOREIGN KEY 	(codeSession) REFERENCES SessionUQAM,
CONSTRAINT CEcodeProfRefProfesseur FOREIGN KEY(codeProfesseur) REFERENCES Professeur 
)
/
CREATE TABLE Etudiant
(codePermanent 	CHAR(12) 	  NOT NULL,
 nom		        VARCHAR(10)	NOT NULL,
 prenom		      VARCHAR(10)	NOT NULL,
 codeProgramme	INTEGER,
CONSTRAINT ClePrimaireEtudiant PRIMARY KEY 	(codePermanent)
)
/
CREATE TABLE Inscription
(codePermanent 	 CHAR(12) 	NOT NULL,
 sigle 		       CHAR(7)  	NOT NULL,
 noGroupe	       INTEGER		NOT NULL,
 codeSession	   INTEGER		NOT NULL,
 dateInscription DATE		    NOT NULL,
 dateAbandon	   DATE,
 note		         INTEGER,
CONSTRAINT ClePrimaireInscription PRIMARY KEY 	(codePermanent,sigle,noGroupe,codeSession),
CONSTRAINT CERefGroupeCours FOREIGN KEY 	(sigle,noGroupe,codeSession) REFERENCES GroupeCours,
CONSTRAINT CECodePermamentRefEtudiant FOREIGN KEY (codePermanent) REFERENCES Etudiant
)
/

PROMPT Insertion de donnees pour les essais

INSERT INTO Cours 
VALUES('INF3180','Fichiers et bases de donnees',3)
/
INSERT INTO Cours 
VALUES('INF5180','Conception et exploitation d''une base de donnees',3)
/
INSERT INTO Cours 
VALUES('INF1110','Programmation I',3)
/
INSERT INTO Cours 
VALUES('INF1130','Mathematiques pour informaticien',3)
/
INSERT INTO Cours 
VALUES('INF2110','Programmation II',3)
/
INSERT INTO Cours 
VALUES('INF3123','Programmation objet',3)
/
INSERT INTO Cours 
VALUES('INF2160','Paradigmes de programmation',3)
/

INSERT INTO Prealable 
VALUES('INF2110','INF1110')
/
INSERT INTO Prealable 
VALUES('INF2160','INF1130')
/
INSERT INTO Prealable 
VALUES('INF2160','INF2110')
/
INSERT INTO Prealable 
VALUES('INF3180','INF2110')
/
INSERT INTO Prealable 
VALUES('INF3123','INF2110')
/
INSERT INTO Prealable 
VALUES('INF5180','INF3180')
/

INSERT INTO SessionUQAM
VALUES(32003,'3/09/2003','17/12/2003')
/
INSERT INTO SessionUQAM
VALUES(12004,'8/01/2004','2/05/2004')
/

INSERT INTO Professeur
VALUES('TREJ4','Tremblay','Jean')
/
INSERT INTO Professeur
VALUES('DEVL2','De Vinci','Leonard')
/
INSERT INTO Professeur
VALUES('PASB1','Pascal','Blaise')
/
INSERT INTO Professeur
VALUES('GOLA1','Goldberg','Adele')
/
INSERT INTO Professeur
VALUES('KNUD1','Knuth','Donald')
/
INSERT INTO Professeur
VALUES('GALE9','Galois','Evariste')
/
INSERT INTO Professeur
VALUES('CASI0','Casse','Illa')
/
INSERT INTO Professeur
VALUES('SAUV5','Sauve','Andre')
/

INSERT INTO GroupeCours
VALUES('INF1110',20,32003,100,'TREJ4')
/
INSERT INTO GroupeCours
VALUES('INF1110',30,32003,100,'PASB1')
/
INSERT INTO GroupeCours
VALUES('INF1130',10,32003,100,'PASB1')
/
INSERT INTO GroupeCours
VALUES('INF1130',30,32003,100,'GALE9')
/
INSERT INTO GroupeCours
VALUES('INF2110',10,32003,100,'TREJ4')
/
INSERT INTO GroupeCours
VALUES('INF3123',20,32003,50,'GOLA1')
/
INSERT INTO GroupeCours
VALUES('INF3123',30,32003,50,'GOLA1')
/
INSERT INTO GroupeCours
VALUES('INF3180',30,32003,50,'DEVL2')
/
INSERT INTO GroupeCours
VALUES('INF3180',40,32003,50,'DEVL2')
/
INSERT INTO GroupeCours
VALUES('INF5180',10,32003,50,'KNUD1')
/
INSERT INTO GroupeCours
VALUES('INF5180',40,32003,50,'KNUD1')
/
INSERT INTO GroupeCours
VALUES('INF1110',20,12004,100,'TREJ4')
/
INSERT INTO GroupeCours
VALUES('INF1110',30,12004,100,'TREJ4')
/
INSERT INTO GroupeCours
VALUES('INF2110',10,12004,100,'PASB1')
/
INSERT INTO GroupeCours
VALUES('INF2110',40,12004,100,'PASB1')
/
INSERT INTO GroupeCours
VALUES('INF3123',20,12004,50,'GOLA1')
/
INSERT INTO GroupeCours
VALUES('INF3123',30,12004,50,'GOLA1')
/
INSERT INTO GroupeCours
VALUES('INF3180',10,12004,50,'DEVL2')
/
INSERT INTO GroupeCours
VALUES('INF3180',30,12004,50,'DEVL2')
/
INSERT INTO GroupeCours
VALUES('INF5180',10,12004,50,'DEVL2')
/
INSERT INTO GroupeCours
VALUES('INF5180',40,12004,50,'GALE9')
/

INSERT INTO Etudiant
VALUES('TREJ18088001','Tremblay','Jean',7416)
/
INSERT INTO Etudiant
VALUES('TREL14027801','Tremblay','Lucie',7416)
/
INSERT INTO Etudiant
VALUES('DEGE10027801','Degas','Edgar',7416)
/
INSERT INTO Etudiant
VALUES('MONC05127201','Monet','Claude',7316)
/
INSERT INTO Etudiant
VALUES('VANV05127201','Van Gogh','Vincent',7316)
/
INSERT INTO Etudiant
VALUES('MARA25087501','Marshall','Amanda',null)
/
INSERT INTO Etudiant
VALUES('STEG03106901','Stephani','Gwen',7416)
/
INSERT INTO Etudiant
VALUES('EMEK10106501','Emerson','Keith',7416)
/
INSERT INTO Etudiant
VALUES('DUGR08085001','Duguay','Roger',null)
/
INSERT INTO Etudiant
VALUES('LAVP08087001','Lavoie','Paul',null)
/
INSERT INTO Etudiant
VALUES('TREY09087501','Tremblay','Yvon',7316)
/

INSERT INTO Inscription
VALUES('TREJ18088001','INF1110',20,32003,'16/08/2003',null,80)
/
INSERT INTO Inscription
VALUES('LAVP08087001','INF1110',20,32003,'16/08/2003',null,80)
/
INSERT INTO Inscription
VALUES('TREL14027801','INF1110',30,32003,'17/08/2003',null,90)
/
INSERT INTO Inscription
VALUES('MARA25087501','INF1110',20,32003,'20/08/2003',null,80)
/
INSERT INTO Inscription
VALUES('STEG03106901','INF1110',20,32003,'17/08/2003',null,70)
/
INSERT INTO Inscription
VALUES('TREJ18088001','INF1130',10,32003,'16/08/2003',null,70)
/
INSERT INTO Inscription
VALUES('TREL14027801','INF1130',30,32003,'17/08/2003',null,80)
/
INSERT INTO Inscription
VALUES('MARA25087501','INF1130',10,32003,'22/08/2003',null,90)
/
INSERT INTO Inscription
VALUES('DEGE10027801','INF3180',30,32003,'16/08/2003',null,90)
/
INSERT INTO Inscription
VALUES('MONC05127201','INF3180',30,32003,'19/08/2003',null,60)
/
INSERT INTO Inscription
VALUES('VANV05127201','INF3180',30,32003,'16/08/2003','20/09/2003',null)
/
INSERT INTO Inscription
VALUES('EMEK10106501','INF3180',40,32003,'19/08/2003',null,80)
/
INSERT INTO Inscription
VALUES('DUGR08085001','INF3180',40,32003,'19/08/2003',null,70)
/
INSERT INTO Inscription
VALUES('TREJ18088001','INF2110',10,12004,'19/12/2003',null,80)
/
INSERT INTO Inscription
VALUES('TREL14027801','INF2110',10,12004,'20/12/2003',null,90)
/
INSERT INTO Inscription
VALUES('MARA25087501','INF2110',40,12004,'19/12/2003',null,90)
/
INSERT INTO Inscription
VALUES('STEG03106901','INF2110',40,12004, '10/12/2003',null,70)
/
INSERT INTO Inscription
VALUES('VANV05127201','INF3180',10,12004, '18/12/2003',null,90)
/
INSERT INTO Inscription
VALUES('DEGE10027801','INF5180',10,12004, '15/12/2003',null,90)
/
INSERT INTO Inscription
VALUES('MONC05127201','INF5180',10,12004, '19/12/2003','22/01/2004',null)
/
INSERT INTO Inscription
VALUES('EMEK10106501','INF5180',40,12004, '19/12/2003',null,80)
/
INSERT INTO Inscription
VALUES('DUGR08085001','INF5180',10,12004, '19/12/2003',null,80)
/
COMMIT
/
PROMPT Contenu des tables
SELECT * FROM Cours
/
SELECT * FROM Prealable
/
SELECT * FROM SessionUQAM
/
SELECT * FROM Professeur
/
SELECT * FROM GroupeCours
/
SELECT * FROM Etudiant
/
SELECT * FROM Inscription
/

-- *****************************************************************************
-- ************************** Debut du TP2-1 ***********************************
-- *****************************************************************************

-- ################################ C1 #########################################
-- C1
ALTER TABLE groupecours
ADD CONSTRAINT Contrainte_C1
  CHECK (maxinscriptions <= 120)
;

-- C1 -> Test A (Ajout avec MAXINSCRIPTIONS à 121)
INSERT INTO groupecours
VALUES('INF2160',20,32003,121,'TREJ4')
;

-- C1 -> Test B (Update avec MAXINSCRIPTIONS à 121)
UPDATE groupecours
SET    maxinscriptions = 121
WHERE  sigle = 'INF1110' AND 
       nogroupe = 20 AND 
       codesession = 32003
;


-- ################################ C2 #########################################
-- C2
CREATE OR REPLACE TRIGGER Contrainte_C2
BEFORE INSERT OR UPDATE OF datedebut, datefin ON sessionuqam
FOR EACH ROW
BEGIN
  IF (:NEW.datefin != (:NEW.datedebut + 90)) THEN
    raise_application_error(-20021, 
      'La date de fin de session doit être d''exactement 90 jours supérieure à la date de début de session');
  END IF;
END;
/

-- C2 -> Test A (Ajout avec DATEFIN = (DATEDEBUT + 89)
INSERT INTO sessionuqam
VALUES(32004,'3/09/2003','01/12/2003')
;

-- C2 -> Test B (Update avec DATEDEBUT = (DATEFIN - 91)
UPDATE sessionuqam
SET    datedebut = datefin - 91
WHERE  codesession = 32003
;


-- ################################ C3 #########################################
-- C3
CREATE OR REPLACE TRIGGER Contrainte_C3
BEFORE INSERT OR UPDATE OF dateabandon ON inscription
FOR EACH ROW
DECLARE
  datedebutsession    DATE;
  datefinsession      DATE;
BEGIN
  SELECT datedebut, datefin
  INTO   datedebutsession, datefinsession
  FROM   sessionuqam 
  WHERE  codesession = :NEW.codesession;

  IF (:NEW.dateabandon < datedebutsession + 30) THEN
    raise_application_error(-20031, 
      'La date d''abandon d''un cours doit être de 30 jours supérieur à la date de début de session!');
  END IF;
  
  IF (:NEW.dateabandon >= datefinsession) THEN
    raise_application_error(-20032, 
      'La date d''abandon d''un cours doit toujours être inférieur à la date de fin de session!');
  END IF;
END;
/

-- C3 -> Test A (Ajout avec DATEABANDON = datedebut+29)
INSERT INTO Inscription
VALUES('TREY09087501','INF1110',20,32003,'25/08/2003','02/10/2003',80) -- 02/10/2003=datedebut+29
;

-- C3 -> Test B (Abandon le dernier jour de la session non permis)
UPDATE Inscription
SET    dateabandon = '17/12/2003'
WHERE  codepermanent = 'TREJ18088001' AND
       sigle = 'INF1110' AND
       nogroupe = 20 AND
       codesession = 32003
;


-- ################################ C4 #########################################
-- C4
ALTER TABLE inscription
ADD CONSTRAINT Contrainte_C4
  CHECK ((dateabandon IS NULL) OR (dateabandon IS NOT NULL AND note IS NULL))
;

-- C4 -> Test A (Ajout d'une inscription avec une date d'abandon et une note)
INSERT INTO Inscription
VALUES('TREY09087501','INF1110',20,32003,'25/08/2003','02/11/2003',90)
;

-- C4 -> Test B (Update pour ajouter une date d'abandon à un étudiant ayant déjà une note)
UPDATE Inscription
SET    dateabandon = '01/12/2003'
WHERE  codepermanent = 'TREJ18088001' AND
       sigle = 'INF1110' AND
       nogroupe = 20 AND
       codesession = 32003
;


-- ################################ C5 #########################################
-- C5
ALTER TABLE inscription DROP CONSTRAINT CERefGroupeCours -- Drop la contrainte d'origine
; 
ALTER TABLE inscription -- Création de la nouvelle contrainte 
ADD CONSTRAINT Contrainte_C5 
  FOREIGN KEY (sigle,noGroupe,codeSession) REFERENCES GroupeCours
    ON DELETE CASCADE
;

-- C5 -> Test A (Efface un groupecours et ses inscriptions correspondantes)
DELETE FROM groupecours
WHERE sigle = 'INF1110' AND 
      nogroupe = 20 AND 
      codesession = 32003
;

-- C5 -> Test B (Efface un deuxième groupecours et ses inscriptions correspondantes)
DELETE FROM groupecours
WHERE sigle = 'INF1110' AND 
      nogroupe = 30 AND 
      codesession = 32003
;

-- C5 -> Resultats des Tests (Cours INF1110 groupes 20 et 30 ne sont plus présents à la session 32003)
SELECT *
FROM   inscription
WHERE  codesession = 32003 AND
       sigle = 'INF1110' AND
       NOGROUPE IN (20,30)
;


-- ################################ C6 #########################################
-- C6 Note: J'ai validé cette méthode avec Mme Sadat en classe.
CREATE INDEX siglecodesession_index ON groupecours (sigle, codesession) -- Création index unique pour entrées déjà présentes
;
ALTER TABLE groupecours
ADD CONSTRAINT Contrainte_C6
  UNIQUE (sigle, codesession)
  ENABLE NOVALIDATE -- Actifs pour prochaines modifications mais ne pas tenir compte des entrées déjà présentes
;

-- C6 -> Test A (Ajout d'un 2ieme groupe pour le cours INF2110 à la session 32003)
INSERT INTO groupecours
VALUES('INF2110',11,32003,99,'TREJ4')
;

-- C6 -> Test B (Change le sigle d'un groupe pour le cours INF2110 déjà présent à la session 32003)
UPDATE groupecours
SET sigle = 'INF2110'
WHERE sigle = 'INF1130' AND nogroupe = 30 AND codesession = 32003
;


-- ################################ C7 #########################################
-- C7
CREATE OR REPLACE TRIGGER Contrainte_C7
BEFORE UPDATE OF note ON inscription
FOR EACH ROW
BEGIN
  IF (:NEW.note > (:OLD.note * 1.05)) THEN
    raise_application_error(-20071, 
      'Il est interdit de faire augmenter la valeur de la note de plus de 5% lors d''une mise à jour!');
  END IF;
END;
/

-- C7 -> Test A (70 + 5% = 73.5 ... test avec 74)
UPDATE inscription
SET note = 74
WHERE codepermanent = 'TREJ18088001' AND
      sigle = 'INF1130' AND
      nogroupe = 10 AND
      codesession = 32003
;

-- C7 -> Test B (80 + 5% = 84 ... test avec 85)
UPDATE inscription
SET note = 85
WHERE codepermanent = 'TREL14027801' AND
      sigle = 'INF1130' AND
      nogroupe = 30 AND
      codesession = 32003
;


-- ################################ C8 #########################################
-- C8
ALTER TABLE groupecours
ADD nbAbandons INTEGER 
    CONSTRAINT Contrainte_C8 CHECK ((nbAbandons IS NULL) OR (nbAbandons >= 0))
;
     
-- C8 -> Test A (Tentative de modification nbAbandons à -1)
UPDATE groupecours
SET nbAbandons = -1
WHERE sigle = 'INF1130' AND
      nogroupe = 10 AND
      codesession = 32003
;

-- C8 -> Test B (Modification nbAbandons à null)
UPDATE groupecours
SET nbAbandons = null
WHERE sigle = 'INF1130' AND
      nogroupe = 30 AND
      codesession = 32003
;


-- ################################ C9 #########################################
-- C9

-- C9 -> Test A

-- C9 -> Test B

COMMIT
/

