
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
    titlePanel("Visualisation graphique"),
    sidebarLayout(
        sidebarPanel(
            fileInput("file1", "Charger un fichier",
                      accept = c(
                          ".xls",
                          ".xlsx",
                          ".csv")
            ),
            tags$hr(),
            checkboxInput("if_sheet_num",
                          "Charger fichier par numéro de la feuille ?",
                          TRUE),
            conditionalPanel(
                condition="input.if_sheet_num==true",
                numericInput("sheet_name", "Numéro de la feuille", 1,
                             min = 1)
                ),
            conditionalPanel(
                condition="input.if_sheet_num==false",
                textInput("sheet_name","Nom de la feuille",value="")
            ),
            checkboxInput("header",
                          "Charger l'en-tête ?",
                          TRUE)
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Aperçu de la table",
                         DT::DTOutput("table"),
                         textOutput("text") ),
                tabPanel("Visualisation graphique")
            )
        )
    )
))
