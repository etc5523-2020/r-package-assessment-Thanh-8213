library(shiny)
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(DT)
library(leaflet)
library(scales)
library(plotly)
library(icecovid19)
# data
data_total <- data_total
# Change the name a bit
data_total_newdaily <- data_total_newdaily
# Defining Function


## Function to add label (Give information when hover mouse on leaflet)

addLabel <- function(data) {
    data$Label <- paste0(
        '<b>', data$`Country/Region`, '</b><br>
    <table style="width:120px;">
    <tr><td>Confirmed:</td><td align="right">', data$confirmed, '</td></tr>
    <tr><td>Deceased:</td><td align="right">', data$deceased, '</td></tr>
    <tr><td>Estimated Recoveries:</td><td align="right">', data$recovered, '</td></tr>
    </table>'
    )
    data$Label <- lapply(data$Label, HTML)
    
    return(data)
}

## Function to summary data for table
summariseData <- function(df, groupBy) {
    df %>%
        group_by({{groupBy}}) %>%
        summarise(
            "Confirmed"            = sum(confirmed, na.rm = T),
            "Deceased"             = sum(deceased, na.rm = T),
            "Estimated Recoverd" = sum(recovered, na.rm = T),
        ) %>%
        as.data.frame()
}

# Function for summary data for plotly
summariseData_newdaily <- function(data){
    data %>%
        group_by(date) %>%
        summarise(value = sum(value))
}



# Function to draw the table
getSummaryDT <- function(data, groupBy, selectable = FALSE) {
    datatable(
        na.omit(summariseData(data, {{groupBy}})),
        caption = htmltools::tags$caption("Summary of Worldwide COVID19", style = "color:#002366; font-size: 22px; text-align:left"),
        rownames  = FALSE,
        options   = list(
            order          = list(1, "desc"),
            scrollX        = TRUE,
            scrollY        = 200,
            scrollCollapse = T,
            paging         = FALSE
        ),
        selection = ifelse(selectable, "single", "none")
    )
}


# Function for UI slider input

sliderDateinput <- function(inputId, 
                            label = "Select date",
                            x, ...){
  shiny::sliderInput(inputId = inputId, 
                     label = label,
                     min = min(x),
                     max = max(x),
                     value = max(x),
                     width = "100%",
                     timeFormat = "%d/%m/%Y")
}


# Define UI for application
ui <-   navbarPage(
    title = div("COVID-19 Global Cases - ETC5523", style = "padding-left: 10px"),
    # Overview Panel    
    tabPanel("Overview",
             fluidRow(
                 column(sliderDateinput("timeSlider", x = data_total$date),
                     width = 12,
                     style = 'padding-left:15px; padding-right:15px;'
                 ),
                 column(leafletOutput(outputId = 'overview_map'),
                        width = 8,
                        style = 'padding-right:15px;'),
                 column(dataTableOutput(outputId = "summaryDT_country"),
                        width = 4,
                        style = 'padding-left:15px;')
             )),
    tabPanel("Plots",
             fluidRow(plotlyOutput(outputId = "plotly_plot_overall")),
             fluidRow(
                 column(
                    selectInput(
                     inputId  = "cases_var",
                     label    = "Select the type of cases",
                     choices  = unique(data_total_newdaily$var),
                     selected = unique(data_total_newdaily$var)[1]
                 ),
                    width = 2,
                    style = 'padding-left:15px'),
                 column(
                    plotlyOutput(outputId = "plotly_plot"),
                    width = 8,
                    style = 'padding:15px')
                 ),
             fluidRow(column(
                 textOutput(outputId = "plotlyClick"),
                 style = "font-size:24px; color:  #003366; padding-bottom: 40px; margin-top: -15px;",
                 width = 10)
                 ),
             fluidRow(
                 column(
                     "The first graph shows the overal trend of COVID19 worldwide.",
                     tags$br(),
                     "The second graph shows the number of COVID19 cases per criteria (Selected in the box)",
                     width = 10)
                 )
             ),
 
# Writing this in html is such a pain!!!! 
    tabPanel("About",
             fluidRow(
                 column(
                     h3("About this dashboard"),
                     
                     "This dashboard shows recent development of the COVID19 pandemic. The data is 
                     downloaded from", tags$a(href = "https://github.com/CSSEGISandData/COVID-19",
                                                      "Johns Hopkins CSSE"), 
                     ". Data is displayed in a map, a summary table and plots.",
                     tags$br(),
                     "The dashboard is heavily influenced by the work of", tags$a (href = "https://chschoenenberger.shinyapps.io/covid19_dashboard",
                     "Christoph Schoenenberger."), 
                     tags$br(),
                     "Instruction for using this dashboard is written in README.md file, attached in the same folder.",
                     h3("About the author"),
                     "This dashboard's author is Nguyen Dang Thanh - Monash University.",
                     h3("Data and Limitations"),
                     "The data is downloaded from", tags$a(href = "https://github.com/CSSEGISandData/COVID-19",
                                              "Johns Hopkins CSSE."),
                     tags$br(),
                     "The dashboard has some issues:",
                     tags$ul(
                         tags$li("The presentation of the dashboard is not very appealing due to author's lack of experience."),
                         tags$li("Some countries are mis-represented in the map, such as the United Kingdom, France and Netherland. The reason is the fact that those countries have oversea territories, which affect the final position of the country on the map.")
                     ),
                     tags$br(),
                     
                     width = 7, 
                     style = "padding-left: 20px; padding-right: 20px; padding-bottom: 40px; margin-top: -15px;"
                 )
             )
    )
)

# Define server logic 
server <- function(input, output) {

# Define reactive value to get data at certain date (For leaflet map and data table )
    data_at_date<- reactive({
        data_total %>% 
            filter (date == input$timeSlider)
    })

# Define reactive value for total variable (to use in plotly)
    cases_var <- reactive({
        data_total_newdaily %>%
            filter(var == input$cases_var)
    })

# Draw the leaflet map    
    output$overview_map <- renderLeaflet({
        leaflet() %>%
        setView(0, 40, zoom = 2) %>%
        addTiles() %>%
        addProviderTiles(providers$CartoDB.Positron, group = "Light") %>%
        addCircleMarkers(
            data         = addLabel(data_at_date()),
            lng          = ~Long,
            lat          = ~Lat,
            radius       = ~log(confirmed),
            stroke       = FALSE,
            color        = "#DC143C",
            fillOpacity  = 0.5,
            label        = ~Label,
            labelOptions = labelOptions(textsize = 15)
        )
    })
# Output summary data table   
    output$summaryDT_country <- renderDataTable(
        getSummaryDT(data_at_date(), `Country/Region`, selectable = TRUE))

# Output plotly
    # The big, overall plotly
    output$plotly_plot_overall <-  renderPlotly({
        plotly_overall <- data_total_newdaily %>%
            group_by(date, var) %>%
            summarise(value = sum(value)) %>%
            ggplot(aes(date, y = value, color = var)) +
            geom_line()+
            xlab("Date")+
            ylab("Number of cases")+
            ggtitle("Overall trend of COVID19")+
            scale_y_continuous(labels = comma)
        ggplotly(plotly_overall, source = "test")
    })
    
    # the smaller plotly for detailed data
    output$plotly_plot <- renderPlotly({
        plotly <- summariseData_newdaily(cases_var()) %>%
            ggplot(aes(x = date, y = value))+
            geom_line(color = "#DC143C")+
            xlab("Date")+
            ylab("Number of cases")+
            ggtitle("Evolution of COVID19 per criteria")+
            scale_y_continuous(labels = comma)
        ggplotly(plotly)
        
    })
    
    # The plotly_click event 
    output$plotlyClick <- renderText({
        clickData  <- event_data("plotly_click", source = "test") 
        if (is.null(clickData)) 
            return(NULL)
        paste("I wish you have good physical health and full of energy in this pandemic.")

    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
