make_surv_plot <- function(data,
                           fit,
                           title = NULL,
                           legend_label = NULL,
                           break_x_by = 12,
                           pval_coord = c(0, 0.20),
                           logrank_weights = NULL,
                           ylab = 'Overall Survival',
                           xlab = "Time (Months)",
                           legend_coord = c(.01, .01),
                           risk_table = T,
                           plot_table_ratio = c(.8, .2),
                           axis_title_size = c(20, 'bold'),
                           pval_text = T,
                           pval_text_size = 8,
                           xlim = NULL,
                           ylim = NULL,
                           risk_table_text_size = 5,
                           legend_text_size = 20,
                           fun = NULL,
                           plot_palette = 'Set1',
                           surv_median_line = 'none') {
  p <- survminer::ggsurvplot(
    fit = fit,
    data = data,
    title = title,
    risk.table = T,
    break.time.by = break_x_by,
    tables.y.text = F,
    censor = F,
    pval = pval_text,
    pval.coord = pval_coord,
    pval.size = pval_text_size,
    log.rank.weights = logrank_weights,
    surv.scale = "percent",
    legend = legend_coord,
    palette = plot_palette,
    xlab = xlab,
    ylab = ylab,
    surv.median.line = surv_median_line,
    xlim = xlim,
    ylim = ylim,
    risk.table = risk_table,
    legend.labs = legend_label,
    fontsize = risk_table_text_size,
    font.x = axis_title_size,
    font.y = axis_title_size,
    legend.title = '',
    font.tickslab = 18,
    fun = fun,
    ggtheme = survminer::theme_survminer() +
      theme(
        legend.title = element_blank(),
        legend.justification = c("left", 'bottom'),
        legend.text = element_text(size = legend_text_size, face = 'bold'),
        legend.box.margin = margin(0, 0, 0, 0),
        legend.background = element_rect(fill = 'transparent'),
        plot.margin = margin(.5, .5, 0, .5, "cm")
      ),
    tables.theme = theme(
      title = element_blank(),
      legend.title = element_blank(),
      legend.text = element_text(size = 5),
      axis.line = element_blank(),
      axis.ticks = element_blank(),
      axis.text.x = element_blank(),
      plot.margin = margin(0, .5, .5, .5, "cm")
    )
  )

  p$plot <-
    p$plot + guides(colour = guide_legend(override.aes = list(size = 5, alpha = 1)))

  p <-
    cowplot::plot_grid(
      p$plot,
      p$table,
      nrow = 2,
      align = 'v',
      rel_heights = plot_table_ratio
    )
  return(p)
}
