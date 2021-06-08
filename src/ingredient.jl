module Ingredients

import Base: +,-,*,/

using ..Units: Unit, compatible, is_weight
using Base: String

struct Ingredient
    name::String
    amount::Unit
    v2w::Float64 # volume to weight
end

function Ingredient(name::String, amount::Real, unit::Symbol,v2w::Real)
    return Ingredient(name,Unit(amount,unit),v2w)
end

function +(i1::Ingredient,i2::Ingredient)
    if i1.name == i2.name
        if !compatible(i1.amount,i2.amount)
            if i1.v2w == 0.0
                error("No given conversion between $(i1.amount.unit) and $(i2.amount.unit) exist for ingredient $(i1.name)")
            end
            if is_weight(i2.amount) # convert first to kg or liter, then perform the v2w conversion
                tmp_u2 = Unit(Unit(i2.amount,:kg).amount / i2.v2w,:l)
            else
                tmp_u2 = Unit(Unit(i2.amount,:l).amount * i2.v2w,:kg)
            end
            return Ingredient(String(i1.name),i1.amount + tmp_u2,i1.v2w)
        else
            return Ingredient(String(i1.name),i1.amount + i2.amount,i1.v2w)
        end
    else
        error("Incompatible ingredients \"$(i1.name)\" and \"$(i2.name)\"")
    end
end

function -(i1::Ingredient,i2::Ingredient)
    if i1.name == i2.name
        if !compatible(i1.amount,i2.amount)
            if is_weight(i2) # convert first to kg or liter, then perform the v2w conversion
                tmp_u2 = Unit(Unit(i2.amount,:kg).amount / i2.v2w,:l)
            else
                tmp_u2 = Unit(Unit(i2.amount,:l).amount * i2.v2w,:kg)
            end
            return Ingredient(String(i1.name),i1.amount - tmp_u2,i1.v2w)
        else
            return Ingredient(String(i1.name),i1.amount - i2.amount,i1.v2w)
        end
    else
        error("Incompatible ingredients \"$(i1.name)\" and \"$(i2.name)\"")
    end
end

function *(i1::Ingredient,a::Real)
    return Ingredient(i1.name,i1.amount*a,i1.v2w)
end

function *(a::Real,i1::Ingredient)
    return i1*a
end

function /(i1::Ingredient,a::Real)
    return i1*(1/a)
end

end