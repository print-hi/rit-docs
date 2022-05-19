library(shiny)
library(bs4Dash)
library(plotly)
library(shinyWidgets)
library(timevis)
library(vistime)
library(lubridate)
library(gridExtra)

# install package: 
# install.packages("C:/Users/Alex/Documents/GitHub/retirement-toolkit/_health/3-state", repo = NULL, type = 'source')
#install.packages("/Users/alexxiao/Documents/GitHub/retirement-toolkit/_health/3-state", repo = NULL, type = 'source')

library(tshm)

table1 <- c("good", "bad", "ok")

ui <- dashboardPage(
    dark = NULL,
    header = dashboardHeader(
        title = dashboardBrand(
            title = "Retirement Toolkit",
            color = "indigo",
            href = "https://github.com/print-hi/retirement-toolkit",
            image = "https://raw.githubusercontent.com/print-hi/toolkit-live/main/img/25231.png",
        ),
        tags$head(tags$style(HTML('* {font-family: "Helvetica Neue"};')))
    ),
    sidebar = dashboardSidebar(
        sidebarMenu(
            id = "sidebarmenu",
            sidebarHeader("Tools"),
            menuItem(
                "Policy Valuation",
                tabName = "tab0",
                icon = icon("money-check-alt"),
                menuSubItem(
                    "Life Annuity",
                    tabName = "tab1a",
                    icon = icon("chevron-right"),
                ),
                menuSubItem(
                    "Care Annuity",
                    tabName = "tab1b",
                    icon = icon("chevron-right"),
                ),
                menuSubItem(
                    "Pooled Annuity",
                    tabName = "tab1c",
                    icon = icon("chevron-right"),
                ),
                menuSubItem(
                    "Variable Annuity",
                    tabName = "tab1d",
                    icon = icon("chevron-right"),
                ),
                menuSubItem(
                    "Reverse Mortgage",
                    tabName = "tab1e",
                    icon = icon("chevron-right"),
                ),
                menuSubItem(
                    "Account Based Pension",
                    tabName = "tab1f",
                    icon = icon("chevron-right"),
                )
            ),
            menuItem(
                "Aggregate Mortality",
                tabName = "tab2",
                icon = icon("book-medical")
            ),
            menuItem(
                "Health State",
                tabName = "tab3",
                icon = icon("wave-square"),
                
                
                menuSubItem(
                    '3 State Model', 
                    tabName = 'tab3a',
                    icon = icon('chevron-right')
                ), 
                
                
                menuSubItem(
                    '5 State Model',
                    tabName = 'tab3b',
                    icon = icon('chevron-right')
                )
                
            ),
            menuItem(
                "ESG",
                tabName = "tab4",
                icon = icon("sliders")
            )
        ),
        skin = "light",
        status = "indigo"
    ),
    body = dashboardBody(
        tabItems(
            tabItem(
                tabName = "tab1a",
                h1("Life Annuity"),
                hr(),
                chooseSliderSkin("Flat"),
                fluidRow(
                    column(3,
                           h4("Policy Details"),
                           tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: rgb(102, 16, 242)}")),
                           sliderInput('age1', 'Age',
                                       min=0, max=135, value=65,
                                       step=1, round=0),
                           numericInput('age2', 'Age', 65, 0, 135),
                    ),
                    column(4, offset = 1,
                           selectInput('x', 'Variable 1', table1),
                           selectInput('y', 'Variable 2', table1),
                           selectInput('color', 'Variable 3', table1)
                    ),
                    column(4,
                           selectInput('facet_row', 'Variable 4', table1),
                           selectInput('facet_col', 'Variable 5', table1)
                    )
                ),
                box(title = "Correlation Plot 1", plotlyOutput("corr_plot1", width = "100%"), width = 12),
                box(title = "Correlation Plot 2", plotlyOutput("corr_plot2", width = "100%"), width = 12)
            ),
            tabItem(
                tabName = "tab2",
                h1("Hey! You found me!")
            ),
            tabItem(
                tabName = 'tab3a',
                
                h1('3 State Health Module'), 
                hr(),
                
                p('Use this to gain insight on your survival statistics under the 
                  3 state model. The three states and their interactions can be seen
                  on the diagram below:'),
                
                HTML('<center><img src="/images/3_state_model.png" width="400"></center>'),
                
                br(),
                br(),
                hr(),
                br(),
                
                fluidRow(
                    
                    column(3,
                        h5('Model Details'),
                        br(),
                        sliderInput('init_age', 'Age',
                                    min = 65, max = 110, value = 65,
                                    step = 1, round = 0),
                        numericInput('init_age2', '',
                                     min = 65, max = 110, value = 65)
                    ),
                    
                    column(4, offset = 1,
                        selectInput('gender', h6('Gender'),
                                    choices = list('Male' = 0, 'Female' = 1), 
                                    selected = 0),
                        selectInput('init_state', h6('Health Status'),
                                    choices = list('Healthy' = 0, 'Disabled' = 1),
                                    selected = 0)
                    ),
                    
                    column(4, 
                        numericInput('year', h6('Year'), 
                                     value = as.numeric(format(Sys.Date(), '%Y'))),
                        selectInput('model_type', h6('Model'),
                                    choices = list('Static' = 'S', 'Trend' = 'T', 'Frailty' = 'F'),
                                    selected = 'S')
                    )
                    
                ),
                
                br(),
                br(),
                
                h3('Life Statistics'),
                
                plotOutput('vistime'),
                
                plotOutput('survival_curves'),
                
                h1(textOutput('test'))
            )
        )
    ),
    title = "RToolkit",
    footer = bs4DashFooter(
        left = "Created by School of Risk & Actuarial Studies, UNSW",
        right = "Version 0.1",
        fixed = TRUE
    )
)

server <- function(input, output, session) {

    observe({
        updateSliderInput(
            session = session,
            inputId = "age1",
            value = input$age2
        )
    })
    observe({
        updateSliderInput(
            session = session,
            inputId = "age2",
            value = input$age1
        )
    })

    output$corr_plot1 <- renderPlotly({

        plot1 <- plot_ly(x = iris$Sepal.Length,
                         y = iris$Sepal.Width,
                         type = "scatter",
                         mode = "markers",
                         marker = list(color = "rgb(102, 16, 242)")) %>%

        layout(xaxis = list(showline = TRUE,
                            linecolor = 'rgb(180,180,180)',
                            gridcolor = 'rgb(220,220,220)'),
               yaxis = list(showline = TRUE,
                            linecolor = 'rgb(180,180,180)',
                            gridcolor = 'rgb(220,220,220)'))

    })

    output$corr_plot2 <- renderPlotly({

        plot1 <- plot_ly(x = iris$Sepal.Length,
                         y = iris$Sepal.Width,
                         type = "scatter",
                         mode = "markers",
                         marker = list(color = "rgb(102, 16, 242)")) %>%

            layout(xaxis = list(showline = TRUE,
                                linecolor = 'rgb(180,180,180)',
                                gridcolor = 'rgb(220,220,220)'),
                   yaxis = list(showline = TRUE,
                                linecolor = 'rgb(180,180,180)',
                                gridcolor = 'rgb(220,220,220)'))

    })
    
    output$stats_table <- renderTable({
        
        as.data.frame(matrix(c(2, 3, 3, 2, 3, 2, 3, 2), ncol = 2, byrow = TRUE,
                             dimnames = list(NULL, c('a', 'b'))))
        
    })
    
    
    
    # HEALTH MODULE - 3 STATE MODEL -------------
    
    observe({
        updateSliderInput(
            session = session,
            inputId = "init_age",
            value = input$init_age2
        )
    })
    observe({
        updateSliderInput(
            session = session,
            inputId = "init_age2",
            value = input$init_age
        )
    })
    
    output$vistime <- renderPlot({
        # get parameters from inputs
        model <- input$model_type
        init_age <- as.integer(input$init_age)
        female <- as.integer(input$gender)
        year <- as.integer(input$year)
        init_state <- as.integer(input$init_state)
        
        if(init_state == 0){
            
            # compute transition probability 
            if (model == 'F') {
                future_lifetime <- aflF(init_age, init_state, female, year, US_HRS)
                disabled_time <- time_to_disabledF(init_age, female, year, US_HRS)
            } else {
                trans_probs <- get_trans_probs(model, US_HRS, init_age, female, year)
                future_lifetime <- afl(init_age, init_state, trans_probs = trans_probs)
                disabled_time <- time_to_disabled(init_age, trans_probs = trans_probs)
            }
            
            data = data.frame(
                group = c('Expected Future Lifetime', 'Expected Onset of Disability'),
                event = c('Range', 'Range'),
                start = c(format(Sys.Date()+dyears(max(future_lifetime$mean-2*future_lifetime$s.dev, 0)), '%Y-%m-%d'),
                          format(Sys.Date()+dyears(max(disabled_time$mean-2*disabled_time$s.dev, 0)), '%Y-%m-%d')),
                end = c(format(Sys.Date()+dyears(future_lifetime$mean + 2*future_lifetime$s.dev),'%Y-%m-%d'),
                        format(Sys.Date()+dyears(disabled_time$mean+2*disabled_time$s.dev), '%Y-%m-%d'))
            )

            plot_data <- gg_vistime(data,
                                    show_labels = FALSE,
                                    title = 'Life Expectancy and Onset of Disability') +
                labs(caption = 'Coloured region shows 95% confidence interval around mean point')
            
            
            plot_data <- plot_data + 
                annotate('point', x = as.POSIXct(Sys.Date() + dyears(future_lifetime$mean)), y = 3, size = 5) +
                annotate('point', x = as.POSIXct(Sys.Date() + dyears(disabled_time$mean)), y = 1, size = 5) +
                annotate('line', x = as.POSIXct(Sys.Date()), y = c(0,4), color = 'red') + 
                annotate('text', x = as.POSIXct(Sys.Date())+dyears(1.5), y = 0.5, label = 'Current Age')
            
            plot_data
            
        } else {
            
            if (model == 'F') {
                future_lifetime <- aflF(init_age, init_state, female, year, US_HRS)
            } else {
                trans_probs <- get_trans_probs(model, US_HRS, init_age, female, year)
                future_lifetime <- afl(init_age, init_state, trans_probs = trans_probs)
            }
            
            data <- data.frame(
                group = 'Expected Future Lifetime',
                event = 'Range',
                start = c(format(Sys.Date() + dyears(max(future_lifetime$mean - 2*future_lifetime$s.dev, 0)), '%Y-%m-%d')),
                end = c(format(Sys.Date() + dyears(future_lifetime$mean + 2*future_lifetime$s.dev), '%Y-%m-%d'))
            )
            
            plot_data <- gg_vistime(data,
                                    show_labels = FALSE, 
                                    title = 'Life Expectancy')+
                labs(caption = 'Coloured region represents 95% confidence interval around mean point')
            
            plot_data <- plot_data + 
                annotate('point', x = as.POSIXct(Sys.Date() + dyears(future_lifetime$mean)), y = 1, size = 5) + 
                annotate('line', x = as.POSIXct(Sys.Date()), y = c(0,4), color = 'red') + 
                annotate('text', x = as.POSIXct(Sys.Date())+dyears(1.5), y = 0.5, label = 'Current Age')
            
            plot_data
        }
        
    })
    
    output$survival_curves <- renderPlot({
        # get parameters from inputs
        model <- input$model_type
        init_age <- as.integer(input$init_age)
        female <- as.integer(input$gender)
        year <- as.integer(input$year)
        init_state <- as.integer(input$init_state)
        
        trans_probs <- get_trans_probs(model, US_HRS, init_age, female, year)
        prob_plot <- prob_plots(init_state, init_age, trans_probs)
        
        
        if(init_state == 0){
            
            # compute transition probability 
            if (model == 'F') {
                future_lifetime <- aflF(init_age, init_state, female, year, US_HRS)
                disabled_time <- time_to_disabledF(init_age, female, year, US_HRS)
            } else {
                trans_probs <- get_trans_probs(model, US_HRS, init_age, female, year)
                future_lifetime <- afl(init_age, init_state, trans_probs = trans_probs)
                disabled_time <- time_to_disabled(init_age, trans_probs = trans_probs)
            }
            
            data = data.frame(
                group = c('Expected Future Lifetime', 'Expected Onset of Disability'),
                event = c('Range', 'Range'),
                start = c(format(Sys.Date()+dyears(max(future_lifetime$mean-2*future_lifetime$s.dev, 0)), '%Y-%m-%d'),
                          format(Sys.Date()+dyears(max(disabled_time$mean-2*disabled_time$s.dev, 0)), '%Y-%m-%d')),
                end = c(format(Sys.Date()+dyears(future_lifetime$mean + 2*future_lifetime$s.dev),'%Y-%m-%d'),
                        format(Sys.Date()+dyears(disabled_time$mean+2*disabled_time$s.dev), '%Y-%m-%d'))
            )
            
            plot_data <- gg_vistime(data,
                                    show_labels = FALSE,
                                    title = 'Life Expectancy and Onset of Disability') +
                labs(caption = 'Coloured region shows 95% confidence interval around mean point')
            
            
            plot_data <- plot_data + 
                annotate('point', x = as.POSIXct(Sys.Date() + dyears(future_lifetime$mean)), y = 3, size = 5) +
                annotate('point', x = as.POSIXct(Sys.Date() + dyears(disabled_time$mean)), y = 1, size = 5) +
                annotate('line', x = as.POSIXct(Sys.Date()), y = c(0,4), color = 'red') + 
                annotate('text', x = as.POSIXct(Sys.Date())+dyears(1.5), y = 0.5, label = 'Current Age')
            
        } else {
            
            if (model == 'F') {
                future_lifetime <- aflF(init_age, init_state, female, year, US_HRS)
            } else {
                trans_probs <- get_trans_probs(model, US_HRS, init_age, female, year)
                future_lifetime <- afl(init_age, init_state, trans_probs = trans_probs)
            }
            
            data <- data.frame(
                group = 'Expected Future Lifetime',
                event = 'Range',
                start = c(format(Sys.Date() + dyears(max(future_lifetime$mean - 2*future_lifetime$s.dev, 0)), '%Y-%m-%d')),
                end = c(format(Sys.Date() + dyears(future_lifetime$mean + 2*future_lifetime$s.dev), '%Y-%m-%d'))
            )
            
            plot_data <- gg_vistime(data,
                                    show_labels = FALSE, 
                                    title = 'Life Expectancy')+
                labs(caption = 'Coloured region represents 95% confidence interval around mean point')
            
            plot_data <- plot_data + 
                annotate('point', x = as.POSIXct(Sys.Date() + dyears(future_lifetime$mean)), y = 1, size = 5) + 
                annotate('line', x = as.POSIXct(Sys.Date()), y = c(0,4), color = 'red') + 
                annotate('text', x = as.POSIXct(Sys.Date())+dyears(1.5), y = 0.5, label = 'Current Age')
            
        }

        grid.arrange(plot_data, prob_plot, ncol = 1, heights = c(1, 2))
        
    })
    
    output$test <- renderText({
        paste('Testing init_state : ', input$init_state)
    })
    
}

shinyApp(ui = ui, server = server)
