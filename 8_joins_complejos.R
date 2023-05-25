library(readr)
library(dplyr)

# Ahora haremos un join más complejo entre dos datasets que no 
# comparten directamente los valores en una columna
poblacion <- read_tsv("data/poblacion.tsv")

# Con el argumento col_types podemos especificar el tipo de datos
# de una columna. Readr lo asigna al leer las primeras 100 entradas 
# En este caso, necesitamos que sea caracter para poder unirlo con el 
# id de población. 
hospitales <- read_tsv("data/hospitales.tsv", 
                       col_types = cols(municipality_id = col_character()))

# Con glimpse() Obtenemos una vista rápida de los valores en el 
# dataset
glimpse(hospitales)

# Valores únicos para algunas de las variables utilizando 
# pull para obtener la columna como un vector de r base y 
# unique
hospitales %>% 
  pull(establishment_type) %>% 
  unique()

hospitales %>% 
  pull(institution) %>% 
  unique()

# Agrupamos el dataset de hospitales para obtener el número 
# de hospitales por municipio y así tener la misma granularidad
# en ambos datasets (hospitales y población por municipio)
hosp_por_municipio <- hospitales %>% 
  count(municipality_id, name = "total_hospitales")

# Creamos una nueva columna, uniendo el id de la entidad y el id
# de municipio, designados por el INEGI. Descartamos las columnas
# extra de población
poblacion <- poblacion %>% 
  mutate(id = paste0(entidad, mun)) %>%
  select(-pobfem, -pob0_14, -pob15_64, -pob65_mas)

# Al unir los datasets nos damos cuenta de que muchas entradas 
# quedan fuera del join, debido a que el `id` de poblacion
# contiene un 0 a la izquierda para los primeros estados. 
# Ejemplo: Aguascalientes, Aguascalientes tiene id 01001 en poblacion, 
# pero id 1001 en hosp_por_municipio. 
# Cuando las columnas llave no comparten el mismo nombre, se 
# especifica en el by como un vector con nombres asociados
poblacion %>% 
  inner_join(hosp_por_municipio, by = c("id"="municipality_id"))

# Modificamos el dataset hosp_por_municipio seleccionando los 
# municipality_id que tiene 4 o 5 caracteres y añadiendo un 
# 0 a la izquierda a los de tamaño 4
hosp_por_municipio <- hosp_por_municipio %>% 
  mutate(tamano = nchar(municipality_id)) %>% 
  filter(tamano %in% c(4, 5)) %>% 
  mutate(id = ifelse(tamano == 4, paste0("0", municipality_id), municipality_id)) %>% 
  select(-tamano, -municipality_id) %>% 
  select(id, total_hospitales)

# El join ahora captura las entradas de todos los municipios
# en ambos tibbles
poblacion_hospitales <- poblacion %>%
  inner_join(hosp_por_municipio, by = "id")

# ¿Los municipios con mayor población tienen más número de hospitales? 
# Podemos hacer una gráfica de puntos con ggplot
library(ggplot2)

ggplot(poblacion_hospitales) +
  geom_point(aes(x = pobtot, y = total_hospitales)) 
