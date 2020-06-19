library(dplyr)
library(openair)

#
hust <- read.csv("D:/GitHub/thesis/data/HUST_1h.csv", header = T)
vnua <- read.csv("D:/GitHub/thesis/data/VNUA_1h.csv", header = T)
tnut <- read.csv("D:/GitHub/thesis/data/TNUT_1h.csv", header = T)

# Phan tich du lieu tu HUST
names(hust)
summary(hust)
dplyr::glimpse(hust)
head(hust)

hust$date <- as.POSIXct(strptime(hust$date,
                                 format = "%Y/%m/%d %H:%M",
                                 tz = "Asia/Ho_Chi_Minh"))

# Phan tich du lieu tu VNUA
names(vnua)
summary(vnua)
dplyr::glimpse(vnua)
head(vnua)

vnua$date <- as.POSIXct(strptime(vnua$date,
                                 format = "%Y/%m/%d %H:%M",
                                 tz = "Asia/Ho_Chi_Minh"))

# Phan tich du lieu tu TNUT
names(tnut)
summary(tnut)
dplyr::glimpse(tnut)
head(tnut)

tnut$date <- as.POSIXct(strptime(tnut$date,
                                 format = "%Y/%m/%d %H:%M",
                                 tz = "Asia/Ho_Chi_Minh"))

# Gop du lieu
dat_hus_vnu <- dplyr::inner_join(hust, vnua, by = "date")
dat_tnu <- dplyr::inner_join(dat_hus_vnu, tnut, by = "date")

dat <- dplyr::rename(dat_tnu, pm2.5HUST = HUST, pm2.5VNUA = VNUA, pm2.5TNUT = TNUT)
names(dat)

# Xu ly du lieu
openair::summaryPlot(dat, period = "months", avg.time = "day")

openair::timeVariation(dat, pollutant = c("pm2.5HUST", "pm2.5VNUA", "pm2.5TNUT"), ci = F, date.pad = 'month')

?timePlot()kkkkk

