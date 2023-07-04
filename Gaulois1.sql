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

/*Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa)*/
SELECT nom_bataille, DATE_FORMAT(date_bataille,"%d %m %Y")AS dateB, nom_lieu
FROM bataille b 
INNER JOIN lieu l ON b.id_lieu = l.id_lieu
ORDER BY  date_bataille DESC  

/*Nom des potions + coût de réalisation de la potion (trié par coût décroissant)*/
 SELECT nom_potion, SUM(cout_ingredient * qte) AS cout 
 FROM potion p
 INNER JOIN composer c ON p.id_potion = c.id_potion
 INNER JOIN ingredient i ON c.id_ingredient = i.id_ingredient
 GROUP BY p.id_potion 
 ORDER BY cout DESC

 /*Nom des ingrédients + coût + quantité de chaque ingrédient qui composent la potion 'Santé'*/
SELECT nom_ingredient, cout_ingredient, qte
FROM ingredient i
INNER JOIN composer c ON i.id_ingredient = c.id_ingredient 
INNER JOIN potion p ON c.id_potion= p.id_potion
WHERE nom_potion = 'Santé'

/*Combien existe-t-il de casques de chaque type et quel est leur coût total ? (classés par nombre décroissant)*/

SELECT nom_type_casque, SUM(t.id_type_casque) AS total, SUM(c.cout_casque) AS cout
FROM casque c 
INNER JOIN type_casque t ON c.id_type_casque= t.id_type_casque
GROUP BY t.id_type_casque
ORDER BY cout DESC