propensity_hist <- function (matchit_object, plot_title, binwidth = NULL) {

  plot_data <- as.data.frame(matchit_object$X)
  plot_data$treat <- matchit_object$treat
  plot_data$distance <- matchit_object$distance
  plot_data$weights <- matchit_object$weights

  rbind(cbind(plot_data, faceter = 'Whole Sample'), cbind(subset(plot_data, plot_data$weights == 1), faceter = 'Matched Sample')) %>%
    ggplot(., aes(x=distance, fill = as.factor(treat), color = as.factor(treat))) +
    geom_histogram(aes(y = ..density..), position = position_dodge() , alpha = .05, binwidth = binwidth) +
    geom_density(alpha = .2) +
    facet_grid(~faceter) +
    theme_minimal() + theme(legend.position = 'none', legend.title = element_blank(), panel.grid = element_blank()) +
    labs(x='Propensity Score', y='Density', title = plot_title)

}
