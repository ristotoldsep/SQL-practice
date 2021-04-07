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

-- 31.03 praktikum
-- Insert into kustutab vana tabeli = halb!!!
SELECT aine_kood, nimetus INTO Aktiivne_oppeaine
FROM Aine
WHERE aine_kood IN (SELECT aine
FROM Oppimine
WHERE oppim_algus>=#2000-09-01#);

/* 3. Lisada tabelisse "Aktiivne_oppeaine" kõigi selliste õppeainete andmed, millel on mõni 
õppimine alanud 1. septembril 2000 või hiljem. Sellesse tabelisse tuleb lisada õppeaine nimetus ja kood, 
kusjuures iga lisatava õppeaine andmed tuleb lisada ainult üks kord.  */
INSERT INTO Aktiivne_oppeaine (aine_kood, nimetus)
SELECT aine_kood, nimetus
FROM Aine
WHERE aine_kood IN (SELECT aine
FROM Oppimine
WHERE oppim_algus>=#2000-09-01#);

/* 6. Kustutada tabelist "Tudeng" tudengid , kellel on rohkem kui kaks negatiivsete tulemustega eksamit (hinne 0) 
ja kelle kõik õppimised on lõppenud eksamiga (eksami tulemuseks võib olla mistahes hinne). 
Juhul kui kasutate tabelite ühendamist (joinimist), 
tuleb tabelite ühendamise (joini) tingimused kirjutada WHERE klauslisse.  */
SELECT tudeng, Count(*) AS arv
FROM Eksam AS E, Oppimine AS O
WHERE tulemus=0
AND E.oppimine=O.oppimine
GROUP BY tudeng
HAVING Count(*)>2;

-- kellel pole eksamit tehtud
SELECT tudeng
FROM Oppimine LEFT JOIN Eksam ON Oppimine.oppimine=Eksam.oppimine
WHERE Eksam.oppimine IS NULL;

SELECT Round(toad.arv_tubadega*100/iif(koik.arv_kokku=0, NULL, koik.arv_kokku),1) AS protsent
FROM (SELECT Count(*) AS arv_tubadega
FROM Hotell
WHERE linn='Tallinn'
AND hotelli_nr IN (SELECT hotelli_nr
FROM Ruum
WHERE ruumi_tüüp='Äriklassi tuba')) AS toad,
(SELECT Count(*) AS arv_kokku
FROM Hotell
WHERE linn='Tallinn') AS koik;

SELECT Round(reserveerimised.res_arv*100/iif(koik.arv_kokku=0, NULL, koik.arv_kokku),1) AS protsent
FROM (SELECT Count(*) AS res_arv
FROM Reserveerimine AS Re
WHERE Year(alguse_aeg)=2004
AND hotelli_nr IN (SELECT hotelli_nr
FROM Hotell AS H
WHERE H.linn = 'Tallinn')) AS reserveerimised,
(SELECT Count(*) AS arv_kokku
FROM Hotell AS H
WHERE H.linn='Tallinn') AS koik;

SELECT Round(toad.arv_tubadega*100/iif(koik.arv_kokku=0, NULL, koik.arv_kokku),1) AS protsent
FROM (SELECT Count(*) AS arv_tubadega
FROM Hotell
WHERE linn='Tallinn'
AND hotelli_nr IN (SELECT hotelli_nr
FROM Ruum
WHERE ruumi_tüüp='Äriklassi tuba')) AS toad,
(SELECT Count(*) AS arv_kokku
FROM Hotell
WHERE linn='Tallinn') AS koik;

SELECT Count(*) AS res_arv
FROM Reserveerimine AS Re, Hotell AS H
WHERE Re.hotelli_nr = H.hotelli_nr
AND H.linn = 'Tallinn'
AND Year(alguse_aeg)=2004

INSERT INTO Ruum_koopia ( ruumi_nr, hotelli_nr, ruumi_tüüp, hind )
SELECT Ruum.ruumi_nr, Ruum.hotelli_nr, Ruum.ruumi_tüüp, Ruum.hind
FROM Ruum
WHERE (((Ruum.[ruumi_nr]) In (SELECT ruumi_nr
FROM Ruum
WHERE (Ruum.hind BETWEEN 100 AND 200)
OR (Ruum.hind>400)))
AND Ruum.ruumi_tüüp='Äriklassi tuba');

-- ÕIGE ül 3
SELECT Round(Hotellide_arv.Hot_arv*100/iif(koik.arv_kokku=0, NULL, koik.arv_kokku),1) AS protsent
FROM (SELECT Count(*) AS Hot_arv
FROM (SELECT H.hotelli_nr
FROM Reserveerimine AS Re, Hotell AS H
WHERE Re.hotelli_nr=H.hotelli_nr
AND Year(alguse_aeg)=2004
AND H.linn='Tallinn'
GROUP BY H.hotelli_nr
HAVING Count(*)>=1)) AS Hotellide_arv,
(SELECT Count(*) AS arv_kokku
FROM Hotell
WHERE linn='Tallinn') AS koik;

-- 07.04 praktikum
/* 1. Lisada tabelisse "Tudeng" veerg nimega "kommentaar" (tekstiväli, võimaldab sisestada 
kuni 150 tähemärki), mittekohustuslik veerg. Lisaks kirjutage lause, mis kustutab veeru "kommentaar"
tabelist "Tudeng". (15) */
ALTER TABLE Tudeng
ADD COLUMN kommentaar VARCHAR(150);

-- Kustuta veerg tabelist
ALTER TABLE Tudeng
DROP COLUMN kommentaar;

/* 2. Lisada tudengitele, kelle vastuvõtu aeg on enne  1995. aastat ja kelle õppesuuna tähise 
kaks esimest tähte on "LZ", kommentaar "Peab varsti lõpetama!". Koostage lause nii, et kui veerus 
"kommentaar" on juba väärtus olemas, siis lisatakse see tekst olemasoleva teksti algusesse. (15) */ /* Trim eemaldab tühikud, & concatenateb stringid */
UPDATE Tudeng SET kommentaar=Trim('Peab varsti lõpetama!' & kommentaar)
WHERE Year(vastuvotu_aeg) < 1995
AND oppesuund LIKE 'LZ%';

/* 4) Kirjutage lause, millega kustutate kõik read tabelist Külaline_koopia.
Kirjutage lause, millega deklareerite tabelis Külaline_koopia primaarvõtme (külalise_nr). */
-- TRUNCATE TABLE Külaline_koopia; EI SOBI accessis
DELETE FROM Külaline_koopia;

ALTER TABLE Külaline_koopia 
ADD CONSTRAINT pk_kylaline PRIMARY KEY (külalise_nr);

/* 4) Lisage tabelisse Külaline_koopia andmed kõikide nende külaliste kohta, kes pole teinud mitte
ühtegi reserveerimist Tartu hotellides. (1) */
INSERT INTO Külaline_koopia (külalise_nr, eesnimi, perenimi, aadress)
SELECT külalise_nr, eesnimi, perenimi, aadress
FROM Külaline
WHERE külalise_nr NOT IN (
SELECT külalise_nr
FROM Reserveerimine
WHERE hotelli_nr IN (SELECT hotelli_nr
FROM Hotell
WHERE linn='Tartu'));

/* 1.
Looge SELECT ... INTO lause abil koopia tabelist Külaline nime all Külaline_koopia.
Kandke selle lausega koopiasse üle vaid need külalised, 
kellel ei ole ühtegi seotud käesoleval aastal alanud (tuleb leida dünaamiliselt) reserveerimist.
Vihje: kasutage funktsioone Year ja Date.

Deklareerige tabelis Külaline_koopia primaarvõti (külalise_nr) 
Primaarvõtme kitsenduse nimi: pk_kylaline_koopia.

Kustutage tabelist Külaline_koopia veerg perenimi (muutke tabeli struktuuri).

Kustutage tabel Külaline_koopia. (1) */
SELECT * INTO Külaline_koopia
FROM Külaline AS K
WHERE K.külalise_nr NOT IN (SELECT DISTINCT külalise_nr
FROM Reserveerimine as R
WHERE Year(R.alguse_aeg) = Year(Date()));

ALTER TABLE Külaline_koopia
ADD CONSTRAINT pk_kylaline_koopia PRIMARY KEY (külalise_nr);

ALTER TABLE Külaline_koopia 
DROP COLUMN perenimi;

DROP TABLE Külaline_koopia;

/* 3.
Leidke külalised, kes on teinud kõige pikema ja kõige lühema reserveerimise. 
Näidake külalise numbrit, perenime, reserveerimise pikkust 
ning neljandas veerus (nimega liik) vastavalt kommentaari "kõige lühem reserveerimine" ja 
"kõige pikem reserveerimine". 
Reserveerimise pikkus on selle alguse ja lõpu aja vaheline intervall. (1) */
SELECT K.külalise_nr, perenimi, (R.lopu_aeg-R.alguse_aeg) AS res_pikkus, 'Kõige lühem reserveerimine'  AS liik
FROM Külaline AS K, Reserveerimine AS R
WHERE K.külalise_nr = R.külalise_nr
AND R.lopu_aeg-R.alguse_aeg = (
SELECT MIN(R.lopu_aeg-R.alguse_aeg)
FROM Reserveerimine R)
UNION
SELECT K.külalise_nr, perenimi, (R.lopu_aeg-R.alguse_aeg) AS res_pikkus, 'Kõige pikem reserveerimine'  AS liik
FROM Külaline AS K, Reserveerimine AS R
WHERE K.külalise_nr = R.külalise_nr
AND R.lopu_aeg-R.alguse_aeg = (
SELECT MAX(R.lopu_aeg-R.alguse_aeg)
FROM Reserveerimine R);

/* 2.
Looge SELECT ... INTO lause abil koopia tabelist Külaline nime all Külaline_koopia.

Kustutage tabelis Külaline_koopia selliste külaliste aadressid, 
kellel on kokku rohkem kui viis reserveerimist, aga kes pole viimase 1000 päeva 
jooksul kordagi alustanud reserveerimist hotellis nimega "Viru". (1) */
 SELECT *
FROM Külaline
WHERE Külaline.külalise_nr IN 
(SELECT Külalise_nr
FROM Reserveerimine INNER JOIN Hotell ON
Reserveerimine.hotelli_nr = Hotell.Hotelli_nr
WHERE Reserveerimine.alguse_aeg > DATEADD("D", -1000, Date())
AND Hotell.nimi <> 'Viru')