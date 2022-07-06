@testset "Bmesh2D" begin

    #
    #    Valid inputs (no error)
    #
    nn = 2
    ne = 1
    coord = [0.0 0.0 ;
             1.0 0.0]
    connect = [1 2]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss2D

    # truss2D
    @test isa(Bmesh2D(etype,nn,ne,coord,connect,Lx,Ly,nx,ny),Bmesh2D)

    # solid2D
    @test isa(Bmesh2D(:solid2D,nn,ne,coord,connect,Lx,Ly,nx,ny),Bmesh2D)

    #
    # Should throw assertion error 
    # @assert size(coord,1)==nn "Bmesh2D:: number of rows in coord must be equal to the number of nodes
    # 
    @test_throws AssertionError Bmesh2D(etype,10,ne,coord,connect,Lx,Ly,nx,ny)

    #
    # Should throw assertion error 
    # @assert size(coord,2)==2 "Bmesh2D:: number of columns in coord must be equal to 2"
    #
    wcoord = [0.0 0.0 0.0 ; 1.0 0.0 0.0]
    @test_throws AssertionError Bmesh2D(etype,nn,ne,wcoord,connect,Lx,Ly,nx,ny)

    #
    # Should throw assertion error 
    # @assert size(connect,1)==ne "Bmesh2D:: number of rows in connect must be equal to the number of elements"
    wconnect = [1 2 ; 3 4]
    @test_throws AssertionError Bmesh2D(etype,nn,ne,coord,wconnect,Lx,Ly,nx,ny)

    #
    # Should throw assertion error 
    # @assert etype==:truss2D || etype==:solid2D  "Bmesh2D:: just :truss2D and :solid2D by now"
    @test_throws AssertionError Bmesh2D(:other,nn,ne,coord,connect,Lx,Ly,nx,ny)

end # Bmesh2D

@testset "Bmesh2D - origin" begin

    #
    #    Valid inputs (no error)
    #
    nn = 2
    ne = 1
    coord = [0.0 0.0 ;
             1.0 0.0]
    connect = [1 2]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :truss2D

    origin = (1.0,2.0)

    # truss2D
    b2o = Bmesh2D(etype,nn,ne,coord,connect,Lx,Ly,nx,ny,origin=origin)

    # Coordinates of node 1
    @test b2o.coord[1,1] == origin[1]
    @test b2o.coord[1,2] == origin[2]

    # Coordinates of the last node
    @test b2o.coord[end,1] == Lx+origin[1]
    @test b2o.coord[end,2] == Ly+origin[2]


    #
    #    Valid inputs (no error)
    #
    nn = 4
    ne = 1
    coord = [0.0 0.0 ;
             1.0 0.0 ; 
             1.0 1.0 ;
             0.0 1.0]
    connect = [1 2 3 4]
    Lx = 1.0
    Ly = 1.0
    nx = 1
    ny = 1
    etype = :solid2D

    origin = (1.0,2.0)

     # solid2D
     b2o = Bmesh2D(etype,nn,ne,coord,connect,Lx,Ly,nx,ny,origin=origin)

     # Coordinates of node 1
     @test b2o.coord[1,1] == origin[1]
     @test b2o.coord[1,2] == origin[2]
 
     # Coordinates of the last node
     @test b2o.coord[end,1] == Lx+origin[1]
     @test b2o.coord[end,2] == Ly+origin[2]
 
end