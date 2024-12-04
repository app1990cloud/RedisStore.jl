# RedisStore.jl

RedisStoreは、JuliaでRedis接続プールを提供するモジュールです。このモジュールを使用することで、複数のRedis接続を効率的に管理し、パフォーマンスを向上させることができます。

### インストール
このモジュールをプロジェクトに追加するには、Redis.jlをインストールする必要があります。

```terminal
Pkg >> add Redis
```

### 接続プールの作成
以下のコードは、指定されたホスト、ポート、パスワード、およびプールサイズを使用して接続プールを作成します。
```terminal
pool = RedisStore.RedisPool("your_redis_host", 6379, "your_password", "number of object")
```

### キーのセット
rSET関数を使用して、指定されたRedisデータベースインデックス、キー、および値をセットします。

```julia
result = RedisStore.rSET(pool, 0, "my_key", "my_value")
println(result)  # 出力: true (成功した場合)

```

```terminal
Pkg >> add Redis
```

```terminal
Pkg >> add Redis
```

```terminal
Pkg >> add Redis
```

```terminal
Pkg >> add Redis
```
