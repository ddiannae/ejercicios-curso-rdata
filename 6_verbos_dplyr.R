library(tidyverse)

# Para leer datos de un archivo con valores separados por tabs
# utilizamos la función read_tsv. Tenemos que asegurarnos de indicar 
# la ruta correcta a partir de nuestro directorio de trabajo. En este
# caso los scripts están en el working directory y el archivo a leer 
# se encuentra dentro de una carpeta llamada data
poblacion <- read_tsv("data/poblacion.tsv")

# Observando las primeras entradas en el dataset nos aseguramos 
# de que éste se cargó correctamente
head(poblacion)
colnames(poblacion)

# Si queremos obtener las entradas de una de las columnas, es decir
# extraer el vector asociado a esa columna, podemos hacerlo con 
# el signo $, similar a la sintaxis de las listas
nom_ents <- poblacion$nom_ent

# El verbo de tidyr select(), nos permite obtener un subconjunto
# de las columnas del dataset. 
# Podemos elegirlas utilizando sus nombres.
poblacion_min <- select(.data = poblacion, nom_mun, nom_ent, pobtot)

# El verbo filter() nos permite elegir un subconjunto de las filas, 
# especificando una condición que será evaluada y se conservarán 
# las filas que resulten en valores TRUE en dicha condición.
poblacion_ags <- filter(.data = poblacion, nom_ent == "Aguascalientes")
filter(.data = poblacion_min, pobtot > 1000000)

# Sin embargo, la sintaxis anterior no es la sintaxis estándar para
# usar los verbos tidy. Comunmente se usa el operador de pipe, que 
# permite enviar el objeto del lado izquierdo, en este caso población, 
# como primer argumento de la función del lado derecho. 
poblacion %>%
  select(nom_ent, nom_mun, pobtot)

# Con esta sintaxis se puede concatenar el uso de múltiples 
# verbos de dplyr, sin requerir la declaración de variables 
# intermedias
poblacion %>%
  select(nom_mun, nom_ent, pobtot) %>%
  filter(pobtot > 1000000) 

# El uso del pipe no se limita a tibbles y verbos de dplyr, 
# puede utilizarse con vectores y variables atómicas y con 
# funciones de r base
mean(c(3, 4, 57, 23, 89, 34, 35))
c(3, 4, 57, 23, 89, 34, 35) %>%
  mean()

# Para guardar los datasets resultantes de transformaciones 
# se utiliza la función write_tsv() o write_csv() para gener un
# archivo de valores separados por tabs o por comas
write_tsv(x = poblacion_ags, file = "data/pob_aguascalientes.tsv")

# Select funciona indicando los nombres de las columnas a 
# seleccionar
poblacion_infatil <- poblacion %>% 
  select(nom_ent, nom_mun, pobtot, pob0_14)

# También podemos indicar las columnas que no queremos incluir
# en el subconjunto con el signo de menos
poblacion_femenina <- poblacion %>% 
  select(-entidad, -mun, -pob0_14, -pob15_64, -pob65_mas)

# Podemos también seleccionar todas las columnas que empiezan
# con algún prefijo
poblacion %>% 
  select(starts_with("pob"))

# O seleccionar por tipo de datos
poblacion %>% 
  select(nom_mun, where(is.numeric))

# Además, select nos permite renombrar columnas, combinar los 
# selectores y reordenar las columnas
poblacion %>% 
  select(municipio = nom_mun, where(is.numeric))

poblacion %>% 
  select(where(is.numeric), municipio = nom_mun)

# Arrange es el verbo de dplyr para ordenar el dataset de 
# acuerdo a los valores de una variable. Para ordenar de orma
# descendente utilizamos la función desc()
poblacion_femenina <- poblacion_femenina %>% 
  arrange(desc(pobfem))

# Por default se ordena de forma ascendente
poblacion_infatil %>% 
  arrange(pob0_14)

# Podemos combinar arrange con select
poblacion %>%
  arrange(nom_ent, desc(pobtot)) %>%
  select(nom_ent, nom_mun, pobtot) 

# El verbo mutate crea nuevas columnas a partir de funciones 
# u operaciones aplicadas a las columnas existentes. También 
# puede combinarse con otros verbos.
poblacion_infatil <- poblacion_infatil %>%
  mutate(porc_infantil = pob0_14/pobtot) %>% 
  arrange(desc(porc_infantil))

poblacion %>%
  mutate(id = paste0(entidad, mun)) %>%
  select(entidad, mun, id)

# Con la función count() contamos cuantas veces se repite cada 
# valor único de una variable, los resultados aparecen en la 
# variable n.
poblacion %>%
  count(nom_ent) %>%
  arrange(desc(n))

# Count permite ordenar los resultados de mayor a menor y 
# renombrar la columna creada
poblacion %>%
  count(nom_ent, sort = TRUE, name = "total")

# Finalmente, el verbo summarise() permite calcular resultados
# a partir de un agrupamiento previo mediante group_by(), que toma
# todos los valores únicos de una variable para formar los grupos y 
# aplica las funciones especificadas en las columnas correspondientes
poblacion %>% 
  group_by(nom_ent) %>%
  summarise(total = sum(pobtot), mean_pobtot = mean(pobtot), 
            max_pobtot = max(pobtot), sd_pobfem = sd(pobfem),
            max_infantil = max(pob0_14), total_mun = n())


