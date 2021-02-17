# MCH Class notes - Unit 2, Lesson 1
# Ice Sheets 

# Read in data

ant_ice_loss <- read.table("data/antarctica_mass_200204_202008.txt", skip = 31, 
           col.names = c("decimal_date", "mass_Gt", "sigma_Gt"))

grn_ice_loss <- read.table("data/greenland_mass_200204_202008.txt", skip = 31, 
                           col.names = c("decimal_date", "mass_Gt", "sigma_Gt"))

#every time we load in data, the first thing we should do is LOOK at it!
head(ant_ice_loss)
head(grn_ice_loss)

dim(ant_ice_loss)
dim(grn_ice_loss)

summary(ant_ice_loss)
summary(grn_ice_loss)

#Plot
# can be x,y or y ~ x
plot(mass_Gt ~ decimal_date, data = ant_ice_loss, main = "Antarctica ice loss", ylab = "Mass loss (Gt)")
points(mass_Gt ~ decimal_date, data = grn_ice_loss, main = "Greenland ice loss", ylab = "Mass loss (Gt)")
# gap when the GRACE satellite mission stopped between 2017-2018

#Plot by default plots as points 