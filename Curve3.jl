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
#                            Curve 3
# ===================================================================

x3 = cos(t.*pi)
y3 = sin(t.*pi/3)

# Evaluate curve
x = float(x3.(t_vals))
y = float(y3.(t_vals))
pos = hcat(x, y)


# Compute curvature, arclength, tangents and normals at each t-value here.
x1d = diff(x3,t)
y1d = diff(y3,t)
x1d2 =diff(x1d,t)
y1d2 = diff(y1d,t)
m1d = norm(hcat(x1d,y1d))
m2d = norm(hcat(x1d2,y1d2))


#tangent

x1t = float((x1d/m1d).(t_vals))
y1t = float((y1d/m1d).(t_vals))
tangent = hcat(x1t,y1t)

#Curvature
ex = ((x1d*y1d2)-(y1d*x1d2))/(m1d^3)
curvature = float(ex.(t_vals))

#Normal
x1n = float(-(y1d/m1d).(t_vals))
y1n = float((x1d/m1d).(t_vals))
normal = hcat(x1n,y1n)

#arclength

arc=float((integrate(m1d,(t,0,t))).(t_vals))


# Draw the curve
draw_curve_helper(pos, curvature, arc, tangent./8, normal./8)
