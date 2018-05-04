propensity_hist <- function (matchit_object, plot_title = NULL, binwidth = NULL, axis_title_size = 20, axis_text_size = 15, strip_title_size = 15) {

  plot_data <- as.data.frame(matchit_object$X)
  plot_data$treat <- matchit_object$treat
  plot_data$distance <- matchit_object$distance
  plot_data$weights <- matchit_object$weights

  plot_data <- rbind(cbind(plot_data, faceter = 'Whole Sample'),
                     cbind(subset(plot_data, plot_data$weights == 1), faceter = 'Matched Sample'))

  ggplot(plot_data, aes(
    x = distance,
    fill = as.factor(treat),
    color = as.factor(treat)
  )) +
    geom_histogram(
      aes(y = ..density..),
      position = position_dodge() ,
      alpha = .05,
      binwidth = binwidth
    ) +
    geom_density(alpha = .2) +
    facet_grid( ~ faceter) +
    theme_minimal() +
    theme(
      legend.position = 'none',
      legend.title = element_blank(),
      panel.grid = element_blank(),
      axis.title = element_text(face = 'bold', size = axis_title_size),
      axis.text = element_text(size = axis_text_size),
      strip.text = element_text(size = strip_title_size)
    ) +
    labs(x = 'Propensity Score', y = 'Density', title = plot_title)

}
