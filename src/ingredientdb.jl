module IngredientDatabase
import JSON

function validate_conversion(json::Dict{String,Any})::Bool
    if !all(k -> isa(k,String),keys(json))
        return false
    else
        for v in values(json)
            if !all(p::Pair -> isa(p.first, String) && isa(p.second,Float64), collect(v))
                return false
            end
        end
        return true
    end
end

function parse_database(filename::AbstractString)::Dict{String,Dict{String,Dict{String,Float64}}}
    db = JSON.parsefile(filename)
    if !(all(k -> isa(k,String), keys(db)) && all(conv -> validate_conversion(conv), values(db)))
        return Dict{String,Dict{String,Dict{String,Float64}}}()
    end
    return db
end

end