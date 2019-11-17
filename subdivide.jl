using LinearAlgebra
using SymPy
# ====================================================
# function [x, y] = subdivide(xcoords, ycoords, niters, scheme, move2limit)
#
# This function subdivides the given control polygon `niters` times according to
# the requested subdivision scheme.  Finally, each point is moved to
# the limit curve using Eigen-analysis.
#
# xcoords and ycoords are the x- and y-coordinates of the control points.
# niters is the number of subdivision iterations to perform.
# scheme specifies the scheme to use:
#   if scheme == 1, use the 1/8 1/8 3/4 (Cubic) subdivision scheme
#   if scheme == 2, use the 1/7 1/7 5/7 subdivision scheme
# move2limit specifies whether the points should be moved to their
#            limit positions after subdivision.
function subdivide(xcoords, ycoords, niters, scheme, move2limit)
    # YOUR IMPLEMENTATION GOES HERE
    fxcoordinates =[]
    fycoordinates =[]
    matrix = I
    nvector = I
    if(scheme == 1)
        matrix = ([[0.5 0.5 0];[0.125 0.75 0.125];[0 0.5 0.5]])
        nvector = [(1/6) (2/3) (1/6)]
    else
        matrix = ([[0.5 0.5 0];[(1/7) (5/7) (1/7)];[0 0.5 0.5]])
        nvector = [(2/11) (7/11) (2/11)]
    end

    for k in 1:(niters)
        fycoordinates = []
        fxcoordinates = []
        for i in 1:length(xcoords)

            if(i == 1)
                xvector = [xcoords[end] xcoords[i] xcoords[i+1]]
                yvector = [ycoords[end] ycoords[i] ycoords[i+1]]
            elseif(i == length(xcoords))
                xvector = [xcoords[i-1] xcoords[i] xcoords[1]]
                yvector = [ycoords[i-1] ycoords[i] ycoords[1]]

            else
                xvector = [xcoords[i-1] xcoords[i] xcoords[i+1]]
                yvector = [ycoords[i-1] ycoords[i] ycoords[i+1]]
            end

            push!(fxcoordinates,dot(matrix[2,:], xvector))
            push!(fycoordinates,dot(matrix[2,:], yvector))
            push!(fxcoordinates,dot(matrix[3,:], xvector))
            push!(fycoordinates,dot(matrix[3,:], yvector))

        end

        xcoords =fxcoordinates
        ycoords = fycoordinates

    end

    if(move2limit == 1)
        nmatrix = matrix^100
        mx = []
        my = []
        for i in 1:length(xcoords)
            if(i == 1)
                xvector = [xcoords[end] xcoords[i] xcoords[i+1]]
                yvector = [ycoords[end] ycoords[i] ycoords[i+1]]
            elseif(i == length(xcoords))
                xvector = [xcoords[i-1] xcoords[i] xcoords[1]]
                yvector = [ycoords[i-1] ycoords[i] ycoords[1]]

            else
                xvector = [xcoords[i-1] xcoords[i] xcoords[i+1]]
                yvector = [ycoords[i-1] ycoords[i] ycoords[i+1]]
            end
            push!(mx,dot(nvector, xvector))
            push!(my,dot(nvector, yvector))

        end
        xcoords =mx
        ycoords =my
    end

    return xcoords,ycoords
end
