using SymPy
include("DrawCurve.jl")

# t-values range from 0 to 2
n_t = Int(2 / 0.01)
t_vals = collect(range(0, 2, length=n_t))

# place holders for tangent, normal, arclength, and curvature.
dummy_scalar_vals = t_vals;
dummy_vector_vals = ones(n_t, 2) * 0.1;

# Register t as a symbolic variable to allow symbolic differentiation
t = symbols(:t)


# ===================================================================
#                            Curve 1
# ===================================================================

x1 = t
y1 = t.^2

# Evaluate curve
x = float(x1.(t_vals))
y = float(y1.(t_vals))
pos = hcat(x, y)


# Compute curvature, arclength, tangents and normals at each t-value here.
x1d = 1
y1d = 2t
x1d2 = 0
y1d2 = 2

#tangent

m = (((x1d)^2)+((y1d)^2))^0.5
x1t = float((x1d/m).(t_vals))
y1t = float((y1d/m).(t_vals))
tangent = hcat(x1t,y1t)

#Curvature
m = (((x1d2)^2)+((y1d2)^2)+(t*0))^0.5 #I've added the (t*0) term simply to make the code more uniform
curvature = float(m.(t_vals))

#Normal
x1n = float((x1d2/m).(t_vals))
y1n = float((y1d2/m).(t_vals))
normal = hcat(x1n,y1n)

#arclength
xarc = float(t.(t_vals))
yarc = float((t^2).(t_vals))
arc = hcat(xarc,yarc)


# Draw the curve
draw_curve_helper(pos, curvature, arc, tangent./4, normal)
