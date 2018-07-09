library(gganimate)
performanceByEpoch <- read_rds('epoch_perf.rds')

performanceByEpoch %>% 
  ggplot(aes(x = truth,  y = predicted)) +
  geom_point(aes(size = count, color = good)) +
  geom_text(aes(label = count), 
            hjust = 0, vjust = 0, 
            nudge_x = 0.1, nudge_y = 0.1) + 
  guides(color = FALSE, size = FALSE) +
  theme_minimal() +
  labs(title = 'Epoch: {current_frame}') +
  transition_manual(epoch) -> animatedPerformance

animate(animatedPerformance, nframes = length(unique(performanceByEpoch$epoch)))
