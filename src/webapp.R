library(shiny)
library(bs4Dash)
library(plotly)
library(shinyWidgets)

table1 <- c("good", "bad", "ok")

ui = dashboardPage(
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
                icon = icon("wave-square ")
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

server = function(input, output, session) {

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

}

shinyApp(ui = ui, server = server)
