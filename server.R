library(shiny)

# Define server logic required to draw a histogram
server <- function(input, output) {
    # Look at the dataset to populate the patient dropdown menu output
    output$patientOutput <- renderUI({
        selectInput("patientInput",
                    "Select Patient:",
                    sort(unique(hiv_ab$patient_id)),
                    selected = "1")
    })
    # Create the scatter plot
    filtered <- reactive({
        hiv_ab %>%
            select(patient_id,
                   time_point,
                   hiv_diversity_pi,
                   ab_diversity_pi) %>%
            filter(patient_id == input$patientInput[1]) %>%
            gather(key = "diversity_type",
                   value = "value",
                   -patient_id,
                   -time_point)
    })
    # Render scatterplot for patient selected
    output$hivDIV_plot <- renderPlot({
        ggplot(filtered(), aes(x = time_point, y = value)) +
            geom_path(aes(color = diversity_type), labels = c("AbR", "HIV")) +
            geom_point(aes(color = diversity_type)) +
            labs(title = "HIV Diversity",
                 x = "Estimated Time Since Infection (years)",
                 y = "Diversity (pi)") +
            scale_color_manual(
                name = "Sequence\nType",
                labels = c("AbR", "HIV"),
                values = c("#0066FF", "#FF99FF")
            ) +
            theme_bw()
    })
}
