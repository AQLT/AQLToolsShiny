
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(AQLTools)
library(XLConnect)
library(DT)

shinyServer(function(input, output) {
    data <- NULL

    
    output$table <- DT::renderDT({
        inFile <- input$file1
        if (!is.null(inFile)){
            data <<- readWorksheetFromFile(inFile$datapath, sheet = input$sheet_name,
                                          header = input$header) 
        }
        data
    }, editable = TRUE)
    
    proxy = dataTableProxy('table')
    observeEvent(input$table_cell_edit, {
        info = input$table_cell_edit
        str(info)
        i = info$row
        j = info$col
        v = info$value
        data[i, j] <<- DT::coerceValue(v, data[i, j])
        replaceData(proxy, data, resetPaging = FALSE)  # important
    })
    # if(!is.null(data)){
    #     
    # }
    
    output$text <- renderText({
        input$data_cell_edit
        if(is.null(data))
            return("toto")
        
        data[1, 1]
    })
})
