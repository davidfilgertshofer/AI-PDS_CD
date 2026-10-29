library(psych)
library(tidyLPA)
library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(kableExtra)
library(knitr)
library(gapminder)
library(stargazer)
library(apaTables)
library(readr)
library(DescTools)
library(sjmisc)


##Test Profiles iterative - start with 15.
Dataset_AIPDS_CD %>% ##nehme Datensatz und überführe in...
  select(functional_ix, social_ix, performative_ix, threat_ix) %>% #wähle folgende Variable und überführe in
  single_imputation() %>% #bearbeite Missing Values wenn vorhanden und überführe in
  scale() %>% #standardisiere Indizes und überführe in
  estimate_profiles(n_profiles=1:15) -> profiles99 

compare_solutions(profiles99, statistics = c("BIC", "BLRT_val", "BLRT_p", "Entropy"))
get_fit(profiles99) ##best overall fit for 9 profiles: BIC lowest, significant BLRT, Entropy good.

#Estimate again for 9 profiles
Dataset_AIPDS_CD %>% ##nehme Datensatz und überführe in...
  select(functional_ix, social_ix, performative_ix, threat_ix) %>% #wähle folgende Variable und überführe in
  single_imputation() %>% #bearbeite Missing Values wenn vorhanden und überführe in
  scale() %>% #standardisiere Indizes und überführe in
  estimate_profiles(n_profiles=9) -> profiles1 

##Show Plot
plot_profiles(profiles1, variables = NULL, ci = NULL, sd = FALSE, add_line = TRUE, rawdata = FALSE, bw = FALSE, alpha_range = c(0, 0.1)) + aes(linetype = "solid") + labs(x = "Perception Dimensions", y = "Std. Mean Scores") + guides(linetype = "none")



##show Shares
get_data(profiles1) %>% 
  count(Class) %>% 
  mutate(Prozent = (n / sum(n)) * 100)

plot_profiles <- get_data(profiles1) %>% 
  count(Class) %>% 
  mutate(
    Prozent = (n / sum(n)) * 100,
    # Erstellt das Label im Format: "N = X (X.X%)"
    Label = paste0("N = ", n, "\n(", round(Prozent, 1), "%)"),
    # Class als Faktor für die x-Achse definieren
    Class = as.factor(Class)
  )

ggplot(plot_profiles, aes(x = Class, y = n)) +
  geom_col(fill = "grey40", color = "black", width = 0.6) +
  geom_text(aes(label = Label), vjust = -0.3, size = 3.5, fontface = "plain") +
  labs(x = "Latent Profile (Class)", y = "Frequency (N)") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  theme_classic(base_size = 12) +
  theme(
    text = element_text(family = "sans"),
    axis.line = element_line(color = "black"),
    axis.title.x = element_text(margin = margin(t = 10)),
    axis.title.y = element_text(margin = margin(r = 10)),
    axis.text = element_text(color = "black")
  )




###estimate comparison between profile 4 and 7.

df_lpa_results <- get_data(profiles1)

df_final <- df_lpa_results %>%
  mutate(trust = Dataset_AIPDS_CD$trust)

library(dplyr)


df_p4_p7 <- df_final %>%
  filter(Class %in% c(4, 7)) %>%
  mutate(Class = factor(Class))

# 2. Deskriptive Statistik für Trust in Profil 4 vs. Profil 7
df_p4_p7 %>%
  group_by(Class) %>%
  summarise(
    n = n(),
    mean_trust = mean(trust, na.rm = TRUE),
    sd_trust = sd(trust, na.rm = TRUE)
  )

# 3. Inferenzstatistik (t-Test für den Mittelwertvergleich)
t_test_trust <- t.test(trust ~ Class, data = df_p4_p7)
print(t_test_trust)
