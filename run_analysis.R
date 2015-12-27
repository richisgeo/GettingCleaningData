library(plyr)
library(doBy)
library(dplyr)

feat <- read.table("features.txt")
features <- c(feat)
features
testx <- read.table("test/X_test.txt", col.names= feat[,2])
trainx <- read.table("train/X_train.txt", col.names = feat[,2])
testall <- cbind(testx, testy)


testy <- read.table("test/y_test.txt", col.names= "Activity")
trainy <- read.table("train/y_train.txt", col.names = "Activity")
trainall <- cbind(trainx, trainy)

subtest <- read.table("test/subject_test.txt", col.names= "Subject")
subtrain <- read.table("train/subject_train.txt", col.names = "Subject")
suball <- rbind(subtest, subtrain)



df <- merge(testall,trainall,all=TRUE)
big <- cbind(df,suball)


colnames(big)

df_sub <- big[,grep("mean|std|Activity|Subject", colnames(big))]
colnames(df_sub)
 
  df_sub$act_r <- factor(df_sub$Activity,
                       levels = c(1,2,3,4,5,6),
                       labels = c("WALKING", "WALKING_UPSTAIRS","WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

head(colnames(df_sub), 5)


names(df_sub)[82]<-"Activity.Label"


df3 <- df_sub %>% group_by(Subject, Activity.Label) %>% summarise_each(funs(mean))
df3 <- df3[,-82]
write.table(df3,"tidy_project1.txt", row.name=FALSE)












