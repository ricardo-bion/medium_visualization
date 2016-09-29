# 500k top Airbnb trips: created in R with ggplot2

A few people asked for a high-resolution image and the code that I used to generate the ggplot2 visualization on my recent Medium post ["Using R Packages and Education to Scale Data Sience at Airbnb"](https://medium.com/airbnb-engineering/using-r-packages-and-education-to-scale-data-science-at-airbnb-906faa58e12d).

### High-res image:


![](top_airbnb_trips.png)

<br>
<br>

[**Link to high-res image for download**](https://dl.dropboxusercontent.com/u/2364714/top_airbnb_trips.png)

<br>
<br>

### R code:


```r
library(ggplot2)
library(ggmap)
library(sp)
library(grid)
library(geosphere)
library(plyr)
```



```r
# source the theme_map for ggplot2
source("https://dl.dropboxusercontent.com/u/2364714/theme_map.R")

# in the original post I had a data.frame with 500k rows of top origin destination pairs
trips <- data.frame(origin = c("San Francisco", "Sydney"), 
                    destination = c("Paris", "Tokyo"), 
                    stringsAsFactors = FALSE)
  
  
# get lat and lon of cities
trips$geocode_origin <- suppressMessages(geocode(trips$origin))
trips$geocode_destination <- suppressMessages(geocode(trips$destination))


# get intermediate points between the two locations
arch <- gcIntermediate(trips$geocode_origin,
               trips$geocode_destination,
               n=100,
               breakAtDateLine=FALSE, 
               addStartEnd=TRUE, sp=TRUE)

# http://docs.ggplot2.org/0.9.3.1/fortify.map.html
arch_fortified <- ldply(arch@lines, fortify)

# a few lines of ggplot2 code
ggplot() +
  geom_line(aes(long,lat,group=group), data=arch_fortified, alpha=0.1,size=1, colour="skyblue1") +
  coord_cartesian(ylim =c(-45, 70), xlim=c(-165, 165)) +
  theme_map() +
  geom_point(aes(lon, lat),data=trips$geocode_origin, alpha = 0.8, size = 1, colour = "white") +
  geom_point(aes(lon, lat),data=trips$geocode_destination, alpha = 0.8, size = 1, colour = "white")
```

![](README_files/figure-html/unnamed-chunk-2-1.png)

<br>
<br>

### Growth over time:

![](popular_routes.gif)
