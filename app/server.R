server <- function(input, output) {
  output$histPlot <- renderPlot({
    if (input$zero_inflated) {
      zero_inflated <- function(sample_data) {
        zero_inflated_sample <- ifelse(runif(length(sample_data)) < 0.5, 0, sample_data)
        return(zero_inflated_sample)
      }
    } else {
      zero_inflated <- function(sample_data) {
        return(sample_data)
      }
    }
    
    if (input$distribution == "Binomial") {
      data <- rbinom(input$size, input$trials, input$prob)
    } else if (input$distribution == "Poisson") {
      data <- rpois(input$size, input$lambda)
    } else {
      data <- rnorm(input$size, input$mean, input$sd)
    }
    
    data <- zero_inflated(data)
    
    if (input$log_transform) {
      data <- log(data + 1)
    }
    
    hist(data, main = paste(input$distribution, "Distribution Histogram"), xlab = "Value", ylab = "Frequency", col = "lightblue", border = "black")
  })
}
