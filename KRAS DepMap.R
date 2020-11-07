getwd()

depmap<- read.csv("https://ndownloader.figshare.com/files/24613394")

install.packages("readxl")
library("readxl")
library("ggplot2")
install.packages("mudata")
library(mudata)
bioportal = read_excel("C:/Users/groot/Documents/Datasets/KRAS cBioportal subset.xlsx")
head(bioportal)

#dropping columns other than cell line and lineage
colnames(depmap)

depmap1 <- depmap[-c(2,4:21)]
colnames(depmap1)

#renaming column in depmap
names(depmap1)[names(depmap1) == "CCLE_Name"] <- "Sample ID"
colnames(depmap1)

#categorizing oncoKB annotation in two groups- oncogenic and non oncogenic
bp <- bioportal
bp$`OncoKb Annotation` <- as.character(bp$`OncoKb Annotation`)
bp$`OncoKb Annotation`[bp$`OncoKb Annotation` == "Oncogenic, level_3b"] <- "Oncogenic"
bp$`OncoKb Annotation`[bp$`OncoKb Annotation` == "Oncogenic, level_4"] <- "Oncogenic"
bp$`OncoKb Annotation`[bp$`OncoKb Annotation` == "Unknown, level NA"] <- "Non-Oncogenic"
bp$`OncoKb Annotation`[bp$`OncoKb Annotation` == "Likely Oncogenic, level_4"] <- "Non-Oncogenic"
head(bp)

#merge the datasets
df <- merge(x=bp,y=depmap1,by="Sample ID",all.x=TRUE)
head(df)
colnames(df)

#write.csv(df, file = "KRAS Final Data.csv")

# by lineage
ggplot(df, aes(x= df$lineage)) +
  geom_bar() +
  facet_wrap(~df$`OncoKb Annotation`)

#by lineage subtype
ggplot(df, aes(x= df$lineage_subtype)) +
  geom_bar() +
  facet_wrap(~df$`OncoKb Annotation`)

#by lineage sub-subtype
ggplot(df, aes(x= df$lineage_subtype)) +
  geom_bar() +
  facet_wrap(~df$`OncoKb Annotation`)
