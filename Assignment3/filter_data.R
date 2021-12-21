# Filter the original data
# The full data is from OSF data storage https://osf.io/pyb8s/ 
rm(list=ls())
library(dplyr)
dt <-read.csv('https://osf.io/g72pq/download',encoding = "UTF-8")
#dt <-read.csv('data.csv', encoding = "UTF-8")
dt <- dt[c(2:31,127,128)] # ignore individual question scores, we are interested in the overall correctness

summary(dt)

## VARIABLES I WOULD DEFINITELY USE: 
# age, 
dt %>%  group_by(age) %>% count() %>% arrange(desc(n))
# gender, 
dt %>%  group_by(gender) %>% count() %>% arrange(desc(n))
# natlangs/nat_eng, 
dt %>%  group_by(natlangs) %>% count() %>% arrange(desc(n))
dt %>%  group_by(nat_Eng) %>% count() %>% arrange(desc(n))
# primelangs/prime_eng, 
dt %>%  group_by(primelangs) %>% count() %>% arrange(desc(n))
dt %>%  group_by(prime_Eng) %>% count() %>% arrange(desc(n))
# psychiatric
dt %>%  group_by(psychiatric) %>% count() %>% arrange(desc(n))
# highest level of education
dt %>%  group_by(education) %>% count() %>% arrange(desc(n))
# Eng_start
dt %>%  group_by(Eng_start) %>% count() %>% arrange(desc(n))
# Eng_little
dt %>%  group_by(Eng_little) %>% count() %>% arrange(desc(n))
# correct / elogit
dt %>%  group_by(correct) %>% count() %>% arrange(desc(n))

## VARIABLES NOT TO USE:
# dyslexia --> No variation
# Eng_country_yrs --> too much NAs
# already_participated --> No variation
# dictionary --> No variation
# US_region, UK_region, Can_region --> no relevance in the research question
# Ebonics --> no relevance
# Lived_Eng_per ---> too much NAs 
 

## QUESTIONABLE VARIABLES: 
#   house_Eng
dt %>%  group_by(house_Eng) %>% count() %>% arrange(desc(n)) # --- too much NULL values
#   countries
dt %>%  group_by(countries) %>% count() %>% arrange(desc(n)) # too much distinct values
#   currcountry
dt %>%  group_by(currcountry) %>% count() %>% arrange(desc(n)) # too much distinct values

dt<-dt %>% select(id, age, gender, education,
                  natlangs,nat_Eng, primelangs, prime_Eng,
                  house_Eng,countries, currcountry, psychiatric,
                  Eng_start, Eng_little, correct, elogit)

## filter Eng_little to include just monoeng (native speaker of english only) and little=non-immersion learners
dt<-filter(dt, dt$Eng_little %in% c("monoeng", 'little'))

## clean and filter natlangs variable
langs<-head(dt %>%  group_by(natlangs) %>% count() %>% arrange(desc(n)),10)
dt<-filter(dt, dt$natlangs %in% langs$natlangs)

## clean and filter education variable
educ <- dt %>% group_by(education) %>% count() %>% arrange(desc(n))
head(educ,10)

dt$education<-lapply(dt$education,function(x){
  gsub("Didn't Finish",
       "Haven't Finished",
       x)
})


dt$education<-unlist(dt$education)
dt<-filter(dt,dt$education %in% educ$education[1:6])

# Select relevant variables
dt<- dt %>% select( age, gender, education, 
                    Eng_start, natlangs, nat_Eng, primelangs, prime_Eng,
                    psychiatric , correct, elogit, Eng_little ) %>% drop_na()

## Set base categories

dt <-dt %>% mutate(
  education=as.factor(education),
  natlangs = as.factor(natlangs),
  Eng_little = as.factor(Eng_little),
  education = relevel(education,ref = "Haven't Finished High School (less than 13 years ed)"),
  natlangs = relevel(natlangs, ref = "English"),
  Eng_little = relevel(Eng_little,ref = "monoeng")
  
)

write.csv(dt,file = "clean_data.csv", sep = ";")
rm(dt, educ, langs)
