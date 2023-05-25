# Paquete con información de nombre de países
library(countrycode)
library(dplyr)

# El dataframe `countryname_dict` contiene nombres de países 
# en diferentes lenguajes
paises <- countryname_dict

# Si queremos identificar elementos únicos en un vector, podemos 
# hacer uso de la función unique() de R base
# Obtenemos el tamaño del vector de valores únicos en la columna
# country.name.en
length(unique(paises$country.name.en))

# Ejemplo con tibbles 
# La función sample() nos permite obtener una muestra aleatoria 
# con o sin reemplazo de los valores en un vector. 
# Creamos un tibble con entradas repetidas en las columnas
# year y month
df_repetidos <- tibble(
  year = sample(1950:2020, 200, replace = T),
  month = sample(month.name, 200, replace = T),
  pais = sample(unique(paises$country.name.en), 200)
)

# La función distinct() de dplyr nos permite elegir las filas
# con valores únicos dadas sus entradas en todas las columnas.
# Como la columna de países no tiene repetidos, tenemos 200 
# filas únicas
df_repetidos %>% 
  distinct() %>%
  nrow()

# Podemos seleccionar solo un subconjunto de columnas para 
# identificar los valores únicos. Estas columnas actuarían 
# como las llaves o identifiadores únicos.
df_repetidos %>%
  distinct(year, month) %>%
  nrow()

# Así, distinct() devuelve un tibble con el subconjunto de 
# columnas elegidas
df_repetidos %>%
  distinct(year, month)

# Si utilizamos el parámetro .keep_all = TRUE, distinct()
# devolverá todas las columnas en el tibble, eligiendo la 
# primer entrada en la columna con valores repetidos
df_repetidos %>%
  distinct(year, month, .keep_all = TRUE)

# Si no queremos que se elija la primera entrada y queremos 
# conocer los valores de las columnas repetidas, podemos comenzar
# por hacer un count de las columnas que funcionan como llaves.
# Filtramos con n>1 para quedarnos solo con las que se repiten.
duplicados <- df_repetidos %>% 
  count(year, month, sort = T) %>% 
  filter(n > 1)

# Para identificar los valores repetidos, haremos un join entre el 
# tibble con llaves repetidas y el tibble original. 
# La función inner_join devuelve las entradas que se comparten en 
# ambos tibbles y las columnas de ambos. Por default, dplyr 
# identifica las columnas que tienen el mismo nombre para 
# hacer el join. 
# Más información: https://bookdown.org/ddiannae/curso-rdata/uniendo-datasets.html
entradas_duplicadas <- df_repetidos %>%
  inner_join(duplicados) %>% 
  arrange(year, month)

# Con el argumento by podemos especificar explícitamente las 
# columnas por las cuales queremos que se haga la unión 
df_repetidos %>%
  inner_join(duplicados, by = c("year", "month")) %>% 
  arrange(year)

# left_join() mantiene todas las filas del tibble de la izquierda
# y agrega las columnas del tibble de la derecha añadiendo NA 
# donde no hay entradas compartidas
df_repetidos %>%
  left_join(duplicados)

# right_join() hace lo mismo pero manteniendo las filas del tibble
# de la derecha
df_repetidos %>% 
  right_join(duplicados)

# Depende de cómo acomodemos los tibbles, usamos right o left
duplicados %>% 
  right_join(df_repetidos) %>% 
  arrange(year)

# Existen otro par de funciones que no agregan nuevas columnas. 
# Se les llama Filtering joins. 
# semi_join() mantiene todas las columnas del tibble de la izquierda
# pero solamente elige las filas que coinciden con las columnas 
# llave del tibble de la derecha
df_repetidos %>%
  semi_join(duplicados) %>% 
  arrange(year, month)

# anti_join() también mantiene todas las columnas del tibble de la izquierda
# pero elige las filas que NO coinciden con las columnas 
# llave del tibble de la derecha
df_repetidos %>% 
  anti_join(duplicados)
