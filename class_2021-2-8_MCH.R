##CO2 2021-2-8

co2 = read.table("data/co2_mm_mlo.txt", col.names = c("year", "month", "decimal_date", "monthly_average", "deseasonalized", "n_days", "st_dev_days", "monthly_mean_uncertainty"))
head(co2)
class(co2)
summary(co2)
range(co2$decimal_date)
range(co2$monthly_average)

###############################
#   Plot
###############################

plot(monthly_average ~ decimal_date, data=co2, type = "l") +
  lines(y=co2$deseasonalized, x=co2$decimal_date, col="red")

co2$seasonal_cycle = co2$monthly_average - co2$deseasonalized
head(co2)
plot(seasonal_cycle ~ decimal_date, data=co2[co2$decimal_date > 2015, ], type = "l")

###############################
#   Seasonal Cycle Analysis
###############################

jan_anomalies <- co2$seasonal_cycle[which(co2$month==1)]
# can do the same thing by writing co2[which(co2$month==1), 'seasonal_cycle'] - either specify the column by name outside of the brackets - which only works if you are interested in JUST one column. If you want more than one column, must use second method and specify columns of interest as a vector: co2[which(co2$month==1), c('seasonal_cycle', 'monthly_average')]
mean(jan_anomalies)

#create new d.f. with 2 variables. month is hard coded, second column is basically empty, ready to be filled.
co2_monthly_cycle = data.frame(month=seq(1, 12), detrended_monthly_cycle = NA)

#fill the new empty column with the mean anomaly for just January
co2_monthly_cycle$detrended_monthly_cycle[1] = mean(co2$seasonal_cycle[which(co2$month==1)])

co2_monthly_cycle
#find mean anomalies for each month 1958-2020 - MANUALLY. A bit painful to change month in both places manually...so great chance to use a LOOP!
co2_monthly_cycle$detrended_monthly_cycle[1] = mean(co2$seasonal_cycle[which(co2$month==1)])
co2_monthly_cycle$detrended_monthly_cycle[2] = mean(co2$seasonal_cycle[which(co2$month==2)])
co2_monthly_cycle$detrended_monthly_cycle[3] = mean(co2$seasonal_cycle[which(co2$month==3)])
co2_monthly_cycle$detrended_monthly_cycle[4] = mean(co2$seasonal_cycle[which(co2$month==4)])
co2_monthly_cycle$detrended_monthly_cycle[5] = mean(co2$seasonal_cycle[which(co2$month==5)])
co2_monthly_cycle$detrended_monthly_cycle[6] = mean(co2$seasonal_cycle[which(co2$month==6)])
co2_monthly_cycle$detrended_monthly_cycle[7] = mean(co2$seasonal_cycle[which(co2$month==7)])
co2_monthly_cycle$detrended_monthly_cycle[8] = mean(co2$seasonal_cycle[which(co2$month==8)])
co2_monthly_cycle$detrended_monthly_cycle[9] = mean(co2$seasonal_cycle[which(co2$month==9)])
co2_monthly_cycle$detrended_monthly_cycle[10] = mean(co2$seasonal_cycle[which(co2$month==10)])
co2_monthly_cycle$detrended_monthly_cycle[11] = mean(co2$seasonal_cycle[which(co2$month==11)])
co2_monthly_cycle$detrended_monthly_cycle[12] = mean(co2$seasonal_cycle[which(co2$month==12)])

plot(detrended_monthly_cycle ~ month, data = co2_monthly_cycle, type = "l")
summary(co2_monthly_cycle)
head(co2)

plot(seasonal_cycle ~ month, data=co2[co2$year == 1959, ], type = "l", ylim=c(-4,4)) +
  lines(seasonal_cycle ~ month, data=co2[co2$year == 2020, ], type = "l", col = "red")

###############################
#   Loop time
###############################

#for loop - in parentheses, you say how many times you want it to repeat. in brackets, you say what code you want to repeat.
c(1:4) 
#can also be written as seq(1, 4), which means seq(from=1, to=4)

#below, "i" is the iterand - the code will be run sequentially with i = 1, then i = 2, i = 3, then i = 4
for(i in c(1:4)){
  print(i) #one iteration
}

# "i" is the traditional variable used for an iterand. good practice to use recognizable variables like this when reading other people's code. But you can call it whatever you like:
for(counter in c(1:4)){
  print(paste("my counter is", counter)) #one iteration now pastes "my counter is" in front of the iterand
}

## if you have a ton of files to run the same analysis on, you can save all the file names in a data frame, and run a loop on that data frame
## for loops can step through ANYTHING - can be a vector, does not have to be numbers: 
for(value in c("my", "second", "for", "loop")){
  print(value)
}

#make a vector
my_vector = c(1, 3, 5, 7, 9)
#tell R that "n" is the length of that vector
n = length(my_vector)
#square all values in the vector
## first make an empty data frame for it, that has room for the length of the original vector
my_squared_vector = rep(NA, n)
my_squared_vector
#now make a for loop:
for (i in seq(from=1, to=n)){
  my_squared_vector = my_vector[i]^2 #this tells the loop to look at each number in the vector sequentially
}
#now print the newly filled my_squared_vector to see if it worked
my_squared_vector
