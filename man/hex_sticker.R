library(hexSticker)
library(magick)
library(magrittr)

# Create hexsticker
sticker(subplot = "./man/figures/tally_counter_hand.png", s_x = 0.95, s_y = 1.15, s_width = 0.4, s_height = 0.48,
        package = "tallyr", p_x = 1.0, p_y = 0.45, p_size = 20, p_color = "white",
        h_fill = "#607B8B", h_color = "#0B334D",
        filename = "man/figures/logo.png")

# Resize for Github - use usethis::use_logo
# image_read("./man/figures/logo.png") %>%
#   image_scale("240x278") %>%
#   image_write(path = "./man/figures/logo.png", format = "png") %T>%
#   print()
