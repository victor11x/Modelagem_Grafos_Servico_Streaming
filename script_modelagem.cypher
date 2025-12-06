// 1. CRIAÇÃO DE CONSTRAINTS 
// -------------------------------------------------------------------

// Nodes de Conteúdo
CREATE CONSTRAINT unique_movie_id IF NOT EXISTS FOR (m:Movie) REQUIRE m.movieId IS UNIQUE;
CREATE CONSTRAINT unique_series_id IF NOT EXISTS FOR (s:Series) REQUIRE s.seriesId IS UNIQUE;

// Nodes de Pessoas
CREATE CONSTRAINT unique_user_id IF NOT EXISTS FOR (u:User) REQUIRE u.userId IS UNIQUE;
CREATE CONSTRAINT unique_actor_id IF NOT EXISTS FOR (a:Actor) REQUIRE a.actorId IS UNIQUE;
CREATE CONSTRAINT unique_director_id IF NOT EXISTS FOR (d:Director) REQUIRE d.directorId IS UNIQUE;

// Nodes de Gênero
CREATE CONSTRAINT unique_genre_name IF NOT EXISTS FOR (g:Genre) REQUIRE g.name IS UNIQUE;

// Gêneros
MERGE (:Genre {name: 'Ação'});
MERGE (:Genre {name: 'Drama'});
MERGE (:Genre {name: 'Terror'});
MERGE (:Genre {name: 'Comédia'});
MERGE (:Genre {name: 'Sci-Fi'});

// Diretores
MERGE (:Director {directorId: 901, name: 'Denis Villeneuve'});
MERGE (:Director {directorId: 902, name: 'Jordan Peele'});
MERGE (:Director {directorId: 903, name: 'Damien Chazelle'});
MERGE (:Director {directorId: 904, name: 'Christopher Nolan'});


// Atores
MERGE (:Actor {actorId: 801, name: 'Christian Bale'});
MERGE (:Actor {actorId: 802, name: 'Emma Stone'});
MERGE (:Actor {actorId: 803, name: 'Daniel Kaluuya'});
MERGE (:Actor {actorId: 804, name: 'Jake Gyllenhaal'});


// Usuários (6 Usuários)
MERGE (:User {userId: 1001, username: 'victor', registrationDate: datetime('2025-12-01T10:00:00Z')});
MERGE (:User {userId: 1002, username: 'rangel', registrationDate: datetime('2025-12-01T10:00:00Z')});
MERGE (:User {userId: 1003, username: 'paulo',registrationDate: datetime('2025-12-01T10:00:00Z')});
MERGE (:User {userId: 1004, username: 'sarah', registrationDate: datetime('2025-12-01T10:00:00Z')});
MERGE (:User {userId: 1005, username: 'hugo', registrationDate: datetime('2025-12-01T10:00:00Z')});
MERGE (:User {userId: 1006, username: 'adria', registrationDate: datetime('2025-12-01T10:00:00Z')});

// Filmes (10 Filmes)
MERGE (:Movie {movieId: 601, title: 'Interstellar', releaseYear: 2014, duration: 169});
MERGE (:Movie {movieId: 602, title: 'The Dark Knight', releaseYear: 2008, duration: 152});
MERGE (:Movie {movieId: 603, title: 'Her', releaseYear: 2013, duration: 126});
MERGE (:Movie {movieId: 604, title: 'Get Out', releaseYear: 2017, duration: 104});
MERGE (:Movie {movieId: 605, title: 'La La Land', releaseYear: 2016, duration: 128});
MERGE (:Movie {movieId: 606, title: 'Mad Max: Fury Road', releaseYear: 2015, duration: 120});
MERGE (:Movie {movieId: 607, title: 'The Social Network', releaseYear: 2010, duration: 121});
MERGE (:Movie {movieId: 608, title: 'Parasite', releaseYear: 2019, duration: 132});
MERGE (:Movie {movieId: 609, title: 'Whiplash', releaseYear: 2014, duration: 106});
MERGE (:Movie {movieId: 610, title: 'Nope', releaseYear: 2022, duration: 131});

// Séries (3 Séries)
MERGE (:Series {seriesId: 701, title: 'Westworld', startYear: 2016, endYear: 2022});
MERGE (:Series {seriesId: 702, title: 'The Boys', startYear: 2019, endYear: 0});
MERGE (:Series {seriesId: 703, title: 'True Detective', startYear: 2014, endYear: 0});



// Relações de Gênero (IN_GENRE)

// Interstellar
MATCH (m:Movie {movieId: 601}), (g:Genre {name:'Sci-Fi'}) MERGE (m)-[:IN_GENRE]->(g);
// The Dark Knight
MATCH (m:Movie {movieId: 602}), (g:Genre {name:'Ação'}) MERGE (m)-[:IN_GENRE]->(g);
// Her
MATCH (m:Movie {movieId: 603}), (g:Genre {name:'Drama'}) MERGE (m)-[:IN_GENRE]->(g);
// Get Out
MATCH (m:Movie {movieId: 604}), (g:Genre {name:'Terror'}) MERGE (m)-[:IN_GENRE]->(g);
// La La Land
MATCH (m:Movie {movieId: 605}), (g:Genre {name:'Comédia'}) MERGE (m)-[:IN_GENRE]->(g);
// Mad Max
MATCH (m:Movie {movieId: 606}), (g:Genre {name:'Ação'}) MERGE (m)-[:IN_GENRE]->(g);
// Social Network
MATCH (m:Movie {movieId: 607}), (g:Genre {name:'Drama'}) MERGE (m)-[:IN_GENRE]->(g);
// Parasite
MATCH (m:Movie {movieId: 608}), (g:Genre {name:'Drama'}) MERGE (m)-[:IN_GENRE]->(g);
// Whiplash
MATCH (m:Movie {movieId: 609}), (g:Genre {name:'Drama'}) MERGE (m)-[:IN_GENRE]->(g);
// Nope
MATCH (m:Movie {movieId: 610}), (g:Genre {name:'Terror'}) MERGE (m)-[:IN_GENRE]->(g);

MATCH (s:Series {seriesId: 701}), (g:Genre {name:'Sci-Fi'}) MERGE (s)-[:IN_GENRE]->(g);
MATCH (s:Series {seriesId: 702}), (g:Genre {name:'Ação'}) MERGE (s)-[:IN_GENRE]->(g);
MATCH (s:Series {seriesId: 703}), (g:Genre {name:'Drama'}) MERGE (s)-[:IN_GENRE]->(g);



// Relações de Elenco e Direção (ACTED_IN, DIRECTED)

// Interstellar
MATCH (d:Director {directorId: 904}), (m:Movie {movieId: 601}) MERGE (d)-[:DIRECTED]->(m);

// The Dark Knight
MATCH (d:Director {directorId: 904}), (m:Movie {movieId: 602}) MERGE (d)-[:DIRECTED]->(m);
MATCH (a:Actor {actorId: 801}), (m:Movie {movieId: 602}) MERGE (a)-[:ACTED_IN]->(m);

// La La Land
MATCH (d:Director {directorId: 903}), (m:Movie {movieId: 605}) MERGE (d)-[:DIRECTED]->(m);
MATCH (a:Actor {actorId: 802}), (m:Movie {movieId: 605}) MERGE (a)-[:ACTED_IN]->(m);

// Get Out
MATCH (d:Director {directorId: 902}), (m:Movie {movieId: 604}) MERGE (d)-[:DIRECTED]->(m);
MATCH (a:Actor {actorId: 803}), (m:Movie {movieId: 604}) MERGE (a)-[:ACTED_IN]->(m);

// Nightcrawler (Jake → aplica em Social Network como exemplo)
MATCH (a:Actor {actorId: 804}), (m:Movie {movieId: 607}) MERGE (a)-[:ACTED_IN]->(m);


// Relações de Consumo (WATCHED) - Incluindo propriedade de `rating` e `watchedOn`
MATCH (u:User {userId: 1001}), (m:Movie {movieId: 601}) MERGE (u)-[:WATCHED {rating: 5}]->(m);
MATCH (u:User {userId: 1001}), (s:Series {seriesId: 701}) MERGE (u)-[:WATCHED {rating: 4}]->(s);

MATCH (u:User {userId: 1002}), (m:Movie {movieId: 606}) MERGE (u)-[:WATCHED {rating: 5}]->(m);

MATCH (u:User {userId: 1003}), (m:Movie {movieId: 608}) MERGE (u)-[:WATCHED {rating: 5}]->(m);
MATCH (u:User {userId: 1003}), (s:Series {seriesId: 702}) MERGE (u)-[:WATCHED {rating: 4}]->(s);

MATCH (u:User {userId: 1004}), (m:Movie {movieId: 603}) MERGE (u)-[:WATCHED {rating: 4}]->(m);

MATCH (u:User {userId: 1005}), (m:Movie {movieId: 601}) MERGE (u)-[:WATCHED {rating: 5}]->(m);
MATCH (u:User {userId: 1005}), (m:Movie {movieId: 610}) MERGE (u)-[:WATCHED {rating: 3}]->(m);

MATCH (u:User {userId: 1006}), (m:Movie {movieId: 605}) MERGE (u)-[:WATCHED {rating: 4}]->(m);
