# CONDICIONALES
# Las estructuras condicionales nos permiten ejecutar código 
# cuando una condición se cumple
numeros <- runif(30, min = 3, max = 200)

# Dentro del if ponemos la condición a evaluar. Tenemos que 
# asegurarnos de que la condición regresa un valor lógico 
# atómico
if (any(numeros > 100)) {
  print("Hay un valor mayor a 100")
}
# Esta evaluación genera un Warning porque la condición es un 
# vector con múltiples valores
# if (numeros > 100) {
#  print("Hay un valor mayor a 100")
# }

# La condición if puede estar acompañada de un else, cuando 
# queremos que un bloque de código se ejecute si la condición
# no se cumple
if (any(numeros > 200)) {
  print("Hay un valor mayor a 200")
} else {
  print("No hay un valor mayor a 200")
}

if(all(numeros > 50)) {
  print("Todos mayores a 50")
} else {
  print("No todos mayores a 50")
}

# FUNCIONES
# Las funciones son bloques de código que podemos ejecutar 
# muchas veces haciendo referencia a ellas a través de su nombre. 
# Al igual que las variables, debemos declararlas

# Declaración
saludar <- function(){
  print("Hola! Feliz viernes")
}

# Ejecución
saludar()

# Todas las funciones que hemos utilizado hasta este momento, 
# mean o floor, han sido declaradas previamente en los paquetes
# de R base.

# Las funciones pueden recibir argumentos cuando necesitan 
# información del exterior para completar su acción. Por ejemplo, 
# mean necesita un vector numérico para calcular el promedio. 
# Los argumentos se comportan como variables dentro de la función, 
# tomando los valores establecidos en su ejecución y estos argumentos
# solamente existen dentro de la función
saludarParticipante <- function(participante) {
  print(paste0("Hola ", participante,  "! Feliz viernes"))
}

# El argumento nombre toma los valores enviados. 
saludarParticipante("Claudia")
saludarParticipante("Nelli")
# Al ser solamente un argumento, no necesitamos especificar 
# el argumento por su nombre, pero también podemos hacerlo.
saludarParticipante(participante = "Arantza")

# Otros ejemplos 
obtenerAreaCirculo <- function (radio) {
  pi * (radio **2)
}
obtenerAreaCirculo(3.4)
obtenerAreaCirculo(5)
obtenerAreaCirculo(2)

# Podemos tener el número de argumentos que necesitemos
obtenerPromedioDosNumeros <- function(num1, num2) {
  (num1 + num2)/2
}
obtenerPromedioDosNumeros(8, 245)
obtenerPromedioDosNumeros(num2 = 234, num1 = 6788)

# Por default, las funciones en R regresan el último valor que 
# obtienen. Sin embargo, podemos utilizar la función return() 
# para indicar explícitamente el valor de retorno. Sin ésta, la 
# siguiente función siempre regresaría 5
obtenerPromedio <- function(vector) {
  suma <- sum(vector)
  prom <- suma/length(vector)
  return(prom)
  5
}

obtenerPromedio(c(1, 3, 5, 7))
nums <- runif(150, min = 1, max = 1000)
obtenerPromedio(nums)

# Función basada en este reto: https://www.codewars.com/kata/5545f109004975ea66000086
# Con la función is_divisible, indicamos si el número n es divisible
# entre x y y, solo entre x, solo entre y o no es divisible entre 
# ninguno.
is_divisible <- function(n, x, y) {
  # Utilizamos una estructura condicional que nos permite incluir 
  # más de dos comparaciones. En el if se encuentra la comparación
  # más astringente y en los else if, las comparaciones restantes. 
  # Nuevamente, el bloque de código en el else se ejecuta cuando no 
  # se cumple ninguna de las comparaciones.
  # Los operadores booleanos & (AND) y | (OR), sirven para relacionar 
  # múltiples comparaciones. AND se utiliza cuando requerimos que todas 
  # las condiciones sean ciertas, en cambio OR solamente requiere que
  # una condición se cumpla para regresar TRUE.
  if (n %% x == 0 & n %% y == 0 ) {
    return(paste0(n, " es divisible entre ", x, " y ", y))
  } else if (n %% x == 0) {
    return(paste0(n, " es divisible entre ", x))
  } else if (n %% y == 0 ) {
    return(paste0(n, " es divisible entre ", y))
  } else {
    return("No es divisible entre ningún número")
  }
}

is_divisible(12, 4, 3)
is_divisible(35, 5, 3)
is_divisible(100, 20, 80)
is_divisible(81, 4, 9)
is_divisible(81, 4, 5)

# Código para resolver este reto: https://www.codewars.com/kata/5168bb5dfe9a00b126000018
# 1. Utilizaremos la función strsplit para separar los caracteres
# de la palabra en un vector de letras
# 2. Con la función rev() obtendremos el orden reverso de los 
# elementos del arreglo
# 3. Usaremos paste0 para pegar el arreglo de letras en una sola 
# cadena de caracteres

# La función strsplit acepta un vector de caracteres y regresa una 
# lista de vectores 
strsplit(c("cadena", "viernes", "febrero"), split = "")

# En R, las listas son estructuras de datos que permiten combinar 
# valores de diversos tipos
lista1 <- list("hola", 456, TRUE, c(256, 35, 67))
# Además, podemos asignar nombres a cada elemento
names(lista1) <- c("cadena", "numero", "booleano",
                   "vector")
# Y hacer referencia a los elementos utilizando dichos nombres
lista1$cadena
lista1$booleano
# También podemos utilizar sus posiciones, como en los vectores, 
# pero los índices se especifican con dobles corchetes [[]]
lista1[[1]]
lista1[[4]]

voltearPalabra <- function(s){
  # Separar letras
  letras <- strsplit(s, split = "")[[1]]
  # Invertir
  letras_rev <- rev(letras)
  # Unirlas. Utilizamos el argumento collapse cuando los elementos
  # a concatenar están en un vector. 
  return(paste0(letras_rev, collapse = ""))
  # Diferente a: paste0("h", "o", "l", "a", sep = "")
}

voltearPalabra("computadora")
voltearPalabra("planta")
