package entities;
import java.time.LocalDate;
import java.io.Serializable;

import java.util.List;
import jakarta.persistence.*;
import jakarta.json.bind.annotation.JsonbDateFormat;
/**
 * The persistent class for the filmslivres database table.
 * 
 */
@Entity
@Table(name = "filmslivres")
@NamedQuery(name = "Filmslivre.findAll", query = "SELECT f FROM Filmslivre f")
public class Filmslivre implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_filmlivre")
    private int idFilmlivre;

    private String acteurs;
    @JsonbDateFormat("yyyy-MM-dd") 
    @Temporal(TemporalType.DATE)
    @Column(name = "anneesortie")
    private LocalDate anneesortie;
    @Column(name = "auteurlivre")
    private String auteurlivre;

    @Column(name = "descriptionlfilm")
    private String descriptionlfilm;

    @Column(name = "descriptionlivre")
    private String descriptionlivre;

    @Column(name = "dispolivre")
    private String dispolivre;

    @Column(name = "genre")
    private String genre;

    @Column(name = "imagefilm")
    private String imagefilm;

    @Column(name = "lienfilm")
    private String lienfilm;

    @Column(name = "lienlivre")
    private String lienlivre;

    @Column(name = "titre")
    private String titre;

    @Column(name = "titrelivre")
    private String titrelivre;

    @Column(name = "auteurfilm")
    private String auteurfilm;

    // bi-directional many-to-one association to Recommandation
    @OneToMany(mappedBy = "filmslivre", fetch = FetchType.EAGER)
    private List<Recommandation> recommandations;

    public Filmslivre() {
    }

    public int getIdFilmlivre() {
        return this.idFilmlivre;
    }

    public void setIdFilmlivre(int idFilmlivre) {
        this.idFilmlivre = idFilmlivre;
    }

    public String getActeurs() {
        return this.acteurs;
    }

    public void setActeurs(String acteurs) {
        this.acteurs = acteurs;
    }

    public LocalDate getAnneesortie() {
        return this.anneesortie;
    }

    public void setAnneesortie(LocalDate anneesortie) {
        this.anneesortie = anneesortie;
    }

    public String getAuteurlivre() {
        return this.auteurlivre;
    }

    public void setAuteurlivre(String auteurlivre) {
        this.auteurlivre = auteurlivre;
    }

    public String getDescriptionlfilm() {
        return this.descriptionlfilm;
    }

    public void setDescriptionlfilm(String descriptionlfilm) {
        this.descriptionlfilm = descriptionlfilm;
    }

    public String getDescriptionlivre() {
        return this.descriptionlivre;
    }

    public void setDescriptionlivre(String descriptionlivre) {
        this.descriptionlivre = descriptionlivre;
    }

    public String getDispolivre() {
        return this.dispolivre;
    }

    public void setDispolivre(String dispolivre) {
        this.dispolivre = dispolivre;
    }

    public String getGenre() {
        return this.genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getImagefilm() {
        return this.imagefilm;
    }

    public void setImagefilm(String imagefilm) {
        this.imagefilm = imagefilm;
    }

    public String getLienfilm() {
        return this.lienfilm;
    }

    public void setLienfilm(String lienfilm) {
        this.lienfilm = lienfilm;
    }

    public String getLienlivre() {
        return this.lienlivre;
    }

    public void setLienlivre(String lienlivre) {
        this.lienlivre = lienlivre;
    }

    public String getTitre() {
        return this.titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getTitrelivre() {
        return this.titrelivre;
    }

    public void setTitrelivre(String titrelivre) {
        this.titrelivre = titrelivre;
    }

    public String getAuteurfilm() {
        return this.auteurfilm;
    }

    public void setAuteurfilm(String auteurfilm) {
        this.auteurfilm = auteurfilm;
    }

    public List<Recommandation> getRecommandations() {
        return this.recommandations;
    }

    public void setRecommandations(List<Recommandation> recommandations) {
        this.recommandations = recommandations;
    }

    public Recommandation addRecommandation(Recommandation recommandation) {
        getRecommandations().add(recommandation);
        recommandation.setFilmslivre(this);

        return recommandation;
    }

    public Recommandation removeRecommandation(Recommandation recommandation) {
        getRecommandations().remove(recommandation);
        recommandation.setFilmslivre(null);

        return recommandation;
    }
}