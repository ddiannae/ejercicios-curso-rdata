library(readr)
library(dplyr)
library(ggplot2)

# Leemos los datos de población
poblacion <- read_tsv("data/poblacion.tsv")

# Para facilitar la visualización, solamente tomaremos un subconjunto
# de los estados. Por lo tanto, generamos un vector con los nombres 
# de estados del bajío
bajio <- c("Aguascalientes", "Guanajuato", "Querétaro", 
           "San Luis Potosí", "Zacatecas")

# En R, para filtrar un vector, en este caso la columna nom_ent
# con los valores de otro vector, utilizamos el operador %in%
poblacion <- poblacion %>%
  filter(nom_ent %in% bajio)

# Con el verbo count contamos las apariciones de cada uno de los
# valores únicos en esa columna. Como estamos contando cuántas veces
# aparece cada nombre de estado en la tabla, es equivalente a contar
# el número de municipios por estado, ya que cada fila corresponde 
# a un municipio.
poblacion %>% 
  count(nom_ent)

# Utilizamos la función ggplot para crear gráficas. Funciona como un
# sistema de capas donde vamos agregando elementos para modificar
# la gráfica. 
ggplot() +
  # Con geom_bar incluimos gráficas de barras con el mismo comportamiento
  # que count, cuentan los valores únicos. El atributo data contiene el 
  # tibble de donde se obtienen los datos, mapping es un atributo que utiliza
  # la función aes() para mapear las características de la gráfica a las variables 
  # o columnas en el dataframe. En este caso fill no está mapeado a alguna 
  # variable, por lo que indicamos un color para todas las barras.
  # Con geom_bar solamente mapeamos el valor de x ya que el valor de y resultará
  # de la cuenta de los valores únicos
  geom_bar(data = poblacion, mapping = aes(x = nom_ent), fill = "maroon4") +
  # Etiqueta para el eje x
  xlab("") +
  # Etiqueta para el eje y
  ylab("Número de municipios") +
  # título
  ggtitle("Estados del Bajío") +
  # Cambiamos los elementos estéticos de la gráfica con diferentes temas
  theme_classic() +
  # El tamaño de texto y su alineación se cambia con la función theme()
  theme(text = element_text(size = 18), 
        axis.text.x = element_text(angle = 90, hjust = 1))

# Utilizando los verbos de dplyr, generamos un dataset con 
# el promedio del porcentaje de población femenina y su desviación estándar
# en los estados del bajío, a partir del porcentaje de dicha 
# población en cada municipio.
# El verbo select puede utilizarse para renombrar columnas y debemos
# utilizar los nuevos nombres en los verbos posteriores al 
# renombramiento.
porcentaje_femenino <- poblacion %>% 
  mutate(porc_fem = pobfem/pobtot * 100) %>% 
  select(entidad = nom_ent, municipio = nom_mun, 
         poblacion = pobtot, pobfem, porc_fem) %>% 
  group_by(entidad) %>% 
  summarise(prom_pob_fem = mean(porc_fem), sd_pob_fem = sd(porc_fem)) %>%
  arrange(desc(prom_pob_fem))

# En este caso tenemos los valores x, y que queremos graficar, por lo tanto
# utilizamos la función geom_col y mapeamos ambas variables con aes.
# Como crearemos dos capas de geometría a partir de los mismos datos, podemos
# mandar nuestro dataset como argumento data en la función ggplot.
ggplot(porcentaje_femenino) + 
  # Mapeamos el color de cada barra con el argumento fill
  geom_col(aes(x = entidad, y = prom_pob_fem, fill = entidad)) +
  # Con geom_errorbar graficamos barras de error, que en este caso tomarán el 
  # valor de la desviación estándar
  geom_errorbar(aes(x = entidad, y = prom_pob_fem, ymin = prom_pob_fem-sd_pob_fem, 
                    ymax = prom_pob_fem+sd_pob_fem), width = 0.2) +
  # Cambiamos la paleta de colores y establecemos el nombre para esta escala
  scale_fill_brewer(name = "Estados", palette = "Set1") +
  # Modificamos los títulos con la función labs
  labs(x = "Estados", y = "Promedio de porcentaje de población femenina", 
       title = "Estados del Bajio") + 
  theme_minimal() + 
  # No requerimos una leyenda para la escala de colores ya que los nombre de los 
  # estados aparecen también en el eje x
  theme(legend.position = "none")
