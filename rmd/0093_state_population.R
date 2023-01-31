# 093_state_population.R
# ========================
library(data.table)
library(ggplot2)

# CENSUS DATA (source: wikipedia)
us  <- c(150.7,
				 179.3,
				 203.2,
				 226.5,
				 248.7,
				 281.4,
				 308.8)

ny  <- c(14.8,
				 16.8,
				 18.2,
				 17.6,
				 18.0,
				 19.0,
				 19.4)

ca  <- c(10.6,
				 15.7,
				 20.0,
				 23.7,
				 20.8,
				 33.9,
				 37.3)

fl   <- c(2.8,
					5.0,
					6.8,
					9.7,
					12.9,
					16.0,
					18.8)

tx  <- c(7.7,
				 9.6,
				 11.2,
				 14.2,
				 17.0,
				 20.9,
				 25.1)


yr  <- c(1950,
				 1960,
				 1970,
				 1980,
				 1990,
				 2000,
				 2010)

df <- data.frame(yr = yr, state="ny", pop=ny)
df

df <- rbind(df, data.frame(yr=yr, state="ca", pop=ca))
#df <- rbind(df, data.frame(yr=yr, state="us", pop=us))
df <- rbind(df, data.frame(yr=yr, state="tx", pop=tx))
df <- rbind(df, data.frame(yr=yr, state="fl", pop=fl))

df

ggplot() +
	geom_line(data=df,mapping=aes(yr,pop, color=state))
