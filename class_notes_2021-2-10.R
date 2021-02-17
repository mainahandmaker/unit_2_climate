# MCH 2021-2-10

#################################
#   a For Loops refresher
#################################

#Want to add up all the numbers in this vector
vec = c(1,3,5,7,9)
#create an empty vector for the results
total = 0

#create loop to add all the numbers in vec
for(i in seq(length(vec))){
  total = total + vec[i]
  print(total)
}

total

#this for loop was actually unneccessary - because we could have just summed the vector:
sum(vec) #also equals 25

#not an efficient way to code this example, but using it to show what you might do when you need to code out the steps to an intricate series of intricate analyses

##EXERCISE 5.1
###Use a for() loop to calculate the factorial (symbol !) of any integer number greater than 0. Test it with num = 3 and num = 6
n=c(3)
n=5
for(i in seq(length(n))){
  f=factorial(n)
  print(f)
}

##NESTED for loops - great when you don't just need to go through a vector, but through a matrix or something - when you don't just want to step through your rows, but every column

#create matrix
mat = matrix(c(2,0,8,3,5,-4), nrow=2, ncol=3)
mat
#Now, if you want to send a loop through this matrix, it has to go through each row and each column, one cell at a time
#create empty matrix for the results:
results = matrix(data=NA, nrow=2, ncol=3)
results

#build loops that will step through each row, and then step through each column. First, hard code it by telling it to go through rows 1 and 2, columns 1-3.
for (i in c(1:2)){
  for (j in c(1:3)){
    results[i,j] = mat[i,j]^2 #put results in row i, column j, squaring each cell in the original matrix 'mat'
    print(paste("row:", i, " and column:", j))
    print(results)
  }
}

results

# While Loops - keep doing this thing, if a certain condition is met. Once the condition is no longer true, it will exit the loop.

num = -3
while(num < 0){
  num = num+1
  print(num)
}

####################################
#  Arctic Sea Ice
###################################

url = 'ftp://sidads.colorado.edu/DATASETS/NOAA/G02135/north/daily/data/N_seaice_extent_daily_v3.0.csv'
arctic_ice = read.delim(url, skip=2, sep=",", header=FALSE, col.names = c("Year", "Month", "Day", "Extent", "Missing", "Source_Data"))
head(arctic_ice)
summary(arctic_ice)

library(lubridate) #handles date issues; date in this data set is split into Y, M, D columns

arctic_ice$date = make_date(year = arctic_ice$Year, month=arctic_ice$Month, day=arctic_ice$Day) #created new column "date" that combined Year/Month/Date columns into one date-formatted variable
head(arctic_ice) #inspect to see new date column
class(arctic_ice$date) #confirm class of new date column is in fact Date

#plot

plot(Extent~date, data=arctic_ice, type = "l")
#this annual cycle plot is a bit noisy from a climate change perspective - now need to calculate averages to be able to show trend rather than annual cycles

#calculate annual average for one year
arctic_ice$Extent[which(arctic_ice$Year == 1978)] #this should grab the extent variable for only the years that match 1978
mean(arctic_ice$Extent[which(arctic_ice$Year == 1978)]) #this calculates the mean for 1978 so we have one value for that year

#calculate annual average for all years using a for loop
arctic_ice_annual <- data.frame(Year=c(1978:2021), extent_annual_avg = NA, extent_5yr_avg = NA) #make empty df for results

#saying seq(dim) tells R to carry the loop from 1 all the way to the last row of the data frame - in other words, for the full dimension of arctic_ice_annual - 1:44
for (i in seq(dim(arctic_ice_annual)[1]-1)){
  arctic_ice_annual$extent_annual_avg[i] <- mean(arctic_ice$Extent[which(arctic_ice$Year == arctic_ice_annual$Year[i])]) #telling R to grab the year for the i'th row
}

arctic_ice_annual

plot(extent_annual_avg~Year, data = arctic_ice_annual, type = "l")

# Now calculate 5 year rolling average to fill in our extent_5yr_avg column.
#We are treating 5 year average as the 2 years before and 2 years after each year in the sequence (rather than the years that are multiples of 5)

i = 5
for (i in seq(dim(arctic_ice_annual)[1]-1)){
  years = seq(arctic_ice_annual$Year[i]-2, arctic_ice_annual$Year[i]+2) #the sequence going from 2 yrs before the i'th year to 2 yrs after the i'th year
  arctic_ice_annual$extent_5yr_avg[i] <- mean(arctic_ice$Extent[which(arctic_ice$Year %in% years)]) #telling R to grab the extent from only the years inside by new 'years' vector
}

arctic_ice_annual

plot(extent_5yr_avg ~ Year, data = arctic_ice_annual, type = "l") +
  lines(extent_annual_avg~Year, data = arctic_ice_annual, type = "l", col = "red")

  
