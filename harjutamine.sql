-- Create table Amet
CREATE TABLE Amet (amet_kood SMALLINT NOT NULL,
nimetus VARCHAR(50) NOT NULL,
max_tootunde_nadalas SMALLINT NOT NULL DEFAULT 40,
min_palk CURRENCY NOT NULL,
CONSTRAINT pk_amet_kood PRIMARY KEY(amet_kood),
CONSTRAINT ak_amet_nimetus UNIQUE (nimetus));

-- Create table Tootaja
CREATE TABLE Tootaja (tootaja_id NOT NULL AUTOINCREMENT,
amet_kood SMALLINT NOT NULL,
synni_kp DateTime NOT NULL,
kontaktaadress VARCHAR(255) NOT NULL,
register_aeg: DateTime DEFAULT Now() NOT NULL,
on_aktuaalne YesNo DEFAULT TRUE NOT NULL,
eesnimi VARCHAR(255),
perenimi VARCHAR(255),
CONSTRAINT pk_tootaja PRIMARY KEY (tootaja_id),
CONSTRAINT fk_tootaja_amet_kood FOREIGN KEY (amet_kood) REFERENCES Amet (amet_kood) );

CREATE TABLE Tootaja (tootaja_id AUTOINCREMENT NOT NULL,
amet_kood SMALLINT NOT NULL,
synni_kp DateTime NOT NULL,
kontaktaadress VARCHAR(255) NOT NULL,
register_aeg DateTime DEFAULT Now() NOT NULL,
on_aktuaalne YesNo DEFAULT TRUE NOT NULL,
eesnimi VARCHAR(255),
perenimi VARCHAR(255),
CONSTRAINT pk_tootaja PRIMARY KEY (tootaja_id),
CONSTRAINT fk_tootaja_amet_kood FOREIGN KEY (amet_kood) REFERENCES Amet (amet_kood) ON UPDATE CASCADE ON DELETE NO ACTION);

SELECT aine_kood, UPPER(nimetus), punkte, kommentaar FROM a

SELECT Avg(hind) AS keskm_hind FROM Ruum WHERE ruumi_tüüp = 'Äriklassi tuba';

SELECT hotelli_nr, ruumi_nr, Year(alguse_aeg) AS Aasta 
FROM Reserveerimine 
WHERE Aasta BETWEEN 2004 AND 2009;

SELECT Count(*) AS Arv
FROM Hotell
WHERE linn = 'Tallinn' 
AND (nimi LIKE 'R%' OR nimi LIKE 'O%');

SELECT kanne_id, konto_id, kande_aeg, summa, 0 + konto AS kontojääk
FROM Kanne 
ORDER BY konto_id, kande_aeg;

/* 10.03.2021 praktikum */
SELECT Oppimine.*, Tudeng.eesnimi & ' ' & Tudeng.perenimi AS tudengi_nimi, Oppejoud.perenimi AS oppejou_perenimi, Aine.nimetus AS aine_nimetus
FROM Oppimine, Tudeng, Oppejoud, Aine
WHERE oppim_algus >= #1998-01-01# AND oppim_algus <= #1999-01-01# 
AND Oppimine.tudeng=Tudeng.tudkood
AND Oppimine.oppejoud = Oppejoud.oppejou_kood
AND Oppimine.aine=Aine.aine_kood
AND Oppimine.oppimine IN (SELECT oppimine
FROM Eksam 
WHERE tulemus IN (4,5));

-- VANEM SÜNTAKS tabelite ühendamisel
-- Older syntax for joining tables
SELECT Oppimine.*, Tudeng.eesnimi & ' ' & Tudeng.perenimi AS tudengi_nimi, Oppejoud.perenimi AS oppejou_perenimi, Aine.nimetus AS aine_nimetus
FROM Oppimine, Tudeng, Oppejoud, Aine
WHERE oppim_algus >= #1998-01-01# AND oppim_algus <= #1999-01-01# 
AND Oppimine.tudeng=Tudeng.tudkood
AND Oppimine.oppejoud = Oppejoud.oppejou_kood
AND Oppimine.aine=Aine.aine_kood
AND EXISTS (SELECT oppimine
FROM Eksam 
WHERE tulemus IN (4,5)
AND Eksam.oppimine=Oppimine.oppimine)
ORDER BY Tudeng.perenimi, Aine.nimetus;

SELECT DISTINCT K.külalise_nr, K.eesnimi, K.perenimi
FROM Külaline AS K, Reserveerimine AS R
WHERE K.külalise_nr=R.külalise_nr
AND R.hotelli_nr IN (SELECT hotelli_nr
FROM Hotell AS H 
WHERE nimi = 'Viru')
ORDER BY K.perenimi, K.eesnimi;

SELECT ROUND(AVG(R.lopu_aeg - R.alguse_aeg),2) AS keskmine
FROM Hotell AS H, Reserveerimine AS R
WHERE Year(R.alguse_aeg) IN (2011,2015)
AND R.hotelli_nr = H.hotelli_nr
AND H.linn = 'Tallinn'

-- 17.03 praks
SELECT Tudeng.tudkood, Ucase(Tudeng.perenimi) AS perenimi, Count(*) AS ridade_arv
FROM (Eksam INNER JOIN Oppimine ON Eksam.oppimine=Oppimine.oppimine)
INNER JOIN Tudeng ON Tudeng.tudkood=Oppimine.tudeng
WHERE Eksam.tulemus BETWEEN 1 AND 5
GROUP BY Tudeng.tudkood, Ucase(Tudeng.perenimi);


SELECT * 
FROM (SELECT Tudeng.tudkood, Ucase(Tudeng.perenimi) AS perenimi, Count(*) AS ridade_arv
FROM (Eksam INNER JOIN Oppimine ON Eksam.oppimine=Oppimine.oppimine)
INNER JOIN Tudeng ON Tudeng.tudkood=Oppimine.tudeng
WHERE Eksam.tulemus BETWEEN 1 AND 5
GROUP BY Tudeng.tudkood, Ucase(Tudeng.perenimi)
) AS 1703praksül1
WHERE ridade_arv=(SELECT Max(ridade_arv) as m FROM (SELECT Tudeng.tudkood, Ucase(Tudeng.perenimi) AS perenimi, Count(*) AS ridade_arv
FROM (Eksam INNER JOIN Oppimine ON Eksam.oppimine=Oppimine.oppimine)
INNER JOIN Tudeng ON Tudeng.tudkood=Oppimine.tudeng
WHERE Eksam.tulemus BETWEEN 1 AND 5
GROUP BY Tudeng.tudkood, Ucase(Tudeng.perenimi)
) AS 1703praksül1);

SELECT K.külalise_nr, Ucase(K.perenimi) AS perenimi, Count(*) AS res_arv, ROUND(AVG(R.lopu_aeg - R.alguse_aeg),1) AS keskm_res_pikkus
FROM Külaline AS K, Reserveerimine AS R
WHERE R.külalise_nr=K.külalise_nr
GROUP BY K.külalise_nr, Ucase(K.perenimi)
HAVING Count(*) >= 3
ORDER BY Count(*) DESC, Ucase(K.perenimi);

SELECT Count(*) AS arv
FROM (Ruum AS R INNER JOIN Hotell AS H ON R.hotelli_nr=H.hotelli_nr)
WHERE ((R.hind BETWEEN 100 AND 200) OR R.hind > 300);


/* 24.03 praktikum */
SELECT K.külalise_nr, Ucase(K.perenimi) AS perenimi, Count(*) AS res_arv, ROUND(AVG(R.lopu_aeg - R.alguse_aeg),1) AS keskm_res_pikkus
FROM Külaline AS K, Reserveerimine AS R
WHERE R.külalise_nr=K.külalise_nr
GROUP BY K.külalise_nr, Ucase(K.perenimi)
HAVING Count(*) >= 3
ORDER BY Count(*) DESC, Ucase(K.perenimi);

-- See oli vale
SELECT DISTINCT K.külalise_nr, K.perenimi
FROM Külaline AS K, Reserveerimine AS R, Hotell AS H
WHERE H.linn <> 'Tallinn'
AND  K.külalise_nr=R.külalise_nr
AND  R.hotelli_nr=H.hotelli_nr
ORDER BY K.külalise_nr;

-- Õige -
SELECT külalise_nr, perenimi
FROM KÜLALINE
WHERE külalise_nr NOT IN (
SELECT külalise_nr
FROM Reserveerimine
WHERE hotelli_nr IN (SELECT hotelli_nr
FROM Hotell
WHERE linn='Tallinn'))
ORDER BY külalise_nr;

SELECT külalise_nr, perenimi
FROM Külaline
WHERE NOT EXISTS (
SELECT külalise_nr
FROM Reserveerimine
WHERE hotelli_nr IN (SELECT hotelli_nr
FROM Hotell
WHERE linn='Tallinn')
AND Külaline.külalise_nr = Reserveerimine.külalise_nr)
ORDER BY külalise_nr;


SELECT Count(*) AS arv
FROM Külaline AS K, Reserveerimine
WHERE K.külalise_nr = R.külalise_nr
INNER JOIN Hotell AS H 
ON R.hotelli_nr = H.hotelli_nr


SELECT Count(*) AS arv
FROM (Külaline AS K INNER JOIN Reserveerimine AS R ON K.külalise_nr=R.külalise_nr)
INNER JOIN Hotell AS H ON R.hotelli_nr=H.hotelli_nr
WHERE Eksam.tulemus BETWEEN 1 AND 5
GROUP BY Tudeng.tudkood, Ucase(Tudeng.perenimi);

SELECT Count (*) As arv
FROM
(SELECT DISTINCT Reserveerimine.külalise_nr
FROM Reserveerimine INNER JOIN Hotell
ON Reserveerimine.hotelli_nr = Hotell.hotelli_nr
WHERE YEAR(Reserveerimine.alguse_aeg) = YEAR(Date())
AND Hotell.nimi = 'Viru') AS tulemus;

SELECT * 
FROM (Ruum AS R
INNER JOIN Hotell AS H
ON R.hotelli_nr = H.hotelli_nr)
INNER JOIN Reserveerimine AS Re
ON H.hotelli_nr = Re.hotelli_nr))
WHERE R.ruumi_tüüp = 'Äriklassi tuba'
AND H.linn = 'Tallinn'
AND R.hind BETWEEN 100 AND 200)

