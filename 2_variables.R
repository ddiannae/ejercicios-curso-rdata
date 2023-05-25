# VARIABLES
# Una variable es un par nombre, valor. Creamos una variable y
# le asignamos un valor al declararla
numero <- 89.63
numero2 <- 45.3

# Debemos elegir nombres de variables significativos y lo más
# sencillos y cortos que se pueda

# Podemos realizar operaciones con las variables que declaramos
numero * numero2
3*numero

# También podemos usar funciones de r aplicadas a las variables
# que declaramos
# floor obtiene el número entero superior
floor(numero)
# celing obtiene el número entero inferior
ceiling(numero)
# Podemos almacenar el resultado en otra variable
fnum <- floor(numero)

# ERRORES COMUNES
flor(numero)
# Error in flor(numero) : could not find function "flor"
# Usualmente significa que escribimos mal la función o me falta un paquete

floor(numer)
# Error: object 'numer' not found
# Usualmente significa que Escribimos mal la variable que es el
# argumento de la función

# TIPOS DE VALORES
# numeric
class(numero)

# integer
entero <- 67L
class(entero)

# character
cadena <- "Esta es una cadena de caracteres"
class(cadena)

# logic
logico_true <- TRUE
class(logico_true)
logico_falso <- F
class(logico_falso)
