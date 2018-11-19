install.packages('tidyverse')
install.packages('ggpubr')
library(tidyverse)

#~#~#~# SET PARAMETERS #~#~#~#
# Working Directory
setwd('\\\\net1110.net.ucf.edu/research2/lighthall_lab/experiments/econdec-oa/code')
# Read Data
data <- read.csv('../derivatives/main_trial_level.csv')

# Color Palettes for Bar Plot
bar_color_palette <- 'startrek'
bar_fill_palette <- 'futurama'

# Color Palette for Asymmetry Curves
line_color_palette <- c('blue','red')
#~#~#~# END PARAMETERS #~#~#~#



# Factorize
data$AgeGroup <- factor(data$AgeGroup)
data$SubjNum <- factor(data$SubjNum)
data$StockValue <- factor(data$StockValue)

# Group & Summarize
grp_level <- data %>%
	group_by(AgeGroup,StockValue) %>%
	summarize(
	  MeanError = mean(val_estdiff_valid, na.rm = TRUE),
	  StdErr = sd(val_estdiff_valid, na.rm = TRUE) / sqrt(length(val_estdiff_valid))
	  )
grp_level

# Bar Plot Domain-Magnitude Interaction Between Groups
ggplot(grp_level, aes(x = AgeGroup, y = MeanError)) + 
	geom_bar(
		aes(color = StockValue, fill = StockValue),
		stat = 'identity', position = position_dodge()
		) +
	ggpubr::color_palette(bar_color_palette) + 
	ggpubr::fill_palette(bar_fill_palette) + 
	ggpubr::theme_pubclean()

# Line Plot Young Adults' Domain Asymmetry Curves
ya_error_level <- filter(data, AgeGroup == 1)  %>%
  group_by(Domain, ObjectiveProb = TrueProbGood) %>%
  summarize(
    SubjectiveProb = mean(ProbGood, na.rm = TRUE),
    ErrUpper = SubjectiveProb + sd(ProbGood, na.rm = TRUE) / sqrt(length(ProbGood)),
    ErrLower = SubjectiveProb - sd(ProbGood, na.rm = TRUE) / sqrt(length(ProbGood))
    )
ggplot(ya_error_level, aes(x=ObjectiveProb, y=SubjectiveProb, color=Domain)) +
  geom_line(size=1) +
  geom_abline(aes(slope=1,intercept=0),linetype=2) +
  #geom_point(aes(color=Domain, shape=Domain),size=3) +
  geom_linerange(aes(ymin=ErrLower, ymax=ErrUpper),size=1) +
  xlab('Objective Probability') + ylab('Estimation') +
  ggpubr::color_palette(line_color_palette) +
  ggpubr::labs_pubr()

# Line Plot Older Adults' Domain Asymmetry Curves
oa_error_level <- filter(data, AgeGroup == 2)  %>%
  group_by(Domain, ObjectiveProb = TrueProbGood) %>%
  summarize(
    SubjectiveProb = mean(ProbGood, na.rm = TRUE),
    ErrUpper = SubjectiveProb + sd(ProbGood, na.rm = TRUE) / sqrt(length(ProbGood)),
    ErrLower = SubjectiveProb - sd(ProbGood, na.rm = TRUE) / sqrt(length(ProbGood))
    )
ggplot(oa_error_level, aes(x=ObjectiveProb, y=SubjectiveProb, color=Domain)) +
  geom_line(size=1) +
  geom_abline(aes(slope=1,intercept=0),linetype=2) +
  #geom_point(aes(color=Domain, shape=Domain),size=3) +
  geom_linerange(aes(ymin=ErrLower, ymax=ErrUpper),size=1) +
  xlab('Objective Probability') + ylab('Estimation') +
  ggpubr::color_palette(line_color_palette) +
  ggpubr::labs_pubr()
