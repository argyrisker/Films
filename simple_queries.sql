/*
1
"Βρες τους τίτλους των ταινιών στις οποίες έπαιξε η Madonna"
Output: 17 rows
*/
SELECT title 
FROM dbo.movie
INNER JOIN dbo.movie_cast ON dbo.movie.id = dbo.movie_cast.movie_id
WHERE dbo.movie_cast.name='Madonna'

/*
2
"Βρες τους τίτλους των ταινιών και τους σκηνοθέτες τους, οι οποίες έχουν βαθμολογία ίση με 50, που είναι η ανώτερη"
Output: 779 rows
*/
SELECT DISTINCT dbo.movie_crew.name, dbo.movie.title 
FROM dbo.movie_crew
INNER JOIN dbo.movie ON dbo.movie.id=dbo.movie_crew.movie_id
WHERE dbo.movie_crew.movie_id in (SELECT DISTINCT movie_id
        FROM dbo.ratings
        WHERE dbo.ratings.rating=50) AND dbo.movie_crew.job='DIRECTOR'

/*
3
"Βρες τους τίτλους και του γνήσιους τίτλους των ταινιών που έχουν ως λέξη κλειδί την italy"
Output: 43 rows
*/
SELECT dbo.Keywords.name , dbo.movie.title, dbo.movie.original_title
FROM dbo.Keywords
FULL OUTER JOIN dbo.hasKeyword ON dbo.hasKeyword.keyword_id = dbo.Keywords.id
INNER JOIN dbo.movie ON dbo.movie.id = dbo.hasKeyword.movie_id
WHERE dbo.Keywords.name='italy' 


/*
4
"Βρες τις 10 εταιρίες παραγωγής που έχουν κάνει τις περισσότερες ταινίες στην κατηγορία "Action", για κάθε εταιρία βρες και το πλήθος των ταινιών στο είδος αυτό
Output: 10 rows
*/
SELECT TOP(10) dbo.productioncompany.name , COUNT(dbo.movie.id) AS action_movie_count
FROM dbo.productioncompany 
FULL OUTER JOIN dbo.hasproductioncompany ON dbo.productioncompany.id = dbo.hasProductioncompany.pc_id
FULL OUTER JOIN dbo.movie ON dbo.hasProductioncompany.movie_id = dbo.movie.id
FULL OUTER JOIN dbo.hasGenre ON dbo.movie.id = dbo.hasGenre.movie_id
FULL OUTER JOIN dbo.genre ON dbo.hasGenre.genre_id = dbo.genre.id
WHERE dbo.genre.name = 'Action' AND dbo.productioncompany.name  is not NULL
GROUP BY dbo.productioncompany.name
ORDER BY action_movie_count DESC


/*
5
"Βρες τους τίτλους και τα έσοδα των 5 ταινιών που έχουν τα υψηλότερα έσοδα από 01-01-2024 έως 01-01-2024"
Output: 5 rows
*/
SELECT TOP(5) dbo.movie.title AS title, dbo.movie.revenue  AS revenue
FROM dbo.movie
INNER JOIN dbo.hasGenre ON dbo.hasGenre.movie_id=dbo.movie.id
INNER JOIN dbo.genre ON dbo.hasGenre.genre_id=dbo.genre.id
WHERE dbo.genre.name='Action' and dbo.movie.release_date BETWEEN '2000-01-01' AND '2024-01-01'
ORDER BY revenue DESC

/*
6
"Βρες τον τίτλο και την δημοσιότητα της πιο διάσημης ταινίας στο dataset στο genre 'Action' "
Output: 1 row
*/
SELECT dbo.movie.title AS most_popular_Action_movie, dbo.movie.popularity 
FROM dbo.movie 
INNER JOIN dbo.hasGenre  ON dbo.movie.id = dbo.hasGenre.movie_id
INNER JOIN dbo.genre  ON dbo.hasGenre.genre_id = dbo.genre.id
WHERE dbo.genre.name = 'Action'
AND dbo.movie.popularity = (
    SELECT MAX(popularity)
    FROM dbo.movie 
    INNER JOIN dbo.hasGenre  ON dbo.movie.id = dbo.hasGenre.movie_id
    INNER JOIN dbo.genre  ON dbo.hasGenre.genre_id = dbo.genre.id
    WHERE dbo.genre.name = 'Action'
)


/*
7
"Βρες τους τίτλους και τη βαθμολογία των ταινιών στο genre 'Action' με τη χαμηλότερη βαθμολογία"
Output: 58 rows
*/
SELECT dbo.movie.title AS least_rated_Action_movies, dbo.ratings.rating 
FROM dbo.movie 
INNER JOIN dbo.ratings on dbo.ratings.movie_id = dbo.movie.id
INNER JOIN dbo.hasGenre  ON dbo.movie.id = dbo.hasGenre.movie_id
INNER JOIN dbo.genre  ON dbo.hasGenre.genre_id = dbo.genre.id
WHERE dbo.genre.name = 'Action'
AND dbo.ratings.rating = (
    SELECT MIN(rating)
    FROM dbo.ratings 
    INNER JOIN dbo.hasGenre  ON dbo.movie.id = dbo.hasGenre.movie_id
    INNER JOIN dbo.genre  ON dbo.hasGenre.genre_id = dbo.genre.id
    WHERE dbo.genre.name = 'Action' 
)

/*
8
"Βρες την μέση βαθμολογία, με δύο δεκαδικά ψηφία, για το σύνολο των ταινιών της εταιρίας Warner Bros"
Output: 1 row
*/
SELECT ROUND(AVG(dbo.ratings.rating),2) AS WARNER_BROS_FILMS_AVG_RATING
FROM dbo.ratings 
INNER JOIN dbo.movie  ON dbo.ratings.movie_id = dbo.movie.id
INNER JOIN dbo.hasProductioncompany ON dbo.movie.id = dbo.hasProductioncompany.movie_id
INNER JOIN dbo.productioncompany ON dbo.hasProductioncompany.pc_id = dbo.productioncompany.id
WHERE dbo.productioncompany.name = 'Warner Bros.' 
AND dbo.ratings.rating IS NOT NULL;

/*
9
"Βρες τους τίτλους, τα έσοδα και τα κέρδη των ταινιών που έχουν στο όνομά τους το 'Star Wars' "
Output: 3 rows
*/
SELECT DISTINCT dbo.movie.title, dbo.movie.revenue, (dbo.movie.revenue - dbo.movie.budget) AS profit
FROM dbo.movie 
WHERE dbo.movie.title LIKE '%Star Wars%' 
ORDER BY profit DESC

/*
10
"Βρες τους τίτλους, το budget, τα έσοδα και τη μέση βαθμολογία των ταινιών, με 2 δεκαδικά ψηφία, που έχει σκηνοθετήσει ο Tarantino και επέστρεψέ τες σε φθήνουσα σειρά
*/
SELECT DISTINCT dbo.movie.title,  dbo.movie.budget, dbo.movie.revenue, r.rating
FROM dbo.movie
INNER JOIN dbo.movie_crew on dbo.movie_crew.movie_id=dbo.movie.id
LEFT JOIN (
    SELECT movie_id, ROUND(AVG(rating),2) AS rating
    FROM dbo.ratings
    GROUP BY movie_id
) r ON dbo.movie.id = r.movie_id
WHERE dbo.movie_crew.name='Quentin Tarantino' AND dbo.movie_crew.job = 'Director'
GROUP BY title,budget,revenue,rating
ORDER BY rating DESC

/*
11
"Βρες το κέρδος της εταιρίας Warner Bros στο διάστημα 01-01-2000 έως 31-12-2000"
Output: 1 row
*/
SELECT SUM(dbo.movie.revenue - dbo.movie.budget) AS profit
FROM dbo.movie 
INNER JOIN dbo.hasproductioncompany  ON dbo.movie.id = dbo.hasProductioncompany.movie_id
INNER JOIN dbo.productioncompany  ON dbo.hasProductioncompany.pc_id = dbo.productioncompany.id
WHERE dbo.productioncompany.name = 'Warner Bros.' 
AND dbo.movie.release_date BETWEEN '2000-01-01' AND '2000-12-31'

/*
12
"Βρες τα 10 πιο χρησιμοποιημένα keywords καθώς και το πόσες φορές έχουν χρησιμοποιηθεί στο διάστημα 01-01-2000 έως 31-12-2000"
Output: 10 rows
*/
SELECT TOP(10) dbo.Keywords.name AS most_used_keyword, COUNT(*) AS keyword_count
FROM dbo.movie
INNER JOIN dbo.hasKeyword ON dbo.movie.id = dbo.hasKeyword.movie_id
INNER JOIN dbo.Keywords ON dbo.hasKeyword.keyword_id = dbo.Keywords.id
INNER JOIN dbo.hasGenre ON dbo.movie.id = dbo.hasGenre.movie_id
INNER JOIN dbo.genre  ON dbo.hasGenre.genre_id = dbo.genre.id
WHERE dbo.genre.name = 'Action' AND dbo.movie.release_date BETWEEN '2000-01-01' AND '2000-12-31'
GROUP BY dbo.Keywords.name
ORDER BY COUNT(*) DESC