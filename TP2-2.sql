-- #############################################################################
-- # INF3180 - Groupe 32                                                       #
-- # A16 - TP2-2                                                               #
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
-- ************************** Debut du TP2-2 ***********************************
-- *****************************************************************************

-- ################################ 2.1 ########################################
CREATE OR REPLACE VIEW MoyenneParGroupeParSession (sigle, nogroupe, codesession, MoyenneGroupe) AS
SELECT    sigle, nogroupe, codesession, AVG(note) AS MoyenneGroupe
FROM      inscription
GROUP BY  sigle, nogroupe, codesession
ORDER BY  codesession, sigle, nogroupe -- Pas demand�, mais plus lisible
;


-- ################################ 2.2 ########################################
SELECT * FROM MoyenneParGroupeParSession
;


-- ################################ 2.3 ########################################
CREATE OR REPLACE TRIGGER Demande_23
INSTEAD OF UPDATE ON MoyenneParGroupeParSession
FOR EACH ROW
BEGIN
  UPDATE inscription
  SET    note = note + (:NEW.MoyenneGroupe - :OLD.MoyenneGroupe)
  WHERE  note IS NOT NULL AND
         sigle = :NEW.sigle AND
         nogroupe = :NEW.nogroupe AND
         codesession = :NEW.codesession;
END;
/


-- ################################ 2.4 ########################################
-- 2.4.1
UPDATE MoyenneParGroupeParSession
SET    moyennegroupe = moyennegroupe + 10
WHERE  sigle = 'INF1110' AND
       nogroupe = 20 AND
       codesession = 32003
;

-- 2.4.2
SELECT *
FROM   MoyenneParGroupeParSession
WHERE  sigle = 'INF1110' AND
       nogroupe = 20 AND
       codesession = 32003
;

-- 2.4.3
SELECT * 
FROM   inscription
WHERE  note IS NOT NULL AND
       sigle = 'INF1110' AND
       nogroupe = 20 AND
       codesession = 32003
;


-- ################################ 3.1 ########################################
CREATE OR REPLACE FUNCTION LibreEnseignement
(codeProf IN groupecours.codeprofesseur%TYPE,
 codeSess IN groupecours.codesession%TYPE
) RETURN BOOLEAN
IS
  countCours   INTEGER;
BEGIN
  SELECT COUNT(*)
  INTO   countCours
  FROM   GroupeCours
  WHERE  codeprofesseur = codeProf AND codesession = codeSess;
  
  RETURN (countCours = 0);
END LibreEnseignement;
/


-- ################################ 3.2 ########################################
-- Sous procedure pour l'affichage des groupecours d'un prof pour une session
CREATE OR REPLACE PROCEDURE AfficheTachesSession
(codeProf IN groupecours.codeprofesseur%TYPE,
 codeSess IN groupecours.codesession%TYPE)
IS
  siglesStr     VARCHAR(32767);
  noGroupesStr  VARCHAR(32767);
BEGIN
  FOR i IN (SELECT sigle, nogroupe
            FROM   GroupeCours
            WHERE  codeprofesseur = codeProf AND codesession = codeSess)
  LOOP
    siglesStr := siglesStr || i.sigle || ', ';
    noGroupesStr := noGroupesStr || i.nogroupe || ', ';
  END LOOP;

  -- Retire virgule et espace en trop avant l'affichage
  siglesStr := SUBSTR(siglesStr, 1, LENGTH(siglesStr) - 2);
  noGroupesStr := SUBSTR(noGroupesStr, 1, LENGTH(noGroupesStr) - 2);
  
  DBMS_OUTPUT.PUT_LINE('Professeur ' || codeProf || ' enseigne les cours ' || siglesStr || 
            ' pendant la session ' || codeSess || ' pour les groupes ' || noGroupesStr || '.');
END;
/

-- Procedure principale demande dans l'enonce
CREATE OR REPLACE PROCEDURE TacheProfesseur
(codeProf IN groupecours.codeprofesseur%TYPE)
IS
  isExistingProf INTEGER;
BEGIN
  SELECT COUNT(*) INTO isExistingProf FROM professeur WHERE codeprofesseur = codeProf;

  IF (isExistingProf = 0) THEN
    DBMS_OUTPUT.PUT_LINE('Professeur ' || codeProf || ' n''existe pas dans la table professeur.');
  ELSE
    FOR i IN (SELECT codesession FROM sessionuqam)
    LOOP
      IF (LibreEnseignement(codeProf, i.codesession)) THEN
        DBMS_OUTPUT.PUT_LINE('Professeur ' || codeProf || 
                  ' est disponible pendant la session ' || i.codesession || '.');
      ELSE
        AfficheTachesSession(codeProf, i.codesession);
      END IF;
    END LOOP;
  END IF;
END;
/


-- ################################ 3.3 ########################################
-- Test prof disponible
EXECUTE TacheProfesseur('SAUV5');
-- Test prof pas disponible
EXECUTE TacheProfesseur('TREJ4');
-- Test prof qui n'existe pas
EXECUTE TacheProfesseur('ABCD7'); 


