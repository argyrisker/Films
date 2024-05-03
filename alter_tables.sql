--primary key
--ratings
ALTER TABLE ratings
ADD CONSTRAINT ratings_pk
PRIMARY KEY (user_id,movie_id);
ALTER TABLE ratings
 ALTER COLUMN user_id int NOT NULL;
ALTER TABLE ratings
 ALTER COLUMN movie_id int NOT NULL;

--collection
ALTER TABLE collection
ADD CONSTRAINT collection_pk
PRIMARY KEY (id);

--Keywords
ALTER TABLE Keywords
ADD CONSTRAINT keywords_pk
PRIMARY KEY (id);

--movie
ALTER TABLE movie
ADD CONSTRAINT movie_pk
PRIMARY KEY (id);

--genre
ALTER TABLE genre
ADD CONSTRAINT genre_pk
PRIMARY KEY (id);

--movie_cast
ALTER TABLE movie_cast
ADD CONSTRAINT moviecast_pk
PRIMARY KEY (cid);

--movie_crew
ALTER TABLE movie_crew
ADD CONSTRAINT moviecrew_pk
PRIMARY KEY (cid);

--productioncompany
ALTER TABLE productioncompany
ADD CONSTRAINT productioncompany_pk
PRIMARY KEY (id);

--Foreign key
--ratings
ALTER TABLE ratings
 ADD CONSTRAINT FK_movieid FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

--bellongsTocollection
ALTER TABLE belongsTocollection
 ADD CONSTRAINT FK_movied FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

ALTER TABLE belongsTocollection
 ADD CONSTRAINT FK_collectioned FOREIGN
KEY (collection_id)
 REFERENCES collection(id);

 --hasGenre
 ALTER TABLE hasGenre
 ADD CONSTRAINT FK_genreid FOREIGN
KEY (genre_id)
 REFERENCES genre(id);

ALTER TABLE hasGenre
 ADD CONSTRAINT FK_genremovieid FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

--hasProductioncompany
ALTER TABLE hasProductioncompany
 ADD CONSTRAINT FK_pcid FOREIGN
KEY (pc_id)
 REFERENCES productioncompany(id);

ALTER TABLE hasProductioncompany
 ADD CONSTRAINT FK_productionmovied FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

 --movie_cast
 ALTER TABLE movie_cast
 ADD CONSTRAINT FK_castmovieid FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

--movie_crew
ALTER TABLE movie_crew
 ADD CONSTRAINT FK_crewmovieid FOREIGN
KEY (movie_id)
 REFERENCES movie(id);

--hasKeyword
ALTER TABLE hasKeyword
 ADD CONSTRAINT FK_keywordid FOREIGN
KEY (keyword_id)
 REFERENCES Keywords(id);
