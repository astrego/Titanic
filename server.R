library(shiny)
library(RcppEigen)
library(rpart)
library(caret)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(randomForest)
library(party)
library(Metrics)



df1 <- read.csv("data/train.csv")
#Including some dummy variables for the "None" option
Dummyr <- rep(1,891)
Dummys <- rep(1,891)
Dummyt <- rep(1,891)
Dummyu <- rep(1,891)
Dummyx <- rep(1,891)
Dummyy <- rep(1,891)
Dummyz <- rep(1,891)
df1 <- cbind(Dummyr,Dummys,Dummyt,Dummyu,Dummyx,Dummyy,Dummyz,df1) 
# Some changes to the names of the values and the variables
df1$Survived[df1$Survived == 1] <- "Survived"
df1$Survived[df1$Survived == 0] <- "Died"
colnames(df1) <- gsub("Pclass", "PassengerClass", colnames(df1))
colnames(df1) <- gsub("Parch", "ParentsChildren", colnames(df1))
#Splitting the data in a training set and a test set
set.seed(1234)
set<-createDataPartition(y=df1$Survived,p=0.8,list=FALSE)
training = df1[ set,]
testing = df1[-set,]


source("model.R")


shinyServer(function(input, output,session) {
  
    output$tree <- renderPlot({
      
      
      j <- switch(input$var1, 
                  "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                  "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                  "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyr" = training$Dummyr)
      
      n <- switch(input$var2, 
                  "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                  "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                  "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummys" = training$Dummys)
      
      o <- switch(input$var3, 
                  "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                  "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                  "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyt" = training$Dummyt)
      
      q <- switch(input$var4, 
                  "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                  "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                  "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyu" = training$Dummyu)
      
      t <- switch(input$var5, 
                  "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                  "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                  "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyx" = training$Dummyx)
      
    
     v <- switch(input$var6, 
                 "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                 "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                 "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyy" = training$Dummyy)
      
    
     w <- switch(input$var7, 
                "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyz" = training$Dummyz)

    #Training the model
    test <- mod(j,n,o,q,t,v,w,input$minsplit,input$cp,training)
    
    
    #Getting the names right in the plot of the tree
    split.fun <- function(x, labs, digits, varlen, faclen)
    {
     
         
      for(i in 1:length(labs)) {
        
        labs<- gsub("^j",input$var1, labs)
        labs<- gsub("^n",input$var2, labs)
        labs<- gsub("^o",input$var3, labs)
        labs<- gsub("^q",input$var4, labs)
        labs<- gsub("^t",input$var5, labs)
        labs<- gsub("^v",input$var6, labs)
        labs<- gsub("^w",input$var7, labs)
        labs<- gsub("ParentsChildren","Parents/Children", labs)
        labs<- gsub("PassengerClass","Passenger Class", labs)
        labs<- gsub("SibSp","Siblings/Spouses", labs)
        labs<- gsub("Embarked","Port of Embarkation", labs)
      }
      labs
        
      }
        
    fancyRpartPlot(test,sub="",split.fun=split.fun)
    
    
  })
  output$accuracy <- renderText({ 
    
    
    
    j <- switch(input$var1, 
                "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyr" = training$Dummyr)
    
    n <- switch(input$var2, 
                "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummys" = training$Dummys)
    
    o <- switch(input$var3, 
                "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyt" = training$Dummyt)
    
    q <- switch(input$var4, 
                "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyu" = training$Dummyu)
    
    t <- switch(input$var5, 
                "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyx" = training$Dummyx)
    
    
    v <- switch(input$var6, 
                "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyy" = training$Dummyy)
    
    
    w <- switch(input$var7, 
                "Sex" = training$Sex,"Fare" = training$Fare, "SibSp" = training$SibSp, 
                "ParentsChildren" = training$ParentsChildren, "Embarked" = training$Embarked,
                "PassengerClass" = training$PassengerClass,"Age" = training$Age, "Dummyz" = training$Dummyz)
    
    test2 <- mod(j,n,o,q,t,v,w,input$minsplit,input$cp,training)
    
    colnames(testing) <- gsub(input$var1, "j", colnames(testing))
    colnames(testing) <- gsub(input$var2, "n", colnames(testing))
    colnames(testing) <- gsub(input$var3, "o", colnames(testing))
    colnames(testing) <- gsub(input$var4, "q", colnames(testing))
    colnames(testing) <- gsub(input$var5, "t", colnames(testing))
    colnames(testing) <- gsub(input$var6, "v", colnames(testing))
    colnames(testing) <- gsub(input$var7, "w", colnames(testing))
    prediction <- predict(test2,testing, type="class")
    ff <- (1 - ce(testing$Survived,prediction))*100
    
    
      paste("Accuracy:  ", round(ff,2), "%")      
    
  })
 
})