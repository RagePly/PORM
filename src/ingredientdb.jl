module IngredientDatabase
import JSON

struct Ingredients
    database::Dict{String,Vector{Float64}}
end

function Ingredients(filename::AbstractString)::Ingredients
    return Ingredients(parse_database(filename))
end

function parse_database(filename::AbstractString)::Dict{String,Vector{Float64}}
    json_str = open(f->read(f,String),filename)
    db = JSON.parse(json_str; inttype=Float64)
    try
        db = convert(Dict{String,Vector{Float64}}, db)
    catch
        return Dict{String,Vector{Float64}}()
    end
    return db
end

end