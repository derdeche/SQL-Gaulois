/*1-Nom des lieux qui finissent par 'um'*/
SELECT * FROM lieu WHERE nom_lieu LIKE '%um';

/*2-Nombre de personnages par lieu (trié par nombre de personnages décroissant)*/
SELECT COUNT(nom_personnage) AS nbPersonnages, nom_lieu  
FROM personnage p
INNER JOIN lieu l ON p.id_lieu = l.id_lieu

GROUP BY  l.id_lieu

ORDER BY  nbPersonnages DESC

/*3-Nom des personnages + spécialité + adresse et lieu d'habitation, triés par lieu puis par nom de personnage*/
SELECT nom_personnage,nom_specialite,adresse_personnage,nom_lieu
FROM personnage p
INNER JOIN specialite s ON p.id_specialite =s.id_specialite
INNER JOIN lieu l ON p.id_lieu= l.id_lieu
ORDER BY l.nom_lieu ASC, p.nom_personnage ASC

/*4-Nom des spécialités avec nombre de personnages par spécialité (trié par nombre de personnages décroissant).*/
SELECT nom_specialite, COUNT(nom_personnage) AS nbPersonnages
FROM personnage p
INNER JOIN specialite s on p.id_specialite = s.id_specialite
GROUP BY s.id_specialite
ORDER BY nbPersonnages DESC

/*5-Nom, date et lieu des batailles, classées de la plus récente à la plus ancienne (dates affichées au format jj/mm/aaaa)*/
SELECT nom_bataille, DATE_FORMAT(date_bataille,"%d %m %Y")AS dateB, nom_lieu
FROM bataille b 
INNER JOIN lieu l ON b.id_lieu = l.id_lieu
ORDER BY  date_bataille DESC  

/*6-Nom des potions + coût de réalisation de la potion (trié par coût décroissant)*/
 SELECT nom_potion, SUM(cout_ingredient * qte) AS cout 
 FROM potion p
 INNER JOIN composer c ON p.id_potion = c.id_potion
 INNER JOIN ingredient i ON c.id_ingredient = i.id_ingredient
 GROUP BY p.id_potion 
 ORDER BY cout DESC

 /*7-Nom des ingrédients + coût + quantité de chaque ingrédient qui composent la potion 'Santé'*/
SELECT nom_ingredient, cout_ingredient, qte
FROM ingredient i
INNER JOIN composer c ON i.id_ingredient = c.id_ingredient 
INNER JOIN potion p ON c.id_potion= p.id_potion
WHERE nom_potion = 'Santé'


/*8-Nom du ou des personnages qui ont pris le plus de casques dans la bataille 'Bataille du village gaulois'*/
SELECT nom_personnage, SUM(qte) AS nbCasque
FROM personnage p
INNER JOIN prendre_casque  pR ON p.id_personnage = pR.id_personnage
WHERE pR.id_bataille = 1
GROUP BY p.id_personnage

HAVING nbCasque >= ALL (
SELECT SUM(pR.qte)
FROM personnage,prendre_casque pR
WHERE personnage.id_personnage= pR.id_personnage
AND pR.id_bataille = 1
GROUP BY personnage.id_personnage
)

/*9-Nom des personnages et leur quantité de potion bue (en les classant du plus grand buveur au plus petit)*/
SELECT nom_personnage, SUM(dose_boire) AS quantitéConsom
FROM personnage p
INNER JOIN boire b ON p.id_personnage = b.id_personnage
GROUP BY p.id_personnage
ORDER BY quantitéConsom DESC

/*10-Nom de la bataille où le nombre de casques pris a été le plus important*/
SELECT nom_bataille, SUM(qte) AS nCasque
FROM bataille b
INNER JOIN prendre_casque pR ON b.id_bataille= pR.id_bataille
GROUP BY b.id_bataille

HAVING nCasque >= ALL 
(
SELECT SUM(prendre_casque.qte)
FROM bataille,prendre_casque
WHERE bataille.id_bataille = prendre_casque.id_bataille
GROUP BY bataille.id_bataille
)

/*11-Combien existe-t-il de casques de chaque type et quel est leur coût total ? (classés par nombre décroissant)*/
SELECT nom_type_casque, COUNT(c.nom_casque) AS nb_casques, SUM(c.cout_casque) AS cout
FROM casque c 
INNER JOIN type_casque t ON c.id_type_casque= t.id_type_casque
GROUP BY t.id_type_casque
ORDER BY nb_casques DESC

/*12-Nom des potions dont un des ingrédients est le poisson frais.*/
SELECT nom_potion
FROM potion p
INNER JOIN composer c ON p.id_potion= c.id_potion
INNER JOIN ingredient i ON c.id_ingredient= i.id_ingredient
WHERE nom_ingredient = 'Poisson frais'
GROUP BY p.nom_potion 

/*14-Nom des personnages qui n'ont jamais bu aucune potion*/

SELECT nom_personnage
FROM personnage p
INNER JOIN boire b ON p.id_personnage = b.id_personnage
WHERE b.dose_boire = 0

/*15-Nom du / des personnages qui n'ont pas le droit de boire de la potion 'Magique'*/
SELECT nom_personnage
FROM personnage p
INNER JOIN autoriser_boire aT ON  p.id_personnage = aT.id_personnage
WHERE aT.id_potion != 1

/*-------------En écrivant toujours des requêtes SQL, modifiez la base de données comme suit :----------------*/

/*A. Ajoutez le personnage suivant : Champdeblix, agriculteur résidant à la ferme Hantassion de Rotomagus*/

INSERT INTO personnage (nom_personnage, id_specialite, id_lieu, adresse_personnage)
VALUES ('Champdeblix',12,6,'Hantassion')

/*B.Autorisez Bonemine à boire de la potion magique, elle est jalouse d'Iélosubmarine...*/
INSERT INTO autoriser_boire (id_personnage, id_potion)
VALUES (12,1)

/*C.Supprimez les casques grecs qui n'ont jamais été pris lors d'une bataille */
DELETE FROM casque c
WHERE c.id_type_casque = 2 
AND c.id_casque NOT IN (SELECT c.id_casque FROM prendre_casque)

/*D.Modifiez l'adresse de Zérozérosix : il a été mis en prison à Condate*/
UPDATE personnage p
SET id_lieu = '9', p.adresse_personnage = 'Prison'
WHERE p.nom_personnage = 'Zérozérosix'

/*E.La potion 'Soupe' ne doit plus contenir de persil*/
DELETE FROM composer c
WHERE c.id_potion = 9
AND c.id_ingredient = 19

/*F.Obélix s'est trompé : ce sont 42 casques Weisenau, et non Ostrogoths, qu'il a pris lors de la bataille 'Attaque de la banque postale'. Corrigez son erreur !*/
UPDATE prendre_casque pR
SET pR.id_casque='10'
WHERE pR.id_bataille='9'

