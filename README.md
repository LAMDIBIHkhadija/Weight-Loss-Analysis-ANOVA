# **Analyse de la Perte de Poids à l’Aide de l’ANOVA**

## **Description**
Ce projet utilise l'analyse de variance (ANOVA) pour explorer l'impact de trois facteurs indépendants — **régime alimentaire (Diet)**, **genre (gender)**, et **classe de poids (class)** — sur le **poids après six semaines**.

L'analyse comprend des visualisations détaillées, des tests statistiques pour valider les hypothèses, ainsi que des comparaisons post hoc pour examiner les interactions significatives entre les variables.

---

## **Objectifs**
- Évaluer l'effet des variables indépendantes (**Diet**, **gender**, **class**) sur le poids après six semaines à l'aide d'un modèle ANOVA.
- Vérifier les hypothèses d'homogénéité des variances et de normalité des résidus.
- Effectuer des tests post hoc pour explorer les interactions significatives.
- Visualiser les résultats avec des graphiques (boxplots, graphiques d'interaction, QQ-plots).

---

## **Structure du Projet**
- **`Diet1.xlsx`** : Fichier de données contenant les poids initiaux, poids après 6 semaines, et les variables explicatives.
- **`code/`** : Scripts R pour effectuer l'analyse et générer les visualisations.
- **`output/`** : Graphiques et rapports générés à partir des analyses.

---

## **Analyses Effectuées**
### 1. Préparation des données
- Transformation logarithmique appliquée à la variable `weight6weeks`.
- Résumé statistique des données avant et après transformation.

### 2. Modèle ANOVA
- Modèle ANOVA à trois facteurs : **Diet**, **gender**, **class**.
- Résultats présentés sous forme de tableau ANOVA.

### 3. Validation des hypothèses
- **Test de normalité** : Test de Shapiro-Wilk appliqué aux résidus.
- **Homogénéité des variances** : Test de Levene pour vérifier les variances égales.

### 4. Comparaisons post hoc
- Test de Tukey pour les interactions significatives.
- Tests pairwise avec correction de Bonferroni pour comparer les groupes.

### 5. Visualisations
- **Boxplots** : Comparaison du poids par **Diet**, **gender**, et **class**.
- **Graphiques d'interaction** : Exploration des interactions entre les facteurs.
- **QQ-plots** : Validation de la normalité des données.
- **Nuage de points résidus vs valeurs ajustées** : Vérification de l'homogénéité des variances.

---

## **Dépendances**
- **R version 4.x ou supérieure**
- Bibliothèques R : 
  - `readxl`
  - `ggplot2`
  - `car`

Installez les dépendances avec :
```r
install.packages(c("readxl", "ggplot2", "car"))
