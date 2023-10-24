/**
 * Opgave 1 (3 punten):
 * Geef alle acteurs die geboren zijn in het jaar 1974.
 * Sorteer op naam van de acteur.
 */

 select naam
 from Film.Acteur
 WHERE DATEPART(YEAR, geboortedatum) = 1974;



/**
 * Opgave 2 (3 punten):
 * Geef van alle films die een releasedatum hebben en die in USA uitgebracht zijn de titel in hoofdletters
 * en de releasedatum
 */
 select UPPER(titel) AS naam, releasedatum
 from Film.Film
 where releasedatum IS NOT NULL
 AND land LIKE '%USA%';


/**
 * Opgave 3 (4 punten):
 * Toon de volgende informatie van alle films met genre “Romance”:
 *  • De URL van de film op IMDB. Dat is het IMDB-nummer uit de tabel met ervoor https://www.imdb.com/title/
 *  • De titel van de film
 *  • Hoe oud de film is:
 *	    - Ouder dan 1997: “zeer oude film”
 *      - Tussen 1998 en 2012: “oude film”
 *      - Na 2012: “jongere film”
 * Sorteer op naam van de film.
 */
 select		CONCAT('https://www.imdb.com/title/', imdbNr) as 'url film',
			titel,
			CASE 
				WHEN releasedatum >= '1997-12-31'
					THEN 'oude film'
				WHEN releasedatum BETWEEN '1998-01-01' AND '2012-01-01'
					THEN 'oude film'
				ELSE 'jongere film'
				END AS 'ouderdom'
 from Film.Film INNER JOIN Film.Filmgenre ON Film.Film.id = Film.Filmgenre.filmId
 where genreId = 3
 order by titel



/**
 * Opgave 4 (4 punten):
 * Je vriend(in) argumenteert dat Morgan Freeman de meest universele
 * acteur is. Geef alle genres van films waarin hij ooit geacteerd
 * heeft.
 */
 select Film.Genre.naam
 from Film.Filmgenre INNER JOIN Film.Film ON Film.Filmgenre.filmId = Film.Film.id
	INNER JOIN Film.Medewerker ON Film.Medewerker.filmId = Film.Film.id
	INNER JOIN Film.Acteur ON Film.Medewerker.acteurId = Film.Acteur.id
	INNER JOIN Film.Genre ON Film.FilmGenre.genreId = Film.Genre.id
where Film.Acteur.naam = 'Morgan Freeman'

/**
 * Opgave 5a (2 punten):
 * Maak een tabel ‘Medewerkertype’ aan met de kolommen
 * id (primary key, autonummering), type (varchar(20), not null) in het schema Film.
 */
create table Film.Medewerkertype
(
	id int primary key identity(1,1),
	type varchar(20) NOT NULL
);


/**
 * Opgave 5b (1 punt):
 * Voeg in de tabel medewerkertype 2 records toe
 */
insert into Film.Medewerkertype (type)
values
	('Regisseur'),
	('Productieleider');

/**
 * Opgave 5c (3 punten):
 * Voeg aan de tabel Medewerker een FK 'typeId'(NNA, DTC) toe.  Deze kolom is een FK naar
 * de tabel medewerkertype.
 */
alter table Film.Medewerker
add typeId int default 1 NOT NULL;

alter table Film.Medewerker
add constraint FK_typeId
foreign key (typeId)
references Film.Medewerkertype (id)
on delete cascade;

alter table Film.Medewerker
drop constraint FK_typeId