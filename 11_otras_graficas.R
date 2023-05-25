library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)

poblacion <- read_tsv("data/poblacion.tsv")
bajio <- c("Aguascalientes", "Guanajuato", "Querétaro", "San Luis Potosí", "Zacatecas")

poblacion <- poblacion %>%
  filter(nom_ent %in% bajio) 

# Haremos una gráfica de la distribución de la población en dos grupos 
# de edad. Para eso necesitamos modificar el formato de nuestros datos.
# Las columnas que inician con el sufijo pob, se agruparán en dos 
# columnas llamadas name y value. Name contendrá el nombre de la columna 
# donde provienen los datos y value contendrá el valor de la columna
por_edades <- poblacion %>% 
  select(nom_ent, nom_mun, pob0_14, pob15_64, pob65_mas) %>% 
  pivot_longer(cols = starts_with("pob")) %>% 
  filter(name %in% c("pob0_14", "pob65_mas"))

# Creamos boxplots para las distribuciones. Con facet_wrap las 
# gráficas de cada estado aparecen en una sección diferente. 
# También modificamos las etiquetas para los valores en x
ggplot(por_edades, aes(x = name, y = value)) + 
  geom_boxplot() + 
  scale_x_discrete(labels = c("pob0_14" = "Menores 14", 
                              "pob65_mas" = "Mayores 65")) +
  facet_wrap(~nom_ent, scales = "free_y") +
  xlab("") +
  theme_light()
  
# Las mismas distribuciones podemos visualizarlas con gráficas 
# de violin.
ggplot(por_edades, aes(x = name, y = value)) + 
  geom_violin() + 
  scale_x_discrete(labels = c("pob0_14" = "Menores 14", 
                              "pob65_mas" = "Mayores 65")) +
  facet_wrap(~nom_ent, scales = "free_y") +
  xlab("") +
  theme_light()
 
library(ggpubr)

# Podemos hacer también pruebas estadísticas. En este caso, 
# utilizamos el Wilcoxon Rank Sum, que es el equivalente no 
# paramétrico a una prueba T. 
# La distribución de la población menor a 14 años y la población 
# mayor a 65 años en Guanajuato es diferente. 
pob0_14 <- poblacion %>%
  filter(nom_ent == "Guanajuato") %>% pull(pob0_14)

pob_mayor <- poblacion %>%
  filter(nom_ent == "Guanajuato") %>% pull(pob65_mas)

wilcox.test(pob0_14, pob_mayor)

# Con la función stat_compare_means del paquete ggpubr podemos
# agregar el resultado de una prueba estadística entre dos 
# grupos a nuestra gráfica.
por_edades %>% 
  filter(nom_ent == "Guanajuato") %>%
  ggplot(aes(x = nom_ent, y = value, fill = name)) + 
  geom_violin() +
  stat_compare_means(method = "wilcox.test", show.legend = F,  label.y.npc = "top",
                     label.x.npc = "center") 
