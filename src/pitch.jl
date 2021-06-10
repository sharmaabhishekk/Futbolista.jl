module Pitch

using Plots

"""
pitch_plot()

Plots a football pitch according to Statsbomb dimensions

Arguments:
line_color = color of the line
line_width = width of the lines

"""
function pitch_plot(;line_color, line_width)
    
    x1 = [0, 120, 120, 0, 0]; y1 = [0, 0, 80, 80, 0] ## pitch outlines 
    x2 = [0, 18, 18, 0, 0]; y2 = [18, 18, 62, 62, 18] ## left d-box 
    x3 = [102, 120, 120, 102, 102]; y3 = [18, 18, 62, 62, 18] ## right d-box 
    x4 = [0, 6, 6, 0, 0]; y4 = [30, 30, 50, 50, 30] ## left 6-yard box 
    x5 = [114, 120, 120, 114, 114]; y5 = [30, 30, 50, 50, 30] ## right 6-yard box 

    ##goals 
    x6 = [0,0]; y6 = [36, 44] 
    x7 = [120, 120]; y7=y6 

    ##halfway line and penalty spots 
    x8 = [60,60]; y8 = [0,80] 

    p = plot(x1, y1, color=line_color, lw=line_width) 
    plot!(p, x2, y2, color=line_color, lw=line_width) 
    plot!(p, x3, y3, color=line_color, lw=line_width) 
    plot!(p, x4, y4, color=line_color, lw=line_width) 
    plot!(p, x5, y5, color=line_color, lw=line_width) 
    plot!(p, x6, y6, color=line_color, lw=3*line_width) 
    plot!(p, x7, y7, color=line_color, lw=3*line_width) 
    plot!(p, x8, y8, color=line_color, lw=line_width) 
    scatter!(p, [12, 60, 108], [40, 40, 40], color=line_color, markersize=2) 
    
    xs, ys = Plots.unzip(Plots.partialcircle(0, 2π, 100, 4))
    
    plot!(p, xs[1:25], ys[1:25], color=line_color, lw=line_width)
    plot!(p, xs[25:50].+120, ys[25:50], color=line_color, lw=line_width)
    plot!(p, xs[50:75].+120, ys[50:75].+80, color=line_color, lw=line_width)
    plot!(p, xs[75:100], ys[75:100].+80, color=line_color, lw=line_width)

    xs, ys = Plots.unzip(Plots.partialcircle(0, 2π, 100, 8))    
    plot!(p, xs.+60, ys.+40, linecolor = line_color, fillalpha = 0.01, aspect_ratio = 1, lw=line_width) 
    plot!(p, legend=false, grid=false, border=:none, xlims=(-5, 125), ylims=(-3, 83)) 
    
    ys.+=40; xs.+=12
    plot!(p, xs[xs.>18], ys[xs.>18], color=line_color, lw=line_width)

    xs.+=96
    plot!(p, xs[xs.<102], ys[xs.<102], color=line_color, lw=line_width)    
    plot!(p, yflip=true)
    
    p

end

end


