# Projet Data Automobiles

Analyse des données automobiles issues de l'API Auto Ninjas à l’aide d’Azure Data Factory (ADF) pour l’ETL, une base de données SQL Azure pour le stockage, et Power BI pour un reporting interactif. Le pipeline ETL est déclenché quotidiennement et exploite des dimensions normalisées pour un modèle de données robuste.

Étapes principales du projet

### 1. Extraction et chargement des données
API utilisée : [API Auto Ninjas](https://api-ninjas.com/api).

Challenge : L’API ne permet pas d’importer toutes les marques d’un coup. Solution : utilisation d’un paramètre global contenant une liste de marques, parcourue grâce à une boucle ForEach dans Azure Data Factory.

Étapes principales dans ADF :
Activité Web : Appel à l’API pour chaque marque.
Activité Copier les données : Chargement des résultats dans une base SQL Azure.
Source : Connexion à l’API (REST).
Cible : Base de données SQL Azure.

### 2. Stockage dans SQL Azure
Les données sont centralisées dans une table principale dbo.voitures.
Mise en place d’une contrainte d’unicité sur toutes les colonnes pour éviter les doublons.

## Normalisation des données
Pour garantir un modèle de données optimal, les données brutes sont organisées en vues SQL normalisées représentant les dimensions et la table de faits :

Dimensions créées

V_Marques : Nom, nationalité et logo des marques.

V_Modeles : Modèles associés à chaque marque.

V_Carburant : Types de carburants (essence, diesel, etc.).

V_Transmission : Boîtes de vitesses (automatique, manuelle).

V_Categorie : Classes de véhicules (compact, SUV, etc.).

V_Drive : Motricité des véhicules (traction, propulsion).

Table de faits

La table Faits_Voitures regroupe les indicateurs essentiels :

Consommations : en ville, sur autoroute, combinée.
Cylindrée et cylindres : directement intégrés dans la table pour simplifier les calculs.

Relations créées avec toutes les dimensions.

## Modélisation Power BI
1. Modèle sémantique
Import des données : Utilisation de la méthode Import pour des performances optimales.
Modèle en étoile : Relation entre la table de faits et les dimensions via des clés primaires/secondaires.
2. Personnalisation et enrichissement
Nouvelles colonnes sur Power Query :
Nationalité des marques : Basée sur une logique conditionnelle.
URL du logo : Pour enrichir les visuels.
Création de mesures DAX :
Exemple : Consommation moyenne par marque ou analyse de cylindres.
3. Visualisation
Graphiques interactifs : Analyse des consommations moyennes, performances des marques par classe de véhicules, etc.
Titre dynamique : Mise en place d’un titre dépendant des interactions (par exemple, "Consommation moyenne pour la marque [Marque]").

## Automatisation
Dans ADF
Trigger quotidien : Le pipeline est programmé pour s’exécuter automatiquement chaque jour.
Mise à jour automatique des données sans intervention manuelle.
Dans Power BI
Configuration de la mise à jour automatique des datasets pour synchroniser les données Power BI avec la base SQL Azure.

## Publication et partage
Application Power BI : Rapports publiés et regroupés dans une application pour faciliter le partage et l’accès.
Mise en ligne sur GitHub :
Documentation complète (README et captures d’écran des rapports Power BI).
Scripts SQL, codes d’ADF, et explications du pipeline.

## Objectifs pédagogiques
Ce projet a été conçu pour démontrer des compétences en :

Construction et automatisation d’un pipeline ETL avec Azure Data Factory.
Conception de modèles relationnels normalisés.
Création de rapports interactifs sur Power BI.
Gestion des workflows et des données dans un contexte cloud.
