library (zen4R)
library (magick)
library (dplyr)
#a =download_zenodo ("10.5281/zenodo.4587728")


#x=img %>% magick::image_crop("400x200",gravity = "SouthEast")
#x2 =img %>% magick::image_crop("600x250",gravity = "SouthWest")
x2 =magick::image_read("OpenSciencePie.png", density = 118)


img=magick::image_read("OpenSciencePie-r.png", density = 118)

# imggif = img
#   
#   img <- image_graph(600, 340, res = 96)
# datalist <- split(gapminder, gapminder$year)
# out <- lapply(datalist, function(data){
#   p <- ggplot(data, aes(gdpPercap, lifeExp, size = pop, color = continent)) +
#     scale_size("population", limits = range(gapminder$pop)) + geom_point() + ylim(20, 90) + 
#     scale_x_log10(limits = range(gapminder$gdpPercap)) + ggtitle(data$year) + theme_classic()
#   print(p)
# })
# dev.off()

rotatedimg = c(img)

  
  for (i in c(1:60)){  
  temp =img %>% image_rotate(6*i)%>%image_transparent("white")
  
  off = -(image_info(img)$width -image_info(temp)$width)/118
  temp2=temp %>% 
    image_crop(geometry_area(width = image_info(img)$width, height = image_info(img)$width, x_off = off, y_off = off)) #%>%
    #image_transparent() %>%
    #image_composite(x, gravity = "southeast", operator = "atop") %>%
  rotatedimg = c(rotatedimg,temp2)
  }



image_write (image_animate(rotatedimg, 10), path = "pie.gif")


### ---
rotatedimg2 = c(img)


for (i in c(1:30)){  
  temp =img %>% image_rotate(12*i)%>%image_transparent("white")
  
  off = -(image_info(img)$width -image_info(temp)$width)/118
  temp2=temp %>% 
    image_crop(geometry_area(width = image_info(img)$width, height = image_info(img)$width, x_off = off, y_off = off)) #%>%
  #image_transparent() %>%
  #image_composite(x, gravity = "southeast", operator = "atop") %>%
  rotatedimg2 = c(rotatedimg2,temp2)
}

background <- image_background(x2, "white", flatten = TRUE)

frames <- lapply(rotatedimg2, function(frame) {
  image_composite(background, frame)
})



# Turn frames into animation
animation <- image_animate(image_join(frames), 4)
print(animation)

image_write (animation, path = "pie2.gif")

#image_flatten(c(x2,rotatedimg2)) 
