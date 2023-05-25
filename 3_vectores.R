# VECTORES
# Los vectores son colecciones de valores. Se declaran con la función c()
# OJO: Todos tienen que ser del mismo tipo
vector <- c(34, 57, 45, 89, 4)

# R tiene muchas funciones útiles para trabajar con vectores
# Obtener el tamaño del vector
length(vector)
# Obtener el promedio de los valores del vector
mean(vector)
# Obtener la media de los valores del vector
median(vector)
# Obtener la desviación estándar de los valores del vector
sd(vector)
# Obtener el valor máximo
max(vector)
# Obtener el valor mínimo
min_vector <- min(vector)

# ERRORES DE SINTAXIS
# Si utilizamos un punto en lugar de coma
c(34, 37. 987)
# Error: unexpected numeric constant in "c(34, 37. 987"
# Si utilizamos espacios entre nombres de las variables
min vector * 5
# Error: unexpected symbol in "max vector"

# Si creamos un vector con valores de diferente tipo, R no
# generará ningún error, pero realizará una coerción de los
# valores al tipo de datos más complejo que incluyamos
vector_coer <- c(56.56, "hola", TRUE)
# Este es el orden de coerción
# lógico -> entero -> numérico -> cadena de texto
# (logical -> integer -> numeric -> character)

# Operaciones vectorizadas
# En R las operaciones son vectorizadas, es decir, se realiza
# la operación elemento por elemento
vector * 5
vector + 244

# Podemos generar vectores de valores aleatorios utilizando
# las funciones de generación de números dada alguna distribución
# de probabilidad
numeros <- runif(30, min = 3, max = 200)
numeros <- floor(numeros)

# Para acceder a un subconjunto de los elementos del arreglo
# utilizamos los corchetes con el índice de los elementos que
# nos interesan. A esto se le llama subsetting
numeros[1]
numeros[2:5]

# Si elegimos números fuera del rango de índices existentes
# en un vector, generamos NAs (not a number). Algunas funciones
# que trabajan con valores numéricos tienen la opción de remover
# los NA antes de realizar la operación
vector_nas <- numeros[10:50]
mean(vector_nas)
mean(vector_nas, na.rm = TRUE)

# También podemos realizar operaciones de comparación, que evaluarán
# dicha relación elemento por elemento
vector_logico <- numeros > 120
numeros <= 80
numeros == 5

# El vector lógico generado con el resultado de las comparaciones
# puede utilizarse como máscara para obtener solamente los elementos
# con valores TRUE
numeros[numeros > 120]
# La función which obtiene los índices de los elementos donde el
# el resultado de la comparación es TRUE
which(numeros > 120)
# Para contar cuántos elementos resultan TRUE en la comparación,
# podemos obtener el tamaño del vector de índices o sumar los
# elementos del vector lógico resultante de la comparación,
# aprovechando su conversión a valores numéricos
length(which(numeros > 120))
sum(numeros > 120)

# Con la función all podemos saber si todos los valores pasan
# la comparación
all(numeros > 50)
all(numeros %% 2 == 0)

# Con any preguntamos si algunos de los valores pasan la
# comparación
any(numeros > 200)
any(numeros == 100)
any(numeros == 155)


