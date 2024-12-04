# RedisStore.jl

RedisStoreは、JuliaでRedis接続プールを提供するモジュールです。このモジュールを使用することで、複数のRedis接続を効率的に管理し、パフォーマンスを向上させることができます。

### インストール
このモジュールをプロジェクトに追加するには、Redis.jlをインストールする必要があります。

```julia
Pkg >> add Redis
```

### 接続プールの作成
以下のコードは、指定されたホスト、ポート、パスワード、およびプールサイズを使用して接続プールを作成します。
```julia
pool = RedisStore.RedisPool("your_redis_host", 6379, "your_password", "number of object")
```

### キーのセット
rSET関数を使用して、指定されたRedisデータベースインデックス、キー、および値をセットします。

```julia
result = RedisStore.rSET(pool, 0, "my_key", "my_value")
println(result)  # 出力: true (成功した場合)
```
## 関数詳細
RedisPool
接続プールを初期化します。

引数:

host::String: Redisサーバーのホスト名

port::Int: Redisサーバーのポート番号

password::String: Redisサーバーのパスワード

size::Int: 接続プールのサイズ

戻り値: RedisPoolオブジェクト

deque_connection
プールから接続を取得します。

引数:

store::RedisPool: Redisプールオブジェクト

戻り値: RedisConnectionオブジェクトまたはNothing

release_connection
使用した接続をプールに戻します。

引数:

store::RedisPool: Redisプールオブジェクト

c::RedisConnection: リリースする接続

戻り値: Bool（成功した場合はtrue）

rSET
Redisにキーと値をセットします。

引数:

store::RedisPool: Redisプールオブジェクト

i::Int: Redisデータベースインデックス

key::String: セットするキー

value::String: セットする値

戻り値: Bool（成功した場合はtrue）

rGET
Redisからキーの値を取得します。

引数:

store::RedisPool: Redisプールオブジェクト

i::Int: Redisデータベースインデックス

key::String: 取得するキー

戻り値: StringまたはBool（キーが存在しない場合はfalse）
