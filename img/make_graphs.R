library(patchwork)
#### Family Groups Plot ####
#Run 4c - Relative Dispersal.R through 116
family_groups %>%
  filter(!family_groups %in% families_to_remove) %>%
  activate(edges) %>%
  filter(.N()$family_groups[to] == .N()$family_groups[from]) %>%
  activate(nodes) %>%
  ggraph(layout = 'nicely') +
  geom_edge_link(width = 1.25, colour = 'black') +
  geom_node_point(aes(colour = as.character(family_groups)), 
                  size = 5, show.legend = FALSE) +
  labs(colour = '"Family" Group') +
  theme_void() +
  theme(plot.background = element_rect(fill = 'transparent', colour = NA),
        panel.background = element_rect(fill = 'transparent', colour = NA))
ggsave('~/Website/jdselwyn.github.io/images/family_network.png',
       height = 8, width = 8, bg = "transparent")


#### Dispersal rate vs Habitat ####
quality <- rate_quality_cond_effects$mean_qual %>%
  as_tibble %>%
  ggplot(aes(x = mean_qual)) +
  geom_ribbon(aes(ymin = lower__, ymax = upper__), alpha = 1, fill = 'gray50') +
  geom_line(aes(y = estimate__), size = 1, colour = 'black') +
  geom_linerange(data = quality_dispersal, aes(ymin = mean_rate - sd_rate, ymax = mean_rate + sd_rate), size = 1.5, colour = 'black') +
  # geom_errorbarh(data = quality_dispersal, aes(y = mean_rate, xmin = mean_qual - mean_qual_se, xmax = mean_qual + mean_qual_se), size = 1.5, 
  #                colour = 'black', height = 0) + #for 2e v 1e
  geom_point(data = quality_dispersal, aes(y = mean_rate), size = 5, colour = 'black') +
  labs(y = 'Rate Parameter',
       x = 'Quality') +
  theme_classic() +
  theme(legend.position = 'bottom',
        legend.text = element_text(colour = 'white', size = 18),
        legend.background = element_rect(fill = 'transparent', colour = NA),
        axis.title = element_text(colour = 'black', size = 24),
        axis.text = element_text(colour = 'black', size = 18),
        plot.background = element_rect(fill = 'transparent', colour = NA),
        panel.background = element_rect(fill = 'transparent', colour = NA),
        axis.ticks = element_line(colour = 'black'),
        axis.line = element_line(colour = 'black'))

heterogeneity <- rate_quality_cond_effects$cv_qual %>%
  as_tibble %>%
  ggplot(aes(x = cv_qual)) +
  geom_ribbon(aes(ymin = lower__, ymax = upper__), alpha = 1, fill = 'gray50') +
  geom_line(aes(y = estimate__), size = 1, colour = 'black') +
  geom_linerange(data = quality_dispersal, aes(ymin = mean_rate - sd_rate, ymax = mean_rate + sd_rate), size = 1.5, colour = 'black') +
  # geom_errorbarh(data = quality_dispersal, aes(y = mean_rate, xmin = cv_qual - cv_qual_se, xmax = cv_qual + cv_qual_se), size = 1.5, 
  #                colour = 'black', height = 0) + #for 2e v 1e
  geom_point(data = quality_dispersal, aes(y = mean_rate), size = 5, colour = 'black') +
  labs(y = 'Rate Parameter',
       x = 'Heterogeneity') +
  theme_classic() +
  theme(legend.position = 'bottom',
        legend.text = element_text(colour = 'white', size = 18),
        legend.background = element_rect(fill = 'transparent', colour = NA),
        axis.title = element_text(colour = 'black', size = 24),
        axis.text = element_text(colour = 'black', size = 18),
        plot.background = element_rect(fill = 'transparent', colour = NA),
        panel.background = element_rect(fill = 'transparent', colour = NA),
        axis.ticks = element_line(colour = 'black'),
        axis.line = element_line(colour = 'black'))


quality / heterogeneity

ggsave('~/Website/jdselwyn.github.io/images/dispersal_v_habitat.png',
       height = 8, width = 8, bg = "transparent")
