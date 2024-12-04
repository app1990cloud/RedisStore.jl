module RedisStore
using Redis

abstract type AbstractRedisConnection end

mutable struct RedisPool <: AbstractRedisConnection
	pool::Channel{RedisConnection}
	max::Int
	current::Ref{Int}
end

function RedisPool(host, port, password, size)
	store = Channel{RedisConnection}(size)
	for _ in 1:size
		put!(store, Redis.RedisConnection(host = host, port = port, password = password))
	end
	return RedisPool(store, size, Ref(size))
end

function deque_connection(store::RedisPool)::Union{RedisConnection, Nothing}
	if isempty(store.pool)
		return nothing
	end
	store.current[] -= 1
	return take!(store.pool)
end

function release_connection(store::RedisPool, c::RedisConnection)
	if store.max[] !== store.current[]
		store.current[] += 1
		put!(store.pool, c)
		return true
	end
	return false
end

function rSET(store::RedisPool, i::Int, key::String, value::String)
	connection::Union{RedisConnection, Nothing} = nothing
	try
		connection = deque_connection(store)
		if connection isa Nothing
			return
		end
		Redis.select(connection, i)
		Redis.set(connection, key, value)
	finally
		if connection isa Nothing
			return false
		else
			release_connection(store, connection)
			return true
		end
	end
end

function rGET(store::RedisPool, i::Int, key::String)
	connection::Union{RedisConnection, Nothing} = nothing
	result::Union{String, Bool} = false
	try
		connection = deque_connection(store)
		if connection isa Nothing
			return
		end
		Redis.select(connection, i)
		result = Redis.get(connection, key)
	finally
		if connection isa Nothing
			return false
		else
			release_connection(store, connection)
			return result
		end
	end
end

end
