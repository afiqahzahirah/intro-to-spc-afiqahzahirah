
# Explicitly set R's working directory
setwd('/content/project')

library(tidyverse)
library(ggplot2)
library(plotly)
library(htmlwidgets)

# Ensure the output directory exists
dir.create("media/plots", recursive = TRUE, showWarnings = FALSE)

# Filter data for Machine 3, Temperature 338, Pressure 200
filtered_data <- X027 %>% filter(Machine == 3, Temperature == 338, Pressure == 200)

# Create a histogram and density plot for PartLength
p_length_dist <- ggplot(filtered_data, aes(x = PartLength)) +
  geom_histogram(aes(y = after_stat(density)), binwidth = 1, fill = "#0072B2", color = "white", alpha = 0.7) +
  geom_density(color = "#D55E00", linewidth = 1) +
  labs(
    title = "Distribution of PartLength (Machine 3, 338K, 200kPa)",
    x = "PartLength",
    y = "Density"
  ) +
  theme_minimal() +
  theme(
    plot.background = element_rect(fill = "white", color = NA),
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18),
    axis.text.x = element_text(size = 14),
    axis.text.y = element_text(size = 14)
  )

# Convert to plotly for interactivity
p_plotly_length_dist <- ggplotly(p_length_dist)

# Save the plot as an HTML widget
htmlwidgets::saveWidget(p_plotly_length_dist, "media/plots/distribution_partlength_machine_3_temp_338_pressure_200.html", selfcontained = TRUE)

