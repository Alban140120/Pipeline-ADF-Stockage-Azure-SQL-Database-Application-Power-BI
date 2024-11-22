-- CREATION DE LA VUE V_Marques

CREATE VIEW V_Marques AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY make) AS ID_Marque,
    make AS NomMarque
FROM dbo.voitures
GROUP BY make;

-- CREATION DE LA VUE V_Modeles

CREATE VIEW V_Modeles AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY model) AS ID_Modele,
    model AS NomModele
FROM dbo.voitures
GROUP BY model, cylinders;

-- CREATION DE LA VUE V_Carburant

CREATE VIEW V_Carburant AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY fuel_type) AS ID_Carburant,
    fuel_type AS NomCarburant
FROM dbo.voitures
GROUP BY fuel_type;

-- CREATION DE LA VUE V_Transmission

CREATE VIEW V_Transmission AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY transmission) AS ID_Transmission,
    transmission AS TypeTransmission
FROM dbo.voitures
GROUP BY transmission;

-- CREATION DE LA VUE V_Categorie

CREATE VIEW V_Categorie AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY class) AS ID_Categorie,
    class AS NomCategorie
FROM dbo.voitures
GROUP BY class;

-- CREATION DE LA VUE V_Drive

CREATE VIEW V_Drive AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY drive) AS ID_Drive,
    drive AS TypeMotricite
FROM dbo.voitures
GROUP BY drive;

-- CREATION DE LA VUE V_AnneeMEC

CREATE VIEW V_AnneeMEC AS
SELECT 
	ROW NUMBER() OVER (ORDER BY year) AS ID_AnneeMEC,
	year AS AnneeMEC
FROM dbo.voitures
GROUP BY year;

-- CREATION DE LA TABLE DE FAITS

CREATE VIEW Faits_Voitures AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY v.year, v.make, v.model) AS ID_Fait,
    m.ID_Marque,
    mo.ID_Modele,
    f.ID_Carburant,
    t.ID_Transmission,
    c.ID_Categorie,
    d.ID_Drive,
    v.city_mpg,
    v.highway_mpg,
    v.combination_mpg,
    v.displacement,
    v.cylinders
FROM dbo.voitures v
LEFT JOIN V_Marques m ON v.make = m.NomMarque
LEFT JOIN V_Modeles mo ON v.model = mo.NomModele
LEFT JOIN V_Carburant f ON v.fuel_type = f.NomCarburant
LEFT JOIN V_Transmission t ON v.transmission = t.TypeTransmission
LEFT JOIN V_Categorie c ON v.class = c.NomCategorie
LEFT JOIN V_Drive d ON v.drive = d.TypeMotricite;

-- CREATION DE LA CONTRAINTE UNIQUE 

ALTER TABLE dbo.voitures 
ADD CONSTRAINT UC_Voiture_AllColumns UNIQUE (city_mpg, class, combination_mpg, cylinders, displacement, drive, fuel_type, highway_mpg, make, model, transmission, year);