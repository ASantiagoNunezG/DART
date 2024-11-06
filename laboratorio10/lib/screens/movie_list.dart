import 'package:flutter/material.dart';
import '../models/movie.dart';

final List<Movie> movies = [
  Movie(
    title: "Inception",
    genre: "Ciencia Ficción",
    releaseDate: "2010-07-16",
    imageUrl: "https://i.scdn.co/image/ab67616d00001e02a883e26f90ab617c91b90e56",
    description: "Un ladrón que roba secretos corporativos a través de la tecnología de compartir sueños.",
    rating: 3,
  ),
  Movie(
    title: "The Matrix",
    genre: "Acción",
    releaseDate: "1999-03-31",
    imageUrl: "https://screwthezoo.com/wp-content/uploads/The-Philosophy-of-The-Matrix-1024x459.jpg",
    description: "Un hacker descubre la verdadera naturaleza de su realidad.",
    rating: 4,
  ),
  Movie(
    title: "Spiderman",
    genre: "Acción",
    releaseDate: "2003-05-01",
    imageUrl: "https://img.ecartelera.com/noticias/69500/69504-h3.jpg",
    description: "La historia de un joven que obtiene habilidades arácnidas y lucha contra el crimen.",
    rating: 4.5,
  ),
  Movie(
    title: "The Witcher Project",
    genre: "Terror",
    releaseDate: "1999-07-16",
    imageUrl: "https://resizing.flixster.com/K3z498vcU18P7z-6loloLRBVzjg=/fit-in/705x460/v2/https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p22546_v_h9_aa.jpg",
    description: "Tres estudiantes desaparecen mientras graban un documental sobre una leyenda urbana.",
    rating: 4.4,
  ),
  Movie(
    title: "Das Boot",
    genre: "Drama Bélico",
    releaseDate: "1981-09-17",
    imageUrl: "https://encadenados.org/wp-content/uploads/2018/02/el-resplandor_num_97_el-submarino-0.jpg",
    description: "La historia de la tripulación de un submarino alemán durante la Segunda Guerra Mundial.",
    rating: 4.8,
  ),
  Movie(
    title: "La tumba de las luciérnagas",
    genre: "Animación, Drama",
    releaseDate: "1988-04-16",
    imageUrl: "https://panamapoetico.com/wp-content/uploads/gravity_forms/2-0ff384c594a2d0424eb2607386fa3446/2023/01/Tumba-33.png",
    description: "Dos hermanos intentan sobrevivir en Japón durante la Segunda Guerra Mundial.",
    rating: 5,
  ),
];


class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Card(
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Column(
            children: [
              Image.network(
                movie.imageUrl,
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Calificación: ",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontFamily: 'Nunito',
                          ),
                        ),
                        Row(
                          children: List.generate(
                            movie.rating.floor(), // Estrellas completas según el rating
                            (index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                          ),
                        ),
                        if (movie.rating - movie.rating.floor() > 0)
                          Icon(
                            Icons.star_half,
                            color: Colors.amber,
                            size: 18,
                          ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Género: ${movie.genre}",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Nunito',
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Fecha de estreno: ${movie.releaseDate}",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      movie.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
