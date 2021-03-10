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


SELECT * 
FROM Oppimine
WHERE Year(oppimis_algus) = 1998;