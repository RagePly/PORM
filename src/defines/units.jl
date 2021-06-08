module Units
import Base: +, -, *, /
using Base: Symbol, Float64, Real
# conversion to kg
const weight_kg = Dict{Symbol,Float64}(
    :kg => 1.,
    :hg => .1,
    :g => .001,
    :lb => 0.454,
    :oz => 0.0284
)

const volume_l = Dict{Symbol,Float64}(
    :l => 1.0,
    :dl => .1,
    :cl => .01,
    :ml => .001,
    :msk => .015,
    :tsk => .005,
    :krm => .001,
    :kkp => .15,
    :tkp => .25
)

struct Unit
    amount::Real
    unit::Symbol
    Unit(n::Real,u::Symbol) = is_unit(u) ? new(n,u) : error("Invalid unit $u")
end

function Unit(prev::Unit,new_unit::Symbol)::Unit
    if is_unit(new_unit)
        if is_weight(new_unit) && is_weight(prev.unit)
            return Unit(convert_weight(prev.amount,prev.unit,new_unit),new_unit)
        elseif !is_weight(new_unit) && !is_weight(prev.unit)
            return Unit(convert_volume(prev.amount,prev.unit,new_unit),new_unit)
        else
            error("Cannot implicitly convert from $(prev.unit) to $new_unit")
        end
    else
        error("Invalid unit $new_unit")
        return Nothing
    end
end

function +(a::Unit,b::Unit)
    b_temp = Unit(b,a.unit)
    return Unit(a.amount + b_temp.amount,a.unit)
end

function -(a::Unit,b::Unit)
    b_temp = Unit(b,a.unit)
    return Unit(a.amount + b_temp.amount,a.unit)
end

function *(a::Unit,b::Real)
    return Unit(a.amount*b,a.unit)
end

function *(b::Real,a::Unit)
    return a*b
end

function /(a::Unit,b::Real)
    return Unit(a.amount/b,a.unit)
end

function convert_weight(amount::Real, from_unit::Symbol, to_unit::Symbol = :kg)
    return amount*weight_kg[from_unit]/weight_kg[to_unit]
end

function convert_volume(amount::Real, from_unit::Symbol, to_unit::Symbol = :l)
    return amount*volume_l[from_unit]/volume_l[to_unit]
end

function is_unit(unit::Symbol)
    return unit ∈ keys(weight_kg) || unit ∈ keys(volume_l)
end

function is_weight(unit::Symbol)
    return unit ∈ keys(weight_kg)
end

function is_weight(unit::Unit)
    return is_weight(unit.unit)
end

function compatible(u1::Unit,u2::Unit)
    return is_weight(u1.unit) == is_weight(u2.unit)
end

end