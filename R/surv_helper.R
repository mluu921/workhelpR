# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

make_surv_plot <- function(fit, data, title, legend_label, break_x_by = 12, pval_coord = c(0, 0.05)) {
  p <- survminer::ggsurvplot(
    fit = fit,
    data = data,
    title = title,
    risk.table = T,
    break.time.by = break_x_by,
    tables.y.text = F,
    censor = F,
    pval = T,
    pval.coord = pval_coord,
    pval.size = 8,
    surv.scale = "percent",
    legend = c(.8, .1),
    palette = "Set1",
    tables.height = 0.10,
    xlab = "Time (Months)",
    legend.labs = legend_label,
    fontsize = 7,
    font.x = c(20,'bold'),
    font.y = c(20,'bold'),
    legend.title = '',
    font.tickslab = 18,
    ggtheme = theme_survminer() +
      theme(
        legend.title = element_blank(),
        legend.justification = c("center"),
        legend.text = element_text(size = 20, face = 'bold'),
        plot.margin = margin()
      ),
    tables.theme = theme(
      title = element_blank(),
      legend.title = element_blank(),
      legend.text = element_text(size = 5),
      axis.line = element_blank(),
      axis.ticks = element_blank(),
      axis.text.x = element_blank()
    )
  )

  p$plot <- p$plot + guides(colour = guide_legend(override.aes = list(size=5, alpha = 1)))

  p <- cowplot::plot_grid(p$plot, p$table, nrow = 2, align = 'v', rel_heights = c(.9, .1))
  return(p)
}
