theme_map <- function(base_size = 12) {
  require(grid)
  theme_grey(base_size) %+replace%
    theme(
      axis.title      =   element_blank(),
      axis.text       =   element_blank(),
      panel.background    =   element_rect(fill = "gray88", colour=NA),
      panel.grid      =   element_blank(),
      axis.ticks.length   =   unit(0,"cm"),
      panel.margin    =   unit(0,"lines"),
      plot.margin     =   unit(c(0,0,0,0),"lines"),
      complete = TRUE, 
      panel.background = element_rect(fill = "#01001C", colour=NA)
    )
}