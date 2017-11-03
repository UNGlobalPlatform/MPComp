library(shiny)
library(shinyjs)   # CRAN installed, doc from https://github.com/daattali/shinyjs
library(shinyFiles)
library(fmsb)
library(DT)

# v1 need to get gui running correctly first then enhance with file access

#source("UploadCSVModule.R")
#source("downloadCSVModule.R")


r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()

ui <- fluidPage(width = 720,
                useShinyjs(),  # Include shinyjs
                
                
                fluidRow(column(3,tags$img(src="ons-logo.png", width=90)), #180
                         column(9, textOutput("liu"),align = "right")
                ),
#                br(),
                

                mainPanel(width = 12,
                          tabsetPanel(
                            tabPanel("Overview", 
                                     h3("This is a PoC in R for viewing the Material Properties of a calculated data set from those of the input data sets"),
                                     img(src='MPComp-Overview.png', align = "centre", width=700),
                                     br(),
                                     h6("Version 1.03 by Neville de Mendonca & Mark Craddock")
                            ),

                            tabPanel("Material Properties", 
                                     h3("Display new the Material Properties when using these data sets"),
                                     sidebarLayout(
                                       sidebarPanel(
                                         
                                         tagList(
                                            #   checkboxInput(inputId="ind2", label="Include D2"),
                                           
                                           radioButtons("rb",
                                                        label = "Show Material Properties:",
                                                        choices = list("MP for Data set 1 (x)" = 1,"MP for Data set 2 (y)" = 2,"MP for f(x,y) inc x,y" = 3),
                                                        selected = 1),
                                           htmlOutput("mpValues")
                                           
                                           # selectInput("sensitivity", "Sensitivity:", 
                                           #             list("Open Public"=0,"Commercial"=4,"Private Personal"=8, "Secret"=12), selected = "osensitivity"),
                                           # 
                                           # selectInput("indentifies", "Identifies:", 
                                           #             list("Non Personal"=0,"Groups"=6,"Individuals"=12)),  
                                           # 
                                           # selectInput("granularity", "Granularity:",
                                           #             list("Population"=0,"Sample"=4,"Record"=8, "Field Variable"=12)),
                                           # 
                                           # selectInput("recency", "Recency:",
                                           #             list("Historical"=0,"Periodic"=6,"Real-time"=12)),   
                                           # 
                                           # selectInput("reliability", "Reliability:",
                                           #             list("Incomplete"=0,"Patchy"=4,"Substantial"=8, "Complete"=12)),  
                                           # 
                                           # selectInput("release", "Release:",
                                           #             list("Closed"=0,"Restricted"=6,"Open"=12)),                              
                                           # 
                                           # selectInput("audience", "Audience:",
                                           #             list("Named"=0,"Closed Group"=4,"Third Parties by type"=8, "Public"=12))
                                         )  
                                       ),
                                       mainPanel(
#                                         plotOutput('radarPlot',height="auto")
                                         plotOutput('radarPlot',width = "450px")
                                       )
                                     )
                            
                            
                            )
                          )
                )
)


