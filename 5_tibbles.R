# Para instalar paquetes en R usamos la función install.packages
# install.packages("tidyverse")
# Una vez que los instalamos, los tenemos que cargar al inicio 
# del script en el que los ocupamos y correr esa línea
library(tidyverse)

# El Data Frame iris se encuentra disponible en R Base y 
# podemos utilizarlo para revisar funciones de los dataframes
data(iris)
# Si la carga del dataset toma mucho tiempo, podemos forzarla
force(iris)
# Class indica que es un dataframe
class(iris)

# Con las siguientes funciones podemos conocer el número de 
# columnas, filas y los nombres de las columnas del dataframe
ncol(iris)
nrow(iris)
colnames(iris)

# Con la función tibble convertimos el dataframe nativo de R 
# a un tibble. Los tibbles son los objetos principales en el 
# universo de tidyverse, tienen mejoras en la presentación y 
# manejo de los datos
tiris <- tibble(iris)

# Las funciones que pueden ejecutarse en los dataframes también 
# sirven para los tibbles, pero no al revés.
ncol(tiris)
nrow(tiris)
colnames(tiris)

# La función de head nos permite ver las primeras líneas de 
# nuestro dataset.
head(tiris, n = 3)

# Si necesitamos crear un tibble, lo hacemos mediante la 
# especificación de sus columnas. Todas las columnas deben ser
# vectores del mismo tamaño.
ej_tbl <- tibble(
  num = 1:10,
  cuad = num ** 2,
  id = letters[1:10]
)
