
run_analysis<- function() {
        library(dplyr)
        file_xtest<-file("./UCI HAR Dataset/test/X_test.txt")
        file_ytest<-file("./UCI HAR Dataset/test/y_test.txt")
        file_xtrain<-file("./UCI HAR Dataset/train/X_train.txt")
        file_ytrain<-file("./UCI HAR Dataset/train/y_train.txt")
        file_subtrain<-file("./UCI HAR Dataset/train/subject_train.txt")
        file_subtest<-file("./UCI HAR Dataset/test/subject_test.txt")
        file_actlabels<-file("./UCI HAR Dataset/activity_labels.txt")
        file_var<-file("./UCI HAR Dataset/features.txt")
        datos_test<-read.table(file_xtest)
        datos_train<-read.table(file_xtrain)
        label_test<-read.table(file_ytest)
        label_train<-read.table(file_ytrain)
        variables<-read.table(file_var)
        namelabels<-read.table(file_actlabels)
        var_int<-c(1,2,3,4,5,6,41,42,43,44,45,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)
        datosdep_test<-datos_test[,var_int]
        datosdep_train<-datos_train[,var_int]
        var_dep<-as.vector(variables[var_int,2])
        datos<-merge(datosdep_test,datosdep_train, all=TRUE)
        names(datos)<-var_dep
        labels<-rbind(label_test,label_train)
        names(labels)<-"Labels"
        datos<-cbind(datos,labels)
        names(namelabels)<-c("Labels","Activity")
        resultado<-merge(datos,namelabels, by="Labels")
        datos<-resultado[,2:67]
        datos<-group_by(datos,Activity)
        resultado<-summarise_each(datos,funs(mean))
        resultado
}
