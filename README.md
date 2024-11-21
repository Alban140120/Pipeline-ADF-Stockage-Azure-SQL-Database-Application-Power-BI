# Pipeline et Reporting Automobile : Extraction, Transformation et Visualisation
Ce projet met en œuvre un pipeline de données performant et un tableau de bord Power BI interactif pour analyser la consommation de véhicules par marque, modèle, et type de carburant. Il combine des outils d'intégration de données via Azure Data Factory (ADF), une base de données SQL sur Azure, et une visualisation avancée avec Power BI.

## Présentation du projet
API utilisée : API d'analyse automobile pour récupérer les données de consommation des véhicules (carburant, catégories, modèles, etc.).
Objectif : Créer une solution automatisée permettant d’exploiter les données issues de l'API pour un reporting interactif et régulièrement mis à jour.
Pipeline de données avec Azure Data Factory
Structure du pipeline

## Paramètre global :

Les marques de véhicules proposées par l'API ne sont pas directement récupérables en une seule requête.
Création d’un paramètre global listant toutes les marques à exploiter (["bmw","ferrari","porsche","fiat","audi","toyota","mercedes","honda","ford","volkswagen","lexus","lamborghini","land rover","jeep","opel","dacia","citroën","seat","skoda","chrysler","dodge","nissan","mitsubishi","jaguar","tesla","kia","chevrolet","mazda","smart","subaru","cadillac","alpine","aston martin","bentley","lotus","lancia","volvo"]).

## Activités du pipeline :

Activité ForEach : Boucle parcourant chaque marque pour exécuter deux tâches principales :
Appel API avec activité Web : Récupère les données JSON de l’API pour une marque donnée.
Copie des données avec l’activité Copier les données : Enregistre les résultats dans une base de données Azure SQL.
Automatisation quotidienne :

Mise en place d'un trigger planifié pour exécuter le pipeline chaque jour.
Conception technique
Linked Services : Configuration des connexions REST (API) et SQL (Azure Database).
Dataset dynamique : Utilisation de paramètres pour générer les URLs et stocker les données de manière flexible.
Gestion des duplications :
Ajout d’une contrainte d’intégrité SQL pour éviter les doublons dans la base.
Utilisation du mode Upsert dans l’activité Copier pour insérer ou mettre à jour les données existantes.
Modèle de données SQL
Structure
À partir de la table principale dbo.voitures, les données ont été normalisées dans un modèle en étoile avec les dimensions suivantes :

V_Marques : Contient les marques des véhicules, enrichie avec :
La nationalité des marques.
Une URL pour afficher les logos dans Power BI.
V_Modeles : Les modèles de véhicules, avec leurs années et leur nombre de cylindres.
V_Carburant : Type de carburant (essence, diesel, etc.).
V_Transmission : Type de transmission (manuelle, automatique…).
V_Categorie : Classe des véhicules (SUV, compact…).
V_Drive : Type de motricité (4x4, propulsion…).
Table de fait
La table de fait regroupe :

Les identifiants des dimensions (via des jointures avec la table de référence).
Les mesures d’analyse : consommation en ville, sur autoroute, consommation combinée, cylindrée, etc.
Reporting avec Power BI
Importation des données
Mode Import : Toutes les données sont importées pour une meilleure performance.
Création d’un modèle sémantique Power BI basé sur le modèle en étoile conçu sur Azure.
Enrichissements avec Power Query
Colonnes supplémentaires dans la dimension V_Marques :
Nationalité des marques : Ajoutée manuellement en fonction des pays d'origine.
Logo des marques : Ajout d'une URL pour inclure les logos dans les visualisations.
Visualisations
Tableau de bord interactif :
Analyse de la consommation moyenne par marque, modèle, carburant, et catégorie.
Intégration des logos pour une expérience utilisateur améliorée.
Info-bulles dynamiques personnalisées, affichant des informations détaillées comme le titre : "Consommation moyenne sur 3 parcours avec la marque [Marque]".
Automatisation et partage
Mise à jour automatique : Le tableau de bord est rafraîchi quotidiennement grâce à la mise à jour des données dans Azure.
Publication : Rapport publié sur un espace de travail Power BI dédié, avec accès configuré via une application Power BI.
Organisation des fichiers sur GitHub
Dossier Azure : Scripts SQL, configurations ADF (JSON des pipelines, Linked Services, etc.).
Dossier PowerBI : Captures d’écran des pages du rapport, export du fichier .pbix.
README.md : Documentation complète pour comprendre et reproduire le projet.
Points forts de ce projet
Mise en place d’une chaîne de traitement automatisée complète, de l’API à l’analyse.
Approche modulaire et évolutive grâce à la normalisation des données.
Expérience utilisateur enrichie via Power BI, avec des visuels interactifs et des données pertinentes.
