ALTER TABLE ratings
ADD CONSTRAINT ratings_pk
PRIMARY KEY (user_id,movie_id)

ALTER TABLE hasGenre
ADD CONSTRAINT hasGenre_pk
PRIMARY KEY (movie_id, genre_id)

ALTER TABLE hasProductioncompany
ADD CONSTRAINT hasPC_pk
PRIMARY KEY (movie_id, pc_id)

ALTER TABLE hasKeyword
ADD CONSTRAINT hasKeyword_pk
PRIMARY KEY (movie_id, keyword_id)

ALTER TABLE belongsTocollection
ADD CONSTRAINT belongsTocollection_pk
PRIMARY KEY (movie_id, collection_id)