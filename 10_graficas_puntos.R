# Con readxl podemos leer archivos de Excel
library(readxl)
library(dplyr)
# janitor contiene funciones para facilitar el manejo de nuestros datos
library(janitor)
library(ggplot2)

# Leemos los datos con la función read_xlsx
happiness <- read_xlsx("data/world-happiness-report-2021.xlsx") %>%
  clean_names()

# Obtenemos las regiones con mayores puntajes de felicidad y el 
# número de países que se encuentran en dicha región con el verbo summarise
happiness %>% 
  group_by(regional_indicator) %>% 
  summarise(mean_score = mean(ladder_score), 
            total_paises = n()) %>% 
  arrange(desc(mean_score))

# ¿Qué porcentaje del score de felicidad está explicado por el 
# valor del social support?
happiness %>% 
  mutate(porc_ss = explained_by_social_support/ladder_score * 100) %>%
  select(country_name, porc_ss, ladder_score)


# Con geom_point generamos una gráfica de puntos, especificando 
# los mapeos para x, y.
ggplot(happiness) + 
  geom_point(aes(x = logged_gdp_per_capita, y = ladder_score))

# En estas gráficas pueden mapearse diferentes características 
# estéticas para incluir más variables. 
ggplot() + 
  # Aquí mapeamos también el tamaño y color de los puntos. Además, 
  # modificamos la viñeta por default con el argumento shape
  geom_point(data = happiness, aes(x = logged_gdp_per_capita, 
                             y = ladder_score, 
                             size = healthy_life_expectancy, 
                             color = social_support), 
             shape = 22) + 
  # Cambiamos los títulos
  labs(title = "GDP vs Score felicidad", x = "GDP per capita", 
       y = "Score felicidad") + 
  # Establecemos el nombre de la escala de tamaño y los cortes
  # a mostrar en la leyenda
  scale_size(name = "Expectativa de vida sana", 
             breaks = c(50, 55, 60, 65, 70, 75)) +
  # Cambiamos la escala de color y tema de la gráfica
  scale_color_viridis_c(name = "Score de social support", option = "B") +
  theme_minimal() +
  theme(text = element_text(size = 20))


# Con la función quantile podemos obtener los cuantiles asociados a 
# los valores en un vector, en este caso lla expectativa de vida sana
quantile(happiness %>%
           pull(healthy_life_expectancy))

# Así, obtenemos solamente las entradas con valores más allá de la 
# mediana
mayor_healthy_life <- happiness %>% 
  filter(healthy_life_expectancy >= 69.600)

# Hacemos otra gráfica de puntos mapeando diferentes variables. 
ggplot(data = mayor_healthy_life, aes(x = healthy_life_expectancy, 
                                    y = generosity, 
                                    size = ladder_score, 
                                    fill = social_support))  +
  # Modificamos el alpha de los puntos ya que usamos una viñeta 
  # que acepta fill 
  geom_point(shape = 21, alpha=0.5) +
  # Modificamos los títulos
  labs(x = "Expectativa de vida sana", 
       y = "Score de Generosidad", 
       title = "Vida Sana vs Generosidad") + 
  # Cambiamos el nombre y cortes de la escala de tamaño
  scale_size(name = "Score de felicidad", breaks = c(6, 6.5, 7)) +
  # Modificamos la escala de color
  scale_fill_viridis_c(name = "Score de social support") +
  # Agregamos un ajuste lineal a los puntos
  geom_smooth(method=lm , formula = 'y ~ x', color="red", se=FALSE, 
              show.legend = FALSE) +
  theme_minimal() +
  theme(text = element_text(size = 18))
