/*Nom des lieux qui finissent par 'um'*/
SELECT * FROM lieu WHERE nom_lieu LIKE '%um';

/*Nombre de personnages par lieu (trié par nombre de personnages décroissant)*/
SELECT COUNT(id_personnage), id_lieu  FROM personnage
GROUP BY id_lieu
ORDER BY  COUNT(id_personnage) DESC
