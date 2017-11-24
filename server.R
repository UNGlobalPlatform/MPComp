
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinyjs)
library(DT)

shinyServer(function(input, output, session) {

  # Material Properties
  
  # Reactive expression to compose a data frame containing all of the values
  
  output$radarPlot <- renderPlot({
    
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
    

    # simplify screen for the demo video by removing the ability to change MP values
    # dat <- data.frame( 
    #   sensitivity=as.integer( c(input$sensitivity)),
    #   indentifies=as.integer( c(input$indentifies)),
    #   granularity=as.integer( c(input$granularity)),
    #   recency=as.integer( c(input$recency)),
    #   reliability=as.integer( c(input$reliability)),
    #   release=as.integer( c(input$release)),
    #   audience=as.integer( c(input$audience))
    # )
    

    #add a data set to the plot  ... normally loaded from a file
    dat <- data.frame( 
      sensitivity=as.integer( 0), 
      indentifies=as.integer( 0), 
      granularity=as.integer( 8),
      recency=as.integer( 6),
      reliability=as.integer(4),
      release=as.integer( 0), 
      audience=as.integer(0)
    )
    
    #add a second data set to the plot ... normally loaded from a file
    datp2 <- data.frame( 
      sensitivity=as.integer( 4),
      indentifies=as.integer( 12),
      granularity=as.integer( 4),
      recency=as.integer( 0),
      reliability=as.integer(8),
      release=as.integer( 0),
      audience=as.integer(0)
    )

    #add a third data set of the largest values on each dimension to the plot
    dmax <- data.frame( 
      sensitivity=as.integer( 4),
      indentifies=as.integer( 12),
      granularity=as.integer( 8),
      recency=as.integer( 6),
      reliability=as.integer(8),
      release=as.integer( 0),
      audience=as.integer(0)
    ) 
    
    # Merges actual data with min/max data for mp plot and sets colours
    if(3==as.integer(c(input$rbDataset))){
      colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.7,0.5,0.1,0.9) , rgb(0.8,0.2,0.5,0.9) )
      colors_in=c(  rgb(0.7,0.5,0.1,0.4), rgb(0.3,0.2,0.5,0.4) ,rgb(0.8,0.4,0.8,0.1) )
      mpdata <- rbind(dat, datp2, dmax)}
#    mpdat <- rbind(maxmin,dat, datp2, dmax)}
    else{
      if(2==as.integer(c(input$rbDataset))){
        colors_border=c( rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) , rgb(0.2,0.5,0.5,0.9))
        colors_in=c(  rgb(0.3,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) , rgb(0.2,0.5,0.5,0.4))
        mpdata <-  datp2}
#      mpdat <- rbind(maxmin, datp2)}
    else {
        colors_border=c( rgb(0.8,0.2,0.5,0.9) , rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
        colors_in=c(  rgb(0.7,0.5,0.1,0.4), rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4)  )
        mpdata <- dat}
  #    mpdat <- rbind(maxmin,dat)}
    }
    mpmax <- pmax(mpdata)
    mpdat <- rbind(maxmin,mpdata)
    
#    colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
#    colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )
    
    radarchart(mpdat, axistype=0, seg=3, plwd=2 ,plty=1, pcol=colors_border, pfcol=colors_in,  vlabels=mpnames, title="ONS Data Sensitivity Radar v1.6",vlcex=1.0)},
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
    if(3==as.integer(c(input$rbDataset))){
      str1 <- paste("Sensitivity : ",SensitivityLable[4/4+1])#8
      str2 <- paste("Indentifies : ",IdentifiesLable[12/6+1])#6
      str3 <- paste("Granularity : ",GranularityLable[8/4+1])
      str4 <- paste("Recency : ",RecencyLable[6/6+1])
      str5 <- paste("Reliability : ",ReliabilityLable[8/4+1])
      str6 <- paste("Release : ",ReleaseLable[0/6+1])#6
      str7 <- paste("Audience : ",AudienceLable[0/4+1])    
    }
    else{
      if(2==as.integer(c(input$rbDataset))){
        str1 <- paste("Sensitivity : ",SensitivityLable[4/4+1])
        str2 <- paste("Indentifies : ",IdentifiesLable[12/6+1])
        str3 <- paste("Granularity : ",GranularityLable[4/4+1])
        str4 <- paste("Recency : ",RecencyLable[0/6+1])
        str5 <- paste("Reliability : ",ReliabilityLable[8/4+1])
        str6 <- paste("Release : ",ReleaseLable[0/6+1])
        str7 <- paste("Audience : ",AudienceLable[0/4+1])      
      }
      else {
        str1 <- paste("Sensitivity : ",SensitivityLable[0/4+1])
        str2 <- paste("Indentifies : ",IdentifiesLable[0/6+1]) 
        str3 <- paste("Granularity : ",GranularityLable[8/4+1])
        str4 <- paste("Recency : ",RecencyLable[6/6+1])
        str5 <- paste("Reliability : ",ReliabilityLable[4/4+1])
        str6 <- paste("Release : ",ReleaseLable[0/6+1])
        str7 <- paste("Audience : ",AudienceLable[0/4+1])
      }
    }
    
    HTML(paste(str1, str2,str3, str4,str5, str6,str7, sep = '<br/>'))
    
    
  }) #renderUI  for Material Properties Chart text value table 
  
}) #ShinyServer
