#####Análise dos dados da pesquisa de Ana Luisa ######

# Passo 1 - Instalar os pacotes
install.packages("psych")
install.packages("rmisc")
install.packages("car")
install.packages("vegan")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("ggfortify")
install.packages("rstatix")

# Passo 2 - Chamar os pacotes ####
require(psych)
require(car)
require (rmisc)
require(dplyr)
require (vegan)
require(ggplot2)
require(ggfortify)
require(rstatix)

#Indicar o diretório 
setwd("/Users/michelle/Desktop/R/Luisa")
getwd()

#Chamar o DB
wildmeat1 <- read.csv('wildmeat1.csv', sep=';', dec=',') #apos nova imputação

View(wildmeat1)
glimpse(wildmeat1)
options(scipen = 999) 

##############CONVERSÃO DE MEDIDAS###################


wildmeat1 <- wildmeat1 %>% 
  mutate(fe = fe * 1000)

wildmeat1 <- wildmeat1 %>% 
  mutate(mn = mn * 1000)

wildmeat1 <- wildmeat1 %>% 
  mutate(zn = zn * 1000)

wildmeat1 <- wildmeat1 %>% 
  mutate(mg = mg * 1000)

wildmeat1 <- wildmeat1 %>% 
  mutate(se = se * 1000000)

##############ORGANIZANDO SUBSETS POR TIPOLOGIAS###################


#Filtrar aves/músculo
aves_musculo <- subset(wildmeat1, classificacao == 'ave' & partes_tfmed == 'Musculo')
View(aves_musculo)

#Filtrar mamifero/músculo
mamifero_musculo <- subset(wildmeat1, classificacao == 'mamifero' & partes_tfmed == 'Musculo')
View(mamifero_musculo)

#Filtrar mamifero/visceras
mamifero_viscera <- subset(wildmeat1, classificacao == 'mamifero' & partes_tfmed == 'Visceras')
View(mamifero_viscera)

#Filtrar reptil/musculo
reptil_musculo <- subset(wildmeat1, classificacao == 'reptil' & partes_tfmed == 'Musculo')
View(reptil_musculo)          

#Filtrar reptil/viscera
reptil_viscera <- subset(wildmeat1, classificacao == 'reptil' & partes_tfmed == 'Visceras')
View(reptil_viscera)      

#Filtrar reptil/musculo
reptil_musculo <- subset(wildmeat1, classificacao == 'reptil' & partes_tfmed == 'Musculo')
View(reptil_musculo)      

##############MTC - AVES MUSCULO###################

describe(aves_musculo$fe)
describe(aves_musculo$mn)

summary(reptil_viscera$se)
summary(reptil_musculo$se)


##############TESTE FE - ANOVA###################

model_fe <- aov(fe ~ type, data = wildmeat1)

#Pressupostos
autoplot(modelfe)
shapiro.test(model_fe$residuals) #p=0.4185
bartlett.test(fe ~ tipo, data = wildmeat1) #H0 variancias sao as mesmas


##Teste ANOVA ------------------------------

summary(model_fe)

options(scipen=999)

#teste a posteriori: teste de Tukey

TukeyHSD(model_fe) 


#Gráficos
feplot <- ggplot(wildmeat1, aes(x = type, y = fe, fill = type)) +
  geom_boxplot() +
  xlab(NULL) +
  ylab("iron content, mg") +
  theme_bw() +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        text = element_text(size = 20),
        title = element_text(size = 22))

print(feplot)
ggsave("fe.png", feplot, width = 15, height = 15, dpi = 600)

##############TESTE MAGNESIO (MG) - KRUSKAL-WALLIS###################

modelmg <- lm(mg ~ tipo, data = wildmeat1)
modelmg

#Pressupostos
autoplot(modelmg)

shapiro.test(modelmg$residuals) #p-value = 0.00000000000001257

##Teste de Kruskal-Walllis ------------------------------

kruskal.test(mg ~ tipo, data=wildmeat1) #p-value = 0.8098

##############TESTE MANGANES (MN) - KRUSKAL-WALLIS###################

model_mn <- aov(mn ~ tipo, data = wildmeat1)

#Pressupostos
autoplot(model_mn)
shapiro.test(model_mn$residuals) #p=0.169
bartlett.test(mn ~ tipo, data = wildmeat1) #p=0.00007194


##Teste de Kruskal-Walllis ------------------------------

kruskal.test(mn ~ tipo, data=wildmeat1) 

#teste a posteriori: teste de Dunn

modelmn<-dunn_test (mn ~ tipo, data=wildmeat1, p.adjust.method="bonferroni")
modelmn

#Gráficos
mnplot <- ggplot(wildmeat1, aes(x = type, y = mn, fill = type)) +
  geom_boxplot() +
  xlab(NULL) +
  ylab("manganese content, mg") +
  theme_bw() +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        text = element_text(size = 20),
        title = element_text(size = 22))

print(mnplot)
ggsave("mn.png", mnplot, width = 15, height = 15, dpi = 600)

##############TESTE SE - KRUSKAL-WALLIS###################

modelse <- lm(se ~ type, data = wildmeat1)
modelse


#Pressupostos
autoplot(modelse)

shapiro.test(modelse$residuals) #p-value = 0.00002133

##Teste de Kruskal-Walllis ------------------------------

kruskal.test(se ~ type, data=wildmeat1) 

#teste a posteriori: teste de Dunn

modelse<-dunn_test (se ~ type, data=wildmeat1, p.adjust.method="bonferroni")
modelse

#Gráficos
seplot <- ggplot(wildmeat1, aes(x = type, y = se, fill = type)) +
  geom_boxplot() +
  xlab(NULL) +
  ylab("selenium content, mcg") +
  theme_bw() +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        text = element_text(size = 20),
        title = element_text(size = 22))

print(seplot)
ggsave("se.png", seplot, width = 15, height = 15, dpi = 600)

##############TESTE ZN - KRUSKAL-WALLIS###################

modelzn <- lm(zn ~ tipo, data = wildmeat1)
modelzn


#Pressupostos
autoplot(modelzn)

shapiro.test(modelzn$residuals) #p-value = 

##Teste de Kruskal-Walllis ------------------------------

kruskal.test(zn ~ tipo, data=wildmeat1) 

#teste a posteriori: teste de Dunn

modelzn<-dunn_test (zn ~ tipo, data=wildmeat1, p.adjust.method="bonferroni")
modelzn

#Gráficos
znplot <- ggplot(wildmeat1, aes(x = type, y = zn, fill = type)) +
  geom_boxplot() +
  xlab(NULL) +
  ylab("zinc content, mg") +
  theme_bw() +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        text = element_text(size = 20),
        title = element_text(size = 22))

print(znplot)
ggsave("zn.png", znplot, width = 15, height = 15, dpi = 600)

##############TESTE NA - KRUSKAL-WALLIS###################

modelna <- lm(na ~ tipo, data = wildmeat1)
modelna


#Pressupostos
autoplot(modelna)

shapiro.test(modelna$residuals) #p-value = 

##Teste de Kruskal-Walllis ------------------------------

kruskal.test(na ~ tipo, data=wildmeat1) 

#teste a posteriori: teste de Dunn

modelna<-dunn_test (na ~ tipo, data=wildmeat1, p.adjust.method="bonferroni")
modelna

#Gráficos
naplot <- ggplot(wildmeat1, aes(x = type, y = na, fill = type)) +
  geom_boxplot() +
  xlab(NULL) +
  ylab("sodium content, g") +
  theme_bw() +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        text = element_text(size = 20),
        title = element_text(size = 22))

print(naplot)
ggsave("na.png", naplot, width = 15, height = 15, dpi = 600)


##############TESTE K - KRUSKAL-WALLIS###################

modelk <- lm(k ~ tipo, data = wildmeat1)
modelk


#Pressupostos
autoplot(modelk)

shapiro.test(modelk$residuals) #p-value = 0.02408

##Teste de Kruskal-Walllis ------------------------------

kruskal.test(k ~ tipo, data=wildmeat1) 

#teste a posteriori: teste de Dunn

modelk<-dunn_test (k ~ tipo, data=wildmeat1, p.adjust.method="bonferroni")
modelk

#Gráficos
kplot <- ggplot(wildmeat1, aes(x = type, y = k, fill = type)) +
  geom_boxplot() +
  xlab(NULL) +
  ylab("potassium content, g") +
  theme_bw() +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        text = element_text(size = 20),
        title = element_text(size = 22))

print(kplot)
ggsave("k.png", kplot, width = 15, height = 15, dpi = 600)

##############TESTE PTN - KRUSKAL-WALLIS###################

modelptn1 <- lm(ptn ~ tipo, data = wildmeat1)
modelptn1


#Pressupostos
autoplot(modelptn1)

shapiro.test(modelptn1$residuals) #p-value = 0.0000007099
options(scipen = 999) 

##Teste de Kruskal-Walllis ------------------------------ 

kruskal.test(ptn ~ tipo, data=wildmeat1) #p=0.004149

#teste a posteriori: teste de Dunn

modelptn1<-dunn_test (ptn ~ tipo, data=wildmeat1, p.adjust.method="bonferroni")
modelptn1

#Gráficos
ptnplot <- ggplot(wildmeat1, aes(x = type, y = ptn, fill = type)) +
  geom_boxplot() +
  xlab(NULL) +
  ylab("protein content, g") +
  theme_bw() +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        text = element_text(size = 20),
        title = element_text(size = 22))

print(ptnplot)
ggsave("ptn.png", ptnplot, width = 15, height = 15, dpi = 600)

##############TESTE LIP - KRUSKAL-WALLIS###################

modellip1 <- lm(lip ~ tipo, data = wildmeat1)
modellip1


#Pressupostos
autoplot(modellip1)

shapiro.test(modellip1$residuals) #p-value = 0.0001092

##Teste de Kruskal-Walllis ------------------------------ p=

kruskal.test(lip ~ tipo, data=wildmeat1) 

#teste a posteriori: teste de Dunn

modellip1<-dunn_test (lip ~ tipo, data=wildmeat1, p.adjust.method="bonferroni")
modellip1

#Gráficos
lipplot <- ggplot(wildmeat1, aes(x = type, y = lip, fill = type)) +
  geom_boxplot() +
  xlab(NULL) +
  ylab("fat content, g") +
  theme_bw() +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        text = element_text(size = 20),
        title = element_text(size = 22))

print(lipplot)
ggsave("lip.png", lipplot, width = 15, height = 15, dpi = 600)

##############TESTE w3 - KRUSKAL-WALLIS###################

#modelw31 <- lm(w3 ~ tipo, data = wildmeat1)
#modelw31


#Pressupostos
#autoplot(modelw31)

#shapiro.test(modelw31$residuals) #p-value = 0.005627

##Teste de Kruskal-Walllis ------------------------------ p=

#kruskal.test(w3 ~ tipo, data=wildmeat1) 

##teste a posteriori: teste de Dunn

#modelw31<-dunn_test (w3 ~ tipo, data=wildmeat1, p.adjust.method="bonferroni")
#modelw31

#Gráficos
w3plot <- ggplot(wildmeat1, aes(x = tipo, y = w3, fill = tipo)) +
  geom_boxplot() +
  xlab(NULL) +
  ylab("conteúdo de w3, em g") +
  theme_bw() +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        text = element_text(size = 20),
        title = element_text(size = 22))

print(w3plot)
ggsave("w3.png", w3plot, width = 15, height = 15, dpi = 600)

##############TESTE w6 - KRUSKAL-WALLIS###################

modelw61 <- lm(w6 ~ tipo, data = wildmeat1)
modelw61


#Pressupostos
autoplot(modelw61)

shapiro.test(modelw61$residuals) #p-value = 0.00001904

##Teste de Kruskal-Walllis ------------------------------ p=

kruskal.test(w6 ~ tipo, data=wildmeat1) 

#teste a posteriori: teste de Dunn

modelw61<-dunn_test (w6 ~ tipo, data=wildmeat1, p.adjust.method="bonferroni")
modelw61

#Gráficos
w6plot <- ggplot(wildmeat1, aes(x = type, y = w6, fill = type)) +
  geom_boxplot() +
  xlab(NULL) +
  ylab("w6 content, g") +
  theme_bw() +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        text = element_text(size = 20),
        title = element_text(size = 22))

print(w6plot)
ggsave("w6.png", w3plot, width = 15, height = 15, dpi = 600)

write.csv(wildmeat, file = "/Users/michelle/Desktop/R/Luisa/wildmeat.csv")

install.packages("openxlsx")
library(openxlsx)
write.xlsx(wildmeat, file = "/Users/michelle/Desktop/R/Luisa/wildmeat.xlsx")
