library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel("Explore the HIV and the Antibody Repertoire"),
    br(),
    h4("HIV + Antibody Diversity"),
    br(),
    p(
        "Measured as pi. This is a measure of the amount of differences between the sequences in a sample.
    Specifically, this is the mean genetic distance between all pairs of sequences in a sample"
    ),
    br(),
    sidebarLayout(sidebarPanel(# Dropdown menu: populate with the patient_id options without hardcoding
        uiOutput("patientOutput")),
        # Plot area
        mainPanel(
            plotOutput("hivDIV_plot"),
            br(),
            br(),
            tags$a(
                href = "https://ab-hiv-coevolution.github.io/HIV_AB_CoEvo/index.html",
                "Source: HIV/Ab EVO - Intrapatient [co]evolution of HIV and Antibodies",
                target = "_blank"
            )
        ))
)