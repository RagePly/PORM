module Measurements

using Base: Float64
export Measurement

struct Measurement
    amount::Float64
    type::String # volume, weight etc
    conv::Dict{String,Float64}
end

function get_conversions(type::String, conv_db::Dict{String,Dict{String,Float64}})::Dict{String,Float64}
    if isempty(conv_db) || type ∉ keys(conv_db)
        return Dict{String,Float64}()
    else
        return deepcopy(conv_db[type])
    end
end

function Measurement(x::Float64, type::String; conv_db::Dict{String,Dict{String,Float64}} = Dict{String,Dict{String,Float64}}())
    return Measurement(x,type,get_conversions(type,conv_db))
end

end