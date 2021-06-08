module Graph

export DistanceMatrix

struct DistanceMatrix
    indexMap::Dict{String,Int64}
    table::Matrix{Float64}
end

function DistanceMatrix(vertexList::Dict{String,Dict{String,Float64}})
    # retrieve all types
    nameSet = Set{String}()
    union!(nameSet, Set(keys(vertexList)))
    union!(nameSet,last(accumulate((a,b) -> union!(a,Set(keys(b))),values(vertexList);init=Set{String}())))
    index_map::Dict{String,Int64} = Dict(k=>i for (i,k) in enumerate(nameSet))
    table_init = zeros(Float64,length(index_map),length(index_map))
    # fill in diagonal
    for i in 1:length(index_map)
        table_init[i,i] = 1.0
    end

    # fill in defined values
    for (from_name,to_dict) in pairs(vertexList)
        i1 = index_map[from_name]
        for (to_name,conv_ratio) in pairs(to_dict)
            i2 = index_map[to_name]
            table_init[i1,i2] = conv_ratio
            table_init[i2,i1] = 1/conv_ratio
        end
    end
    return DistanceMatrix(index_map,table_init)
end


end