using JSON
struct ConversionCleanup
    name::String
    l2w::String
    small::String
    medium::String
    large::String
    portion::String
end

a = open(f->read(f,String),"conversion_website_copy.txt")
b = split(a,"\r\n")
c = map(s -> replace(s,"\t" => ""),b)
d = Vector{ConversionCleanup}()
for i in 1:6:length(c) - 5
    push!(d,ConversionCleanup(map(String,c[i:i+5])...))
end

struct ConversionResult
    name::String
    l2w::Float64
    small::Float64
    medium::Float64
    large::Float64
    portion::Float64
end

e = Vector{ConversionResult}()
for v in d
    l2w = contains(v.l2w,"-") ? 0.0 : parse(Float64,strip(replace(replace(v.l2w,"g"=>""),","=>".")))/100
    small = contains(v.small,"-") ? 0.0 : parse(Float64,strip(replace(replace(v.small,"g"=>""),","=>".")))/1000
    medium = contains(v.medium,"-") ? 0.0 : parse(Float64,strip(replace(replace(v.medium,"g"=>""),","=>".")))/1000
    large = contains(v.large,"-") ? 0.0 : parse(Float64,strip(replace(replace(v.large,"g"=>""),","=>".")))/1000
    portion = contains(v.portion,"-") ? 0.0 : parse(Float64,strip(replace(replace(v.portion,"g"=>""),","=>".")))/1000
    push!(e,ConversionResult(v.name,l2w,small,medium,large,portion))
end

f = Dict{String,Vector{Float64}}()
for v in e
    f[v.name] = [v.l2w,v.small,v.medium,v.large,v.portion]
end

open("conversion_result.json","w") do io
    JSON.print(io,f,4)
end
