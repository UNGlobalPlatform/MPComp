
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinyjs)
library(DT)
shinyServer(function(input, output, session) {

#  osensitivity <- reactiveVal(c(12))
  # Material Properties
  
  # Reactive expression to compose a data frame containing all of the values
  
  output$radarPlot <- renderPlot({
    
    shinyjs::disable("sensitivity")    
    # Data must be given as the data frame, where the first cases show maximum.
    # This section is create the data frame with the min/max numbers for each row
    maxmin <- data.frame(
      sensitivity=c(12, 0),
      indentifies=c(12, 0),
      granularity=c(12, 0),
      recency=c(12, 0),
      reliability=c(12, 0),
      release=c(12, 0),
      audience=c(12, 0)
    )
    
    # This populates dat with the current values from UI drop down selectors
    
    mpnames <- c("Sensitivity", "Indentifies", "Granularity", "Recency", "Reliability", "Release", "Audience")
    
    # dat <- data.frame( 
    #   sensitivity=as.integer( c(input$sensitivity)),
    #   indentifies=as.integer( c(input$indentifies)),
    #   granularity=as.integer( c(input$granularity)),
    #   recency=as.integer( c(input$recency)),
    #   reliability=as.integer( c(input$reliability)),
    #   release=as.integer( c(input$release)),
    #   audience=as.integer( c(input$audience))
    # )
    

    #add a data set to the plot
    dat <- data.frame( 
      sensitivity=as.integer( 0), #8
      indentifies=as.integer( 0), #6
      granularity=as.integer( 8),
      recency=as.integer( 6),
      reliability=as.integer(4),
      release=as.integer( 0), #6
      audience=as.integer(0)
    )
    
    #add a second data set to the plot
    datp2 <- data.frame( 
      sensitivity=as.integer( 4),
      indentifies=as.integer( 12),
      granularity=as.integer( 4),
      recency=as.integer( 0),
      reliability=as.integer(8),
      release=as.integer( 0),
      audience=as.integer(0)
    )

    #add a third data set to the plot
    dmax <- data.frame( 
      sensitivity=as.integer( 4),
      indentifies=as.integer( 12),
      granularity=as.integer( 8),
      recency=as.integer( 6),
      reliability=as.integer(8),
      release=as.integer( 0),
      audience=as.integer(0)
    )    
    # Merges actual data with min/max data for mp plot
    if(3==as.integer(c(input$rb))){
      colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.7,0.5,0.1,0.9) , rgb(0.8,0.2,0.5,0.9) )
      colors_in=c(  rgb(0.7,0.5,0.1,0.4), rgb(0.3,0.2,0.5,0.4) ,rgb(0.8,0.4,0.8,0.1) )
      mpdat <- rbind(maxmin,dat, datp2, dmax)}
    else{
      if(2==as.integer(c(input$rb))){
#        colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
        colors_border=c( rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) , rgb(0.2,0.5,0.5,0.9))
        colors_in=c(  rgb(0.3,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) , rgb(0.2,0.5,0.5,0.4))
        mpdat <- rbind(maxmin, datp2)}
      else {
        colors_border=c( rgb(0.8,0.2,0.5,0.9) , rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
        colors_in=c(  rgb(0.7,0.5,0.1,0.4), rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4)  )
        mpdat <- rbind(maxmin,dat)}
    }
    
#    colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
#    colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )
    
    radarchart(mpdat, axistype=0, seg=3, plwd=2 ,plty=1, pcol=colors_border, pfcol=colors_in,  vlabels=mpnames,
# title="ONS MPoD Radar v1.4",,vlcex=1.4)}
title="ONS MPoD Radar v1.5",vlcex=1.0)},
height = function() {
      session$clientData$output_radarPlot_width
    }
  ) 

SensitivityLable<-c("Open Public","Commercial","Private Personal", "Secret")
IdentifiesLable<-c("Non Personal","Groups","Individuals")
GranularityLable<-c("Population","Sample","Record", "Field Variable")
RecencyLable<-c("Historical","Periodic","Real-time")
ReliabilityLable<-c("Complete","Substantial","Patchy", "Incomplete")  
ReleaseLable<-c("Open","Restricted","Closed")                              
AudienceLable<-c("Public","Third Parties by type","Closed Group", "Named")
  
  
    
output$mpValues <- renderUI({
  if(3==as.integer(c(input$rb))){
    str1 <- paste("Sensitivity : ",SensitivityLable[8/4+1])
    str2 <- paste("Indentifies : ",IdentifiesLable[6/6+1])
    str3 <- paste("Granularity : ",GranularityLable[8/4+1])
    str4 <- paste("Recency : ",RecencyLable[6/6+1])
    str5 <- paste("Reliability : ",ReliabilityLable[8/4+1])
    str6 <- paste("Release : ",ReleaseLable[6/6+1])
    str7 <- paste("Audience : ",AudienceLable[0/4+1])    
    }
  else{
    if(2==as.integer(c(input$rb))){
      str1 <- paste("Sensitivity : ",SensitivityLable[4/4+1])
      str2 <- paste("Indentifies : ",IdentifiesLable[12/6+1])
      str3 <- paste("Granularity : ",GranularityLable[4/4+1])
      str4 <- paste("Recency : ",RecencyLable[0/6+1])
      str5 <- paste("Reliability : ",ReliabilityLable[8/4+1])
      str6 <- paste("Release : ",ReleaseLable[0/6+1])
      str7 <- paste("Audience : ",AudienceLable[0/4+1])      
    }
    else {
      str1 <- paste("Sensitivity : ",SensitivityLable[0/4+1]) #12
      str2 <- paste("Indentifies : ",IdentifiesLable[0/6+1]) #6
      str3 <- paste("Granularity : ",GranularityLable[8/4+1])
      str4 <- paste("Recency : ",RecencyLable[6/6+1])
      str5 <- paste("Reliability : ",ReliabilityLable[4/4+1])
      str6 <- paste("Release : ",ReleaseLable[0/6+1])#6
      str7 <- paste("Audience : ",AudienceLable[0/4+1])
}
  }
  #sensitivity=as.integer( 6),
  #indentifies=as.integer( 3),
  #granularity=as.integer( 9),
  #recency=as.integer( 6),
  #reliability=as.integer(3),
  #release=as.integer( 6),
  #audience=as.integer(Third Parties by type)
  # selectInput("sensitivity", "Sensitivity:",("Open Public"=0,"Commercial"=4,"Private Personal"=8, "Secret"=12), selected = "osensitivity"),
  # selectInput("indentifies", "Identifies:",("Non Personal"=0,"Groups"=6,"Individuals"=12)),  
  # selectInput("granularity", "Granularity:",("Population"=0,"Sample"=4,"Record"=8, "Field Variable"=12)),
  # selectInput("recency", "Recency:",("Historical"=0,"Periodic"=6,"Real-time"=12)),   
  # selectInput("reliability", "Reliability:",t("Incomplete"=0,"Patchy"=4,"Substantial"=8, "Complete"=12)),  
  # selectInput("release", "Release:",("Closed"=0,"Restricted"=6,"Open"=12)),                              
  # selectInput("audience", "Audience:",("Named"=0,"Closed Group"=4,"Third Parties by type"=8, "Public"=12))
  
  #  HTML(paste('<hr/>',str1, str2,str3, str4,str5, str6,str7, sep = '<br/>'))
  
  HTML(paste(str1, str2,str3, str4,str5, str6,str7, sep = '<br/>'))
  
  
})

})
