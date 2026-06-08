
library(tidyverse)
library(qcc)
library(ggplot2)
library(plotly)
library(htmlwidgets)

# Filter data for Machine 1, Temperature 338, Pressure 200
filtered_data <- X027 %>%
  filter(Machine == 1, Temperature == 338, Pressure == 200)

# Prepare data for xbar.one chart
chart_data <- filtered_data$PartLength

# Calculate chart (plot=FALSE to prevent automatic plotting by qcc)
qcc_chart <- qcc(chart_data, type="xbar.one", plot=FALSE)

# Convert qcc object to a data frame for ggplot2
xbar_df <- data.frame(
  x = 1:length(chart_data),
  y = chart_data,
  cl = qcc_chart$center,
  lcl = qcc_chart$limits[1],
  ucl = qcc_chart$limits[2]
)

# Define Okabe-Ito colors
okabe_ito_colors <- c("#0072B2", "#D55E00", "#009E73", "#CC79A7")

# Create ggplot
p <- ggplot(xbar_df, aes(x = x, y = y)) +
  geom_line(color = okabe_ito_colors[1]) +
  geom_point(color = okabe_ito_colors[1]) +
  geom_hline(aes(yintercept = cl, linetype = "CL"), color = okabe_ito_colors[2], linewidth = 0.8) +
  geom_hline(aes(yintercept = lcl, linetype = "LCL"), color = okabe_ito_colors[3], linewidth = 0.8) +
  geom_hline(aes(yintercept = ucl, linetype = "UCL"), color = okabe_ito_colors[3], linewidth = 0.8) +
  scale_linetype_manual(name = "Control Limits", values = c("CL" = "solid", "LCL" = "dashed", "UCL" = "dashed")) +
  labs(
    title = "X-bar.one Chart for PartLength (Machine 1, 338K, 200kPa)",
    x = "Observation",
    y = "PartLength"
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
p_plotly <- ggplotly(p)

# Save the plot as an HTML widget
htmlwidgets::saveWidget(p_plotly, "media/plots/control_chart_machine_1_temp_338_pressure_200.html", selfcontained = TRUE)

