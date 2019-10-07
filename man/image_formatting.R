library(magick)
library(magrittr)
#str(magick::magick_config())
image <- image_read("./man/figures/tally_counter_hand_original.jpg") %>%
  # Convert to png
  image_convert(format = "png") %>%
  # Crop image to hand
  image_crop("270x345+40+35") %>%
  # convert image to black and white
  image_convert(colorspace = "Gray") %>%
  image_threshold(type = "white", threshold = "70%") %>%
  image_threshold(type = "black", threshold = "30%") %>%
  # make image negative
  image_negate() %>%
  # increase lines width
  image_morphology("Dilate", "Diamond:1") %>%
  # fill in button
  image_fill("white", "+85+85", fuzz = 50) %>%
  image_fill("white", "+64+78", fuzz = 50) %>%
  # make background transparent
  image_transparent("black", fuzz = 20) %>%
  # write image
  image_write(path = "./man/figures/tally_counter_hand.png", format = "png") %T>%
  # print inage in viewer
  print()

