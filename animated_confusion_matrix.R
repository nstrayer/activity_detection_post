library(gganimate)
library(patchwork)

historyDf <- read_rds("trainHistory.rds") %>% 
  as.data.frame() %>% 
  filter(epoch < 10)

performanceByEpoch <- read_rds('epoch_perf.rds') %>% 
  filter(epoch < 10)

lossAccuracy <- historyDf %>% 
  ggplot(aes(x = epoch, y = value, color = data)) +
  geom_line(size = 0.2) +
  geom_point(size = 0.4) +
  facet_grid(metric~., scales = "free_y") +
  theme_minimal()

confusionMatrix <- performanceByEpoch %>% 
  ggplot(aes(x = truth,  y = predicted)) +
  geom_point(aes(size = count, color = good)) +
  geom_text(aes(label = count), 
            hjust = 0, vjust = 0, 
            nudge_x = 0.1, nudge_y = 0.1) + 
  guides(color = FALSE, size = FALSE) +
  theme_minimal() +
  labs(title = 'Epoch: {current_frame}')


(lossAccuracy / confusionMatrix) * transition_manual(epoch) -> animatedPerformance

animate(animatedPerformance, nframes = length(unique(performanceByEpoch$epoch)))

trainHistory 
