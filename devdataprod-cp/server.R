library(shiny)
library(ggplot2)

myData <- mtcars

shinyServer(
    
    function(input, output) {
        
        myXY <- reactive({
            paste("mpg ~", "as.integer(", input$x,")")
        })
        
        myFit <- reactive({
            lm(as.formula(myXY()),data=myData)
        })
        
        output$text <- renderText({
            paste("Regression Model:", "mpg ~", input$x)
        })
        
        output$myPlot <- renderPlot ({
            
            with(myData, {
                plot(as.formula(myXY()),xlab=input$x,ylab="mpg")
                abline(myFit(),col=input$color)
            })
            
        })
        
    }
    
    )