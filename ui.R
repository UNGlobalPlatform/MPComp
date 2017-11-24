library(shiny)
library(shinyjs)   # CRAN installed, doc from https://github.com/daattali/shinyjs
library(shinyFiles)
library(fmsb)
library(DT)

# v1 need to get gui running correctly first then enhance with file access
# v1.1.1 renamed Material Properties to Data Sensitivity Framework

#source("UploadCSVModule.R")
#source("downloadCSVModule.R")


r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()

ui <- fluidPage(width = 720,
#                useShinyjs(),  # Include shinyjs
                
                fluidRow(column(3,tags$img(src="ons-logo.png", width=90)), 
                         column(9, textOutput("liu"),align = "right")
                ),

                mainPanel(width = 12,
                          tabsetPanel(
                            tabPanel("Overview", 
                                     h3("This is a PoC in R for viewing the Data Sensitivity Framework scores of a calculated data set from those of the input data sets"),
                                     img(src='MPComp-Overview.png', align = "centre", width=700),
                                     br(),
                                     h6("Version 1.1 by Neville de Mendonca & Mark Craddock")
                            ),

                            tabPanel("Data Sensitivity Framework", 
                                     h3("Display new the Data Sensitivity scores when using these data sets"),
                                     sidebarLayout(
                                       sidebarPanel(
                                         
                                         tagList(
                                           radioButtons("rbDataset",
                                                        label = "Show Data Sensitivity:",
                                                        choices = list("DS for Data set 1 (x)" = 1,"DS for Data set 2 (y)" = 2,"DS for f(x,y) inc x,y" = 3),
                                                        selected = 1),
                                           htmlOutput("mpValues")
                                           # disable editing to show a simplified screen version for video 
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
                                         
                                          #    use a fixed plot size for UNBigData2017 video
                                          #    plotOutput('radarPlot',height="auto")
                                         plotOutput('radarPlot',width = "450px")
                                       )
                                     )
                            )
                          ) # tabsetPanel
                ) # mainPanel
        ) # fluidPage


