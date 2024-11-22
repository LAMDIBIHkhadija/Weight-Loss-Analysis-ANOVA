# Charger les packages nécessaires
library(readxl)
library(ggplot2)
library(car)

# Charger le fichier Excel
donnees <- read_excel("Diet1.xlsx")

# Appliquer une transformation logarithmique sur la variable weight6weeks
donnees$log_weight6weeks <- log(donnees$weight6weeks)
summary(donnees)
# Effectuer un test d'ANOVA avec trois variables indépendantes sur les données transformées
modele_anova <- aov(log_weight6weeks ~ Diet + gender + class, data = donnees)

# Afficher un résumé des résultats de l'ANOVA
summary(modele_anova)

# Effectuer un test de normalité sur les données transformées à l'aide du test de Shapiro-Wilk
shapiro_test <- shapiro.test(donnees$log_weight6weeks)
shapiro_test

# Extraire les résidus du modèle ANOVA
residus <- resid(modele_anova)

# Effectuer un test de normalité sur les résidus à l'aide du test de Shapiro-Wilk
shapiro_residus <- shapiro.test(residus)
shapiro_residus

# Visualisation des données

# Boxplot : Comparaison du poids par genre
P1 <- ggplot(donnees, aes(x = gender, y = log_weight6weeks, fill = gender)) +
  geom_boxplot() +
  labs(title = "Comparaison du poids par genre", x = "Genre", y = "Log du poids après 6 semaines", fill = "Genre")

# Boxplot : Comparaison du poids par classe de poids
P2 <- ggplot(donnees, aes(x = class, y = log_weight6weeks, fill = class)) +
  geom_boxplot() +
  labs(title = "Comparaison du poids après 6 semaines par classe de poids", x = "Classe de poids", y = "Log du poids après 6 semaines", fill = "Classe de poids")

# Boxplot : Comparaison du poids par régime
P3 <- ggplot(donnees, aes(x = Diet, y = log_weight6weeks, fill = Diet)) +
  geom_boxplot() +
  labs(title = "Comparaison du poids après 6 semaines par régime", x = "Régime", y = "Log du poids après 6 semaines", fill = "Régime")

# Tracer le QQ-plot
qqnorm(donnees$log_weight6weeks)
qqline(donnees$log_weight6weeks)

# Créer un graphique des résidus par les valeurs ajustées
P5 <- ggplot(data.frame(Fitted = fitted(modele_anova), Residuals = residus), aes(x = Fitted, y = Residuals)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Homogénéité des variances (Residus vs Valeurs ajustees)", x = "Valeurs ajustees", y = "Residus")

# Nuage de points résidus vs valeurs ajustées
plot(fitted(modele_anova), residus,
     xlab = "Valeurs ajustees",
     ylab = "Residus",
     main = "Nuage de points : Residus vs Valeurs ajustees",
     col = "blue",
     pch = 16
)

# Test d'homogénéité des variances avec le test de Levene
levene_test <- leveneTest(log_weight6weeks ~ Diet*gender*class, data = donnees)

# Afficher le résultat du test de Levene
print(levene_test)

# Effectuer le test post hoc (test de Tukey)
posthoc <- TukeyHSD(modele_anova)
# Afficher les résultats du test post hoc
print(posthoc)


plot(TukeyHSD(modele_anova))
# Test post hoc entre Diet et gender
posthoc_diet_gender <- pairwise.t.test(donnees$log_weight6weeks, interaction(donnees$Diet, donnees$gender), p.adjust.method = "bonferroni")
# Test post hoc entre Diet et class
posthoc_diet_class <- pairwise.t.test(donnees$log_weight6weeks, interaction(donnees$Diet, donnees$class), p.adjust.method = "bonferroni")
# Test post hoc entre gender et class
posthoc_gender_class <- pairwise.t.test(donnees$log_weight6weeks, interaction(donnees$gender, donnees$class), p.adjust.method = "bonferroni")

# Afficher les résultats des tests post hoc
print(posthoc_diet_gender)
print(posthoc_diet_class)
print(posthoc_gender_class)


# Créer un graphique d'interaction entre Diet et gender
interaction.plot(donnees$Diet, donnees$gender, donnees$log_weight6weeks, xlab = "Diet", ylab = "Log du poids apres 6 semaines", trace.label = "gender")



# Ajouter un titre
title("Interaction entre Diet et gender")

# Créer un graphique d'interaction entre Diet et class
interaction.plot(donnees$Diet, donnees$class, donnees$log_weight6weeks, xlab = "Diet", ylab = "Log du poids apres 6 semaines", trace.label = "class")

# Ajouter un titre
title("Interaction entre Diet et class")

# Créer un graphique d'interaction entre gender et class
interaction.plot(donnees$gender, donnees$class, donnees$log_weight6weeks, xlab = "Gender", ylab = "Log du poids apres 6 semaines", trace.label = "class")

# Ajouter un titre
title("Interaction entre gender et class")