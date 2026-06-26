library(ggplot2)
library(plotly)
library(htmlwidgets)

df_machine1 <- subset(X027, Machine == 1)
df_machine1$Temperature_factor <- as.factor(df_machine1$Temperature)

anova_model <- aov(PartResistance ~ Temperature_factor, data = df_machine1)
anova_summary <- summary(anova_model)
p_value <- anova_summary[[1]]$`Pr(>F)`[1]
formatted_p_value <- ifelse(p_value < 0.0001, "0", formatC(p_value, format = "f", digits = 4))

p <- ggplot(df_machine1, aes(x = Temperature_factor, y = PartResistance, fill = Temperature_factor)) +
  geom_boxplot(outlier.shape = NA) +
  geom_hline(yintercept = 10, linetype = "dashed", color = "red", linewidth = 1) +
  labs(
    title = expression("Part Resistance for Machine 1 by Temperature with USL"),
    x = "Temperature (K)",
    y = expression("Part Resistance (" * Omega * ")")
  ) +
  scale_fill_manual(values = c("#0072B2", "#D55E00", "#009E73", "#CC79A7")) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, hjust = 0.5),
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 14),
    legend.position = "none",
    panel.background = element_rect(fill = "white", colour = NA),
    plot.background = element_rect(fill = "white", colour = NA)
  )

p_plotly <- ggplotly(p) %>% 
  layout(hovermode = "x unified")

saveWidget(p_plotly, file = "media/plots/boxplot_machine_1_partresistance_by_temperature_usl_new.html", selfcontained = TRUE)
