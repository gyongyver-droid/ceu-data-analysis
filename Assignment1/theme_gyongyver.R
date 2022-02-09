theme_gyongyver<-function(base_size=12){
  # Use the basic properties of theme_bw
  theme_light() %+replace% 
    
    # Change the items
    theme(
      # The grids on the background
      panel.grid.major  = element_line(color = "slategray2"),
      panel.grid.minor = element_line(color="grey90"),
      # The background color
      panel.background  = element_rect(fill = "grey95"),
      # the axis line
      axis.line         = element_line(color = "navyblue"),
      # Littel lines called ticks on the axis
      axis.ticks        = element_line(color = "navy"),
      # Numbers on the axis
      axis.text         = element_text(color = "navy"),
      # NEW ONES
      # rectangle element
      rect = element_rect(fill="grey10",colour = "white"),
      # axis title
      axis.title = element_text(colour="mediumblue"),
      # plot background
      plot.background = element_rect(fill="white"),
      # title
      plot.title = element_text(family = "", colour="midnightblue", size=14, hjust = 0, vjust=0.8,face = "bold"),
      plot.subtitle = element_text(family = "", colour="midnightblue", size=12, hjust = 0),
      #caption
      plot.caption = element_text(size = 9, colour = "steelblue3", hjust = 1),
      #legend
      legend.background = element_rect(fill = "grey80", colour = "grey80"),
      legend.text = element_text(colour = "black"),
      panel.border = element_blank()
      
    )
  
}
