package mvcModel;

import entities.Filmslivre;
import java.util.List;

/**
 * Repository pour interagir avec Filmslivre entité.
 */
public interface FilmRepository {
    List<Filmslivre> findAll();
    Filmslivre findByTitre(String titre);
    void registerFilm(Filmslivre film);
    void supprimerFilm(String titre);
}