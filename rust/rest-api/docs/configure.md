# UNM REST API 之組態設定說明

此 API 的組態設定檔名為 `config.toml`，應放置與 REST API 同路徑。

## 欄位說明

- `[context]`：即 [unm_types::Context](https://docs.rs/unm_types/latest/unm_types/struct.Context.html)。
  - `[context.config]`：`unm_types::Context` 底下的 `config` 欄位。
- `[rate_limit]`：與 Rate Limit 相關的設定。
  - `max_requests` (`u64`)：時間內允許的最多請求數。預設是 `30` 個請求數。
  - `limit_duration_seconds` (`u64`)：Rate Limit 的時限。預設是 `300` 秒。

## 範例設定

```toml
# The default context.
[context]
# The proxy URI to request services.
# Comment this line to disable Proxy feature.
# proxy_uri = ""

# Should we retrieve FLAC by default?
# enable_flac = false

# The search mode for waiting the response.
# Can be `fast_first` or `order_first`.
# search_mode = "fast_first"

# The default config for engines.
[context.config]
# "joox:cookie" = "..."

# Note that we don't allow users changing this value
# for the security concerns.
# "ytdl:exe" = "..."

# The rate limit configuration
[rate_limit]
# The max requests allowed per duration.
# By default, it is `30` requests.
# max_requests = 30

# The applied duration of the rate limit.
# By default, it is `300` seconds.
# limit_duration_seconds = 300
```
