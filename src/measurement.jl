module Measurements

include("defines/units.jl")
using Base: Float64

export Measurement

struct Measurement
    amount::Float64
    is_weight::Bool
end

function Measurement(amount::Float64,unit::Symbol)
    if Units.is_unit(unit)
        if Units.is_weight(unit)
            return Measurement(Units.convert_weight(amount,unit),true) # save as kg
        else
            return Measurement(Units.convert_volume(amount,unit),false) # save as l
        end
    else
        error("Invalid unit $unit")
    end
end

end