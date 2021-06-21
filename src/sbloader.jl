module Statsbomb

using DataFrames
using JSON: Parser, parsefile
using HTTP

struct SBLoader
    mode::String
    dir_or_url::String
    SBLoader(mode="remote", dir_or_url="https://raw.githubusercontent.com/statsbomb/open-data/master/data/") = new(mode, dir_or_url)
end

""" 
load_competitions

Function to get the names of all available competitions in the free data

Arguments

loader

Returns 

DataFrame 
"""
function load_competitions(loader::SBLoader)
    
    if loader.mode == "local"

        comp_file = joinpath(loader.dir_or_url, "competitions.json")
        comp = parsefile(comp_file)   
        return vcat(DataFrame.(comp)..., cols=:union)
    
    elseif loader.mode == "remote"
        
        resp = HTTP.get(loader.dir_or_url*"competitions.json")
        str = String(resp.body)
        comp = Parser.parse(str)
        return vcat(DataFrame.(comp)..., cols=:union)
    
    end
end

""" 
load_matches

Function to get matches available from a particular season and competition

Arguments

loader
comp_id
season_id

Returns 

DataFrame 
"""
function load_matches(loader::SBLoader, comp_id, season_id)
    
    if loader.mode == "local"        
        matches = parsefile(joinpath(joinpath(loader.dir_or_url*"\\matches", string(comp_id)), string(season_id)*".json"));
        
    elseif loader.mode == "remote"      
        url = loader.dir_or_url*"/matches/"*string(comp_id)*"/"*string(season_id)*".json"
        resp = HTTP.get(url)
        str = String(resp.body)
        matches = Parser.parse(str)
    end
    
    df = vcat(DataFrame.(matches)..., cols=:union)
    df_home = vcat(DataFrame.(df."home_team")..., cols=:union)
    df_away = vcat(DataFrame.(df."away_team")..., cols=:union)

    df = hcat([df, df_home, df_away]..., makeunique=true)    
    select!(df, Not([:home_team, :away_team]))        
    
    df
end

""" 
load_events

Function to get all events of a match

Arguments

loader
match_id

Returns 

DataFrame 
"""
function load_events(loader::SBLoader, match_id)
    
    if loader.mode == "local"
            
        data = parsefile(joinpath(loader.dir_or_url, "events\\"*string(match_id)*".json"))
        
    elseif loader.mode == "remote"
        
        url = loader.dir_or_url*"/events/"*string(match_id)*".json"
        resp = HTTP.get(url)
        str = String(resp.body)
        data = Parser.parse(str)
    end
        
    data = [Dict(isa(v, Array) ? k=>string(v) : k=> v for (k,v) in d) for d in data]     ##converting arrays to string to stop duplicating rows 
    events = vcat(DataFrame.(data)..., cols=:union)
end

end ##end of module