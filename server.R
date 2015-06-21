library(shiny)
library(ggplot2)

# Read the data 
data_stock <- read.csv('DevDataProdRegData.csv', header = TRUE, sep = ",")

# Get the summary of the data stored in the data frame data_stock
sumdata_stock <- summary(data_stock)

# Compute the correlation between the log return of GE and the S&P 500
correlation_GESP500 <- cor(data_stock$lnadjcloseGE, data_stock$lnadjcloseSP500)
print(correlation_GESP500)

# Look at the histogram of the data
histlogGE <- qplot(data_stock$lnadjcloseGE) + 
    geom_histogram(colour = "blue", fill = "lightblue", binwith = .05) + 
    ggtitle("Histogram Log Return GE") + xlab("Log Return GE") + 
    ylab("Frequency")
histlogSP500 <- qplot(data_stock$lnadjcloseSP500) + 
    geom_histogram(colour = "blue", fill = "lightblue", binwith = .05) + 
    ggtitle("Histogram Log Return GE") + 
    xlab("Log Return GE") + 
    ylab("Frequency")

# Fit a linear regression model log return of GE and S&P 500
lmfitGEvsSP500 <- lm(data_stock$lnadjcloseGE ~ data_stock$lnadjcloseSP500)
print(lmfitGEvsSP500)

# Print the information about the model
sum_lmfitGEvsSP500 <- summary(lmfitGEvsSP500)
print(sum_lmfitGEvsSP500)

# Scatter Plot of data + Regression line
scatterGESP500 <- ggplot(data_stock, aes(lnadjcloseSP500, lnadjcloseGE)) + 
    geom_point(colour = "red") + 
    ggtitle("Scatterplot Log Return GE vs Log ReturnS&P 500") + 
    xlab("Log Return S&P 500") + 
    ylab("Log Return GE") + 
    geom_smooth(method=lm, se=FALSE)
print(scatterGESP500)

# Predict the values
data_pred <- predict(lmfitGEvsSP500)

# Get the residuals
residuals <- data_stock$lnadjcloseGE - data_pred
data_predres <- data.frame(residuals, data_pred)

# Scatter plot of residuals vs predicted
scatterresidualsvspredicted <- ggplot(data_predres, aes(residuals, data_pred)) + 
    geom_point(colour = "red") + 
    ggtitle("Scatterplot Residuals vs Predicted") + 
    xlab("Predicted") + 
    ylab("Residuals") 
print(scatterresidualsvspredicted)

shinyServer(function(input, output) { 
  output$contenttable <- renderTable({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    file_name <- as.character(inFile$datapath)
    
    read.table(inFile$datapath, header = input$header,
             sep = input$sep, quote = input$quote) 
  })
  
  data_example <- read.table("CustomHistory.txt", header = TRUE, sep = "\t")
  
  output$data_example_dim_one <- renderText({
      print(dim(data_example)[1])
  })
  
  output$data_example_dim_two <- renderText({
      print(dim(data_example)[2])
  })
  
  output$sumdataMeanTF <- renderText({
      print(summary(data_example[1:dim(data_example)[1],3]))
  })
  
  output$sum_lnadjcloseGE <- renderText({
      sum_lnadjcloseGE <- summary(data_stock$lnadjcloseGE)
      print(sum_lnadjcloseGE <- summary(data_stock$lnadjcloseGE))
  })
  
  output$sum_lnadjcloseSP500 <- renderText({
      sum_lnadjcloseSP500 <- summary(data_stock$lnadjcloseSP500)
      print(sum_lnadjcloseSP500)
  })
  
  output$correlation_GESP500 <- renderText({
      correlation_GESP500 <- cor(data_stock$lnadjcloseGE, data_stock$lnadjcloseSP500)
      print(correlation_GESP500)
  })
  
  output$histlogGE <- renderPlot({
      histlogGE <- qplot(data_stock$lnadjcloseGE) + 
        geom_histogram(colour = "blue", fill = "lightblue", binwith = .05) + 
        ggtitle("Histogram Log Return GE") + 
        xlab("Log Return GE") + ylab("Frequency")
        print(histlogGE)
        })
  
  output$histlogSP500 <- renderPlot({
      histlogSP500 <- qplot(data_stock$lnadjcloseSP500) + 
          geom_histogram(colour = "blue", fill = "lightblue", binwith = .05) + 
          ggtitle("Histogram Log Return GE") + 
          xlab("Log Return GE") + 
          ylab("Frequency")
      print(histlogSP500)
  })
  
  output$lmfitGEvsSP500Call <- renderText({
      lmfitGEvsSP500 <- lm(data_stock$lnadjcloseGE ~ data_stock$lnadjcloseSP500)
      sum_lmfitGEvsSP500 <- summary(lmfitGEvsSP500)
  })
  
  output$lmfitGEvsSP500estintercept <- renderText({
      lmfitGEvsSP500estintercept <-as.numeric(sum_lmfitGEvsSP500$coefficients[1,1])
  })
  
  output$lmfitGEvsSP500stderintercept <- renderText({
      lmfitGEvsSP500stderintercept <-as.numeric(sum_lmfitGEvsSP500$coefficients[1,2])
  })
  
  output$lmfitGEvsSP500tvalintercept <- renderText({
      lmfitGEvsSP500tvalintercept <-as.numeric(sum_lmfitGEvsSP500$coefficients[1,3])
  })
  
  output$lmfitGEvsSP500pvalintercept <- renderText({
      lmfitGEvsSP500pvalintercept <-as.numeric(sum_lmfitGEvsSP500$coefficients[1,4])
  })
  
  output$lmfitGEvsSP500estslope <- renderText({
      lmfitGEvsSP500estslope <-as.numeric(sum_lmfitGEvsSP500$coefficients[2,1])
  })
  
  output$lmfitGEvsSP500stderslope <- renderText({
      lmfitGEvsSP500stderslope <-as.numeric(sum_lmfitGEvsSP500$coefficients[2,2])
  })
  
  output$lmfitGEvsSP500tvalslope <- renderText({
      lmfitGEvsSP500tvalslope <-as.numeric(sum_lmfitGEvsSP500$coefficients[2,3])
  })
  
  output$lmfitGEvsSP500pvalslope <- renderText({
      lmfitGEvsSP500pvalslope <-as.numeric(sum_lmfitGEvsSP500$coefficients[2,4])
  })
  
  output$lmfitGEvsSP500resstderror <- renderText({
      lmfitGEvsSP500resstderror <-as.numeric(sum_lmfitGEvsSP500$sigma)
  })
  
  output$lmfitGEvsSP500rsquared <- renderText({
      lmfitGEvsSP500rsquared <-as.numeric(sum_lmfitGEvsSP500$r.squared)
  })
  
  output$lmfitGEvsSP500fstatistic <- renderText({
      lmfitGEvsSP500fstatistic <-as.numeric(sum_lmfitGEvsSP500$fstatistic)
  })
  
  output$lmfitGEvsSP500Residuals <- renderText({
      sum_residuals <- summary(lmfitGEvsSP500$residuals)
      print(sum_residuals)
  })
  
  output$scatterGESP500 <- renderPlot({
      scatterGESP500 <- ggplot(data_stock, aes(lnadjcloseSP500, lnadjcloseGE)) + 
          geom_point(colour = "red") + 
          ggtitle("Scatterplot Log Return GE vs Log ReturnS&P 500") + 
          xlab("Log Return S&P 500") + 
          ylab("Log Return GE") + 
          geom_smooth(method=lm, se=FALSE)
      print(scatterGESP500)
  })
  
  output$scatterresidualsvspredicted <- renderPlot({
      scatterresidualsvspredicted <- ggplot(data_predres, aes(residuals, data_pred)) + 
          geom_point(colour = "red") + 
          ggtitle("Scatterplot Residuals vs Predicted") + 
          xlab("Predicted") + 
          ylab("Residuals") 
      print(scatterresidualsvspredicted)
  })
})