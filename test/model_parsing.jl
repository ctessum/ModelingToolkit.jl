using ModelingToolkit, Test
using ModelingToolkit: get_gui_metadata, VariableDescription, getdefault
using URIs: URI

ENV["MTK_ICONS_DIR"] = "$(@__DIR__)/icons"

@connector RealInput begin
    u(t), [input = true]
end
@connector RealOutput begin
    u(t), [output = true]
end
@model Constant(; k = 1) begin
    @components begin
        output = RealOutput()
    end
    @parameters begin
        k = k, [description = "Constant output value of block"]
    end
    @equations begin
        output.u ~ k
    end
end

@variables t
D = Differential(t)

@connector Pin begin
    v(t) = 0                  # Potential at the pin [V]
    i(t), [connect = Flow]    # Current flowing into the pin [A]
    @icon "pin.png"
end

@model OnePort begin
    @components begin
        p = Pin()
        n = Pin()
    end
    @variables begin
        v(t)
        i(t)
    end
    @icon "oneport.png"
    @equations begin
        v ~ p.v - n.v
        0 ~ p.i + n.i
        i ~ p.i
    end
end

@model Ground begin
    @components begin
        g = Pin()
    end
    @icon begin
        read(abspath(ENV["MTK_ICONS_DIR"], "ground.svg"), String)
    end
    @equations begin
        g.v ~ 0
    end
end

resistor_log = "$(@__DIR__)/logo/resistor.svg"
@model Resistor(; R = 1) begin
    @extend v, i = oneport = OnePort()
    @parameters begin
        R = R
    end
    @icon begin
        """<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="80" height="30">
  <path d="M10 15
l15 0
l2.5 -5
l5 10
l5 -10
l5 10
l5 -10
l5 10
l2.5 -5
l15 0" stroke="black" stroke-width="1" stroke-linejoin="bevel" fill="none"></path>
</svg>
"""
    end
    @equations begin
        v ~ i * R
    end
end

@model Capacitor(; C = 1) begin
    @extend v, i = oneport = OnePort()
    @parameters begin
        C = C
    end
    @icon "https://upload.wikimedia.org/wikipedia/commons/7/78/Capacitor_symbol.svg"
    @equations begin
        D(v) ~ i / C
    end
end

@model Voltage begin
    @extend v, i = oneport = OnePort()
    @components begin
        V = RealInput()
    end
    @equations begin
        v ~ V.u
    end
end

@model RC begin
    @components begin
        resistor = Resistor(; R)
        capacitor = Capacitor(; C = 10)
        source = Voltage()
        constant = Constant()
        ground = Ground()
    end
    @equations begin
        connect(constant.output, source.V)
        connect(source.p, resistor.p)
        connect(resistor.n, capacitor.p)
        connect(capacitor.n, source.n, ground.g)
    end
end

@named rc = RC(; resistor.R = 20)
@test getdefault(rc.resistor.R) == 20
@test getdefault(rc.capacitor.C) == 10
@test getdefault(rc.constant.k) == 1

@test get_gui_metadata(rc.resistor).layout == Resistor.structure[:icon] ==
      read(joinpath(ENV["MTK_ICONS_DIR"], "resistor.svg"), String)
@test get_gui_metadata(rc.ground).layout ==
      read(abspath(ENV["MTK_ICONS_DIR"], "ground.svg"), String)
@test get_gui_metadata(rc.capacitor).layout ==
      URI("https://upload.wikimedia.org/wikipedia/commons/7/78/Capacitor_symbol.svg")
@test OnePort.structure[:icon] ==
      URI("file:///" * abspath(ENV["MTK_ICONS_DIR"], "oneport.png"))
@test ModelingToolkit.get_gui_metadata(rc.resistor.p).layout == Pin.structure[:icon] ==
      URI("file:///" * abspath(ENV["MTK_ICONS_DIR"], "pin.png"))

@test length(equations(structural_simplify(rc))) == 1

@model MockModel(; cval, gval, jval = 6) begin
    @parameters begin
        a
        b(t)
        c(t) = cval
        d = 2
        e, [description = "e"]
        f = 3, [description = "f"]
        g = gval, [description = "g"]
        h(t), [description = "h(t)"]
        i(t) = 5, [description = "i(t)"]
        j(t) = jval, [description = "j(t)"]
    end
end

@named model = MockModel(cval = 1, gval = 4)

@test hasmetadata(model.e, VariableDescription)
@test hasmetadata(model.f, VariableDescription)
@test hasmetadata(model.g, VariableDescription)
@test hasmetadata(model.h, VariableDescription)
@test hasmetadata(model.i, VariableDescription)
@test hasmetadata(model.j, VariableDescription)

@test getdefault(model.c) == 1
@test getdefault(model.d) == 2
@test getdefault(model.f) == 3
@test getdefault(model.g) == 4
@test getdefault(model.i) == 5
@test getdefault(model.j) == 6
