
library(tidyverse)
library(plotly)
library(htmlwidgets)

machine1_data <- X027 %>%
  filter(Machine == 1)

machine1_data$Pressure_Factor <- as.factor(machine1_data$Pressure)

usl_value <- 10

plot_boxplot <- machine1_data %>%
  ggplot(aes(x = Pressure_Factor, y = PartResistance, fill = Pressure_Factor)) +
  geom_boxplot(show.legend = FALSE) +
  geom_hline(yintercept = usl_value, linetype = "dashed", color = "red", size = 1) +
  labs(
    title = "Part Resistance for Machine 1 by Pressure (with USL)",
    x = "Pressure",
    y = "Part Resistance"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, hjust = 0.5),
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18),
    axis.text = element_text(size = 14),
    panel.background = element_rect(fill = "white", colour = "white")
  ) +
  scale_fill_manual(values = c("#0072B2", "#D55E00", "#009E73", "#CC79A7"))

plotly_boxplot <- ggplotly(plot_boxplot)

htmlwidgets::saveWidget(plotly_boxplot, "media/plots/boxplot_machine_1_partresistance_by_pressure_usl.html", selfcontained = TRUE)

