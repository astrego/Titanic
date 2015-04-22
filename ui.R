# ui.R

shinyUI(fluidPage(
  
  tags$head(
    tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Abril+Fatface|Open+Sans|Courgette');
    

      body {
           
            background-color: #bfbfbf;
            background-image: url(titanic-P.jpg);
            background-repeat: no-repeat;
            
            
      }

      h1 {
        height: 30px;
        width: 900px;
        font-family: 'Abril Fatface';
        line-height: 1.1;
        font-size: 3em;
        margin: 0px;
        
               
      }
      
      h2 {
          
          width: 300px;
          background-color: rgba(0,0,0,0.5);
          color: white;
          border-radius: 10px;
          margin-left: 125px;
      }
      
      h6 {
            margin-top: 0px;
            
      }
    
    body {
            font-family: Open Sans;
          }
  
    .accuracy {
          
          width: 500px;
          background-color: rgba(0,0,0,0.5);
          color: white;
          border-radius: 10px;
          margin-left: 50px;
          margin-top: 40px;
        }

    .plottree {
          margin-top: 30px;
          
    }

    .about {
          height: 400px;
          background-color: white;
          padding: 10px;
    }

   .shiny-output-error { visibility: hidden; }
   .shiny-output-error:before { visibility: hidden; }

    .subtitel {
          font-size: 0.5em;
          align: left;
          border: -20px;
          margin-left: 4px;
          font-size: 0.5em;
          
    }
    
    p{
      height: 690px;
      background-color: white;
      padding: 10px;

    }

    .shiny-progress {
  top: 50% !important;
  left: 50% !important;
  margin-top: -100px !important;
  margin-left: -250px !important;
}
    
    "))
  ),
 
  
  headerPanel("Titanic", "Predicting the Survivors"),
  h5(class="subtitel",headerPanel("Predicting the Survivors")),
  
  sidebarLayout(
    sidebarPanel( 
    
    selectInput("var1", "Feature 1:",
                  c("Sex" = "Sex","Fare in $" = "Fare","Number of Siblings/Spouses" = "SibSp","Number of Parents/Children" = "ParentsChildren", 
                    "Port of Embarkation" = "Embarked","Passenger Class" = "PassengerClass","Age" = "Age","None" = "Dummyr"),selected="Sex"),
    
    selectInput("var2", "Feature 2",
                c("Sex" = "Sex","Fare in $" = "Fare","Number of Siblings/Spouses" = "SibSp","Number of Parents/Children" = "ParentsChildren", 
                  "Port of Embarkation" = "Embarked","Passenger Class" = "PassengerClass","Age" = "Age","None" = "Dummys"),selected="Dummys"),
      
    selectInput("var3", "Feature 3",
                c("Sex" = "Sex","Fare in $" = "Fare","Number of Siblings/Spouses" = "SibSp","Number of Parents/Children" = "ParentsChildren", 
                    "Port of Embarkation" = "Embarked","Passenger Class" = "PassengerClass","Age" = "Age","None" = "Dummyt"),selected="Dummyt"),
      
    selectInput("var4", "Feature 4",
                c("Sex" = "Sex","Fare in $" = "Fare","Number of Siblings/Spouses" = "SibSp","Number of Parents/Children" = "ParentsChildren", 
                   "Port of Embarkation" = "Embarked","Passenger Class" = "PassengerClass","Age" = "Age","None" = "Dummyu"),selected="Dummyu"),
             
    selectInput("var5", "Feature 5",
                c("Sex" = "Sex","Fare in $" = "Fare","Number of Siblings/Spouses" = "SibSp","Number of Parents/Children" = "ParentsChildren", 
                  "Port of Embarkation" = "Embarked","Passenger Class" = "PassengerClass","Age" = "Age", "None" = "Dummyx"),selected="Dummyx"),
    
    selectInput("var6", "Feature 6",
                c("Sex" = "Sex","Fare in $" = "Fare","Number of Siblings/Spouses" = "SibSp","Number of Parents/Children" = "ParentsChildren", 
                  "Port of Embarkation" = "Embarked","Passenger Class" = "PassengerClass","Age" = "Age", "None" = "Dummyy"),selected="Dummyy"),
    
    selectInput("var7", "Feature 7",
                c("Sex" = "Sex","Fare in $" = "Fare","Number of Siblings/Spouses" = "SibSp","Number of Parents/Children" = "ParentsChildren",
                  "Port of Embarkation" = "Embarked", "Passenger Class" = "PassengerClass","Age" = "Age", "None" = "Dummyz"),selected="Dummyz"),
    
    br(),
    sliderInput("minsplit", label = h6("Minimum of Splits"),
                min = 2, max = 200, value = 2, step=10, ticks=FALSE),
    br(),
    sliderInput("cp", label = h6("Complexity Parameter"),
                min = 0.01, max = 0.05, value = 0.01, step=0.01, ticks=TRUE)),
   
    
    mainPanel(
      
      tabsetPanel(
        tabPanel("Output", div(class="plottree",plotOutput("tree")), h3(class="accuracy",textOutput("accuracy"), align="center")),
        tabPanel("Help", p(class="help","With the Titanic app you can predict the rate of survival of death of the Titanic Disaster
                           . The app makes use of a training set and test set. The training set used for training the model
                           by using the decision tree technique. After selecting the features it will plot a tree. After that
                           it uses the model to make a prediction wiht the use of the test set. The results are shown in the accuracy 
                           box.",img(src="screenshot.png", height = 530, width = 530),br(), "With the Minimum of Splits you can set
                           the minimum number of observations that must exist in a node in order for a split to be
                           attempted.",br(),br(),"With the Complexity Parameter you can set a threshold. Any split that does not 
                           decrease the overall lack of fit by a factor of the threshold is not attempted.")), 
        
       tabPanel("About", p(class="about",br(),br(),"Title: Titanic",br(),"Author: Karlan Astrego",br(),"Version 1.0",br(),
                            br(), "The data used in this app is from Kaggle.com.",br(),br(),
                            "This app was a project for the 'Developing Data Products' Course from Coursera and the John Hopkins University.",
                            br(),br(),"You can find the code on Github:",a(href="https://github.com/astrego/Titanic",span("https://github.com/astrego/Titanic")),a(href= "https://www.coursera.org/specialization/jhudatascience/1?utm_medium=listingPage",img(src="coursera.jpg",
                            a(href= "https://www.kaggle.com",img(src="kaggle.png",height = 200, width = 190))))))
      )
               
      )
  )
))
