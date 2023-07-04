/*Nom des lieux qui finissent par 'um'*/
SELECT * FROM lieu WHERE nom_lieu LIKE '%um';

/*Nombre de personnages par lieu (trié par nombre de personnages décroissant)*/
SELECT COUNT(nom_personnage) AS nbPersonnages, nom_lieu  
FROM personnage p
INNER JOIN lieu l ON p.id_lieu = l.id_lieu

GROUP BY  l.id_lieu

ORDER BY  nbPersonnages DESC

/*Nom des personnages + spécialité + adresse et lieu d'habitation, triés par lieu puis par nom de personnage*/
SELECT nom_personnage,nom_specialite,adresse_personnage,nom_lieu
FROM personnage p
INNER JOIN specialite s ON p.id_specialite =s.id_specialite
INNER JOIN lieu l ON p.id_lieu= l.id_lieu
ORDER BY l.nom_lieu ASC, p.nom_personnage ASC

/*Nom des spécialités avec nombre de personnages par spécialité (trié par nombre de personnages décroissant).*/
SELECT nom_specialite, COUNT(nom_personnage) AS nbPersonnages
FROM personnage p
INNER JOIN specialite s on p.id_specialite = s.id_specialite
GROUP BY s.id_specialite
ORDER BY nbPersonnages DESC

/*Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa).*/
/*Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa)*/
SELECT nom_bataille, DATE_FORMAT(date_bataille,"%d %m %Y")AS dateB, nom_lieu
FROM bataille b 
INNER JOIN lieu l ON b.id_lieu = l.id_lieu
ORDER BY  date_bataille DESC  