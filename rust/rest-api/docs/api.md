# UNM REST API 的 Endpoint

## 說明

- `<api_address>` 是您 API 的 HTTP(S) 網址。
  - 範例：`http://localhost:3000`
- Schema 是這個 API 回應的資料結構。
  - 使用 [JSON Schema (Draft-07)](https://json-schema.org) 定義。

## `GET /`：檢視目前 API 的一般性資訊

這個 Endpoint 除了代表著這個 API 是否可以接受請求，亦可從中檢視目前 API 的一般性資訊。

### `/` 的 Schema 路徑

```sh
curl --location --request GET '<api_address>/schema/v1/index'
```

### `/` 的範例請求

```sh
curl --location --request GET '<api_address>/'
```

### `/` 的範例回應

```json
{
    "success": true,
    "version": "0.1.0"
}
```

## `GET /docs/…`：本 REST API 的文件

這個 Endpoint 包含適用於本 REST API 版本的文件。

目前提供的文件如下（幾乎所有文件都可以在 codebase 的 `docs` 資料夾找到）：

- `readme`：本 REST API 的讀我 Markdown 檔案。
- `api`：本 REST API 的 Endpoint Markdown 說明。
- `configure`：本 REST API 的 `config.toml` 設定說明

### `docs` 的範例請求

```sh
curl --location --request GET '<api_address>/docs/readme'
```

### `docs` 的範例回應

回傳此文件的純文字版本。

## `GET /schema/…`：擺放各 API 回應的資料結構

請參閱各 API 之〈⋯⋯的 Schema 路徑〉一節。相關範例請見 codebase 根目錄中
`src/schema/v1` 的 JSON 檔案。

## `POST /api/v1/search`：搜尋音樂並取回本資源的識別物件

這個 Endpoint 為 UNM (Rust) Executor 的封裝。

### `/api/v1/search` 的請求資料結構

- `engines` (`string[] | null`)：要使用的引擎。
  - 本處的 `string` 應放置引擎 ID
  - 若不指定 (`engines: null`) 則使用預設引擎集。
  - 可用引擎請見
    [UNM 說明文件〈支援的所有引擎〉](https://github.com/UnblockNeteaseMusic/server-rust#支援的所有引擎)
    一節。
- `song`：要搜尋的歌曲資訊。
  - 請參見 [unm_types::Song](https://docs.rs/unm_types/0.2.0-pre.5/unm_types/struct.Song.html) 的說明文件。
    - `String` 即 `string`
    - `i64` 即 `number`
    - `Option<T>` 即 `T | null`
    - `Vec<T>` 即 `T[]`
    - `HashMap<K, V>` 即 `Record<K, V>`
  - 如需 JSON Schema，請參見 `<api_address>/schema/v1/search#/definitions/Song`。
- `context` (`Record<string, string> | null`)：可供使用者設定的 context 子集
  - 目前最新可用的 Context 資訊，建議查看 `src/executor/context.rs` 檔案。
  - `enable_flac` (`boolean | null`)：是否接收 FLAC 內容
  - `search_mode` (`"fast_first" | "order_first" | null`)：搜尋模式
    - 可使用之完整模式可見 <https://docs.rs/unm_types/0.2.0-pre.5/unm_types/enum.SearchMode.html>
      - 將 CamelCase 改成 snake_case
    - 預設是 `fast_first`

### `/api/v1/search` 的 Schema 路徑

```sh
curl --location --request GET 'http://localhost:3000/schema/v1/search'
```

### `/api/v1/search` 的範例請求

```sh
curl --location --request POST '<api_address>/api/v1/search' \
--header 'Content-Type: application/json' \
--data-raw '{
    "song": {
        "id": "",
        "name": "FANCY",
        "artists": [
            {
                "id": "",
                "name": "Twice"
            }
        ]
    },
    "context": {
        "enable_flac": true
    }
}'
```

### `/api/v1/search` 的範例回應

```json
{
    "source": "kuwo",
    "identifier": "213107912",
    "song": {
        "id": "213107912",
        "name": "Fancy-190501MBC",
        "duration": 239000,
        "artists": [
            {
                "id": "263053",
                "name": "Twice"
            }
        ],
        "album": {
            "id": "0",
            "name": ""
        },
        "context": null
    },
    "pre_retrieve_result": {
        "source": "kuwo",
        "url": "http://<redacted>"
    }
}
```

## `POST /api/v1/retrieve`：取回某個資源

這個 Endpoint 為 UNM (Rust) Executor 的封裝。

### `/api/v1/retrieve` 的請求資料結構

- `retrieved_song_info` (schema: `/schema/v1/search`)：`/api/v1/search` 的完整回應。
- `context` (`Record<string, string> | null`)：可供使用者設定的 context 子集
  - 同 `/api/v1/search` 請求資料結構的 `context`

### `/api/v1/retrieve` 的回應

它會直接轉接收到的請求，如下：

![API v1 Retrieve Response Example](./image/api-v1-retrieve-response-example.png)

### `/api/v1/retrieve` 的範例請求

```sh
curl --location --request POST 'http://localhost:3000/api/v1/retrieve' \
--header 'Content-Type: application/json' \
--data-raw '{
    "retrieved_song_info": {
        "source": "bilibili",
        "identifier": "1226388",
        "song": {
            "id": "1226388",
            "name": "FANCY - TWICE 男声一人翻唱 (Cover TWICE)",
            "duration": null,
            "artists": [
                {
                    "id": "1798257",
                    "name": "赫星星Alex"
                }
            ],
            "album": null,
            "context": null
        },
        "pre_retrieve_result": {
            "source": "bilibili",
            "url": "http://<redacted>"
        }
    }
}
'
```
