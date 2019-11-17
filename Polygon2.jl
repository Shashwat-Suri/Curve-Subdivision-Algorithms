using Plots
include("subdivide.jl")
# ====================================================
#                Polygon 2
# ====================================================


# ================= set the control points

x1 = [0, 1, 3, 2, 4, 3, 2]
y1 = [0, 3, 2, 4, 3, 0, 1]

# ================= Draw scheme 1
p1 = plot(Shape(x1, y1), color = :green, title="Cubic")

x, y = subdivide(x1, y1, 0, 1, 0)
p2 = plot(Shape(x, y), color = :green, title="k=0")

x, y = subdivide(x1, y1, 1, 1, 0)
p3 = plot(Shape(x, y), color = :green, title="k=1")

x, y = subdivide(x1, y1, 10, 1, 0)
p4 = plot(Shape(x, y), color = :green, title="k=10")

# ================= Draw scheme 2

p5 = plot(Shape(x1, y1), color = :green, title="1/7 5/7 1/7")

x, y = subdivide(x1, y1, 0, 2, 0)
p6 = plot(Shape(x, y), color = :green, title="k=0")

x, y = subdivide(x1, y1, 1, 2, 0)
p7 = plot(Shape(x, y), color = :green, title="k=1")

x, y = subdivide(x1, y1, 5, 2, 0)
p8 = plot(Shape(x, y), color = :green, title="k=5")


plot(p1,p5,p2,p6,p3,p7,p4,p8,layout=(4,2),legend=false)
