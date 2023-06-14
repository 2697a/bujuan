# `UnblockNeteaseMusic/server-rust`

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2FUnblockNeteaseMusic%2Fserver-rust.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2FUnblockNeteaseMusic%2Fserver-rust?ref=badge_shield)

Rust 版本的 [UnblockNeteaseMusic/server](https://github.com/UnblockNeteaseMusic/server)，以效能、穩定性及可維護性為目標。

> 目前使用者文件及開發文件 **仍在撰寫**，在此之前有任何問題，歡迎開 Discussion 詢問。

## ⚠️ 免責聲明 Disclaimer

- 本函式庫僅供 **個人學習及研究** Rust 網路服務之使用，並 **未用於營利用途**。
- 除授權條款列載之事項，您亦已知將此函式庫用於商業或其他競爭行為上，**有可能會引來法律風險**。
- 若您認為本函式庫侵犯您的智慧財產權，**請發出 PR、Issue 或 DMCA 請求，表達您想移除相關引擎或程式碼之意願**。

## 架構

> 註：目前 UnblockNeteaseMusic/server 只實作 engine/resolver 的部分。

- `crypto`：與加密相關的函式庫，如 md5、aes128 等。
- `engine-base`：Engine 的抽象部分，包含一個 Engine 應有的介面、整合所有 Engines 的 Executor 等。
- `engines`
  - 這目錄底下的是官方提供的引擎，所有引擎都是選擇性依賴、使用的。
  - 您可以自行實作其他平台，並發佈到 crates.io（當然也歡迎發 PR 讓引擎納入本 codebase 一併管理）。
  - 每個 Engine 都有 `examples` 方便測試單一引擎模組。如您是開發者，可仿造其它引擎，撰寫自己的 example。
- `api-utils`：用來開發 UNM 的實用工具。
- `request`：UNM 的 reqwest 封裝，自動帶上 `User-Agent` 等 headers。
- `selector`：包含選擇最適音樂項目的演算法。
- `types`：UNM 的各種基礎類型（如 `Song`、`Artist`⋯⋯）
- `test-utils`：方便撰寫測試方法及 demo 的工具集。
- `napi`：Node.js 的 UNM (Rust) 綁定。
  - 這個綁定因 napi 限制，目前不像 Rust 版一樣有方便的擴充系統。
  - 原則上是啟用 `engines/` 底下的所有引擎。
- `rest-api`：UNM 的 RESTful API
  - 因安全性疑慮，目前不考慮為 RESTful API 提供不修改程式碼的擴充方案。
  - 原則上是啟用 `engines/` 底下的所有引擎。
- `demo`：用來測試及展示 UNM (Rust) 的 demo 程式。
  - 啟動 Demo：`cargo run --release --bin unm_engine_demo`

## 使用

### Rust 函式庫

> 可以參考 `engine-demo` 的用法～

首先，您需要從 <https://crates.io> 引用至少三個元件：

- `unm_engine`：包含並行查詢音源結果的 Executor。
- `unm_engine_[想要的引擎]`：用來從音源搜尋的引擎。
- `unm_types`：UNM 的基礎類型。撰寫函數時十分需要。

然後，我們可以註冊音源：

```rust
use unm_engine::executor::Executor;
use unm_engine_bilibili::{BilibiliEngine, ENGINE_ID as BILIBILI_ENGINE_ID};

let mut executor = Executor::new();
executor.register(BILIBILI_ENGINE_ID, BilibiliEngine::new());

// 您也可以直接使用官方預設的引擎集，免去手動註冊的麻煩。
// 首先得引入 `unm_api_utils`，然後就可以：

use unm_api_utils::executor::build_full_executor;
let executor = build_full_executor();
```

接著就可以直接使用 executor 提供的方法搜尋及取回結果了：

```rust
use unm_types::{Song, Artist, Context};

let context = Context::default();

let search_result = executor.search(&[BILIBILI_ENGINE_ID], Song {
  id: "".to_string(),
  name: "TT",
  artists: vec![
    Artist {
      id: "".to_string(),
      name: "Twice",
    },
  ],
}, &context).await?;

let result = executor.retrieve(&search_result, &context).await?;
```

### TypeScript (JS) 函式庫

請參考 [napi 的 README.md](https://github.com/UnblockNeteaseMusic/server-rust/blob/main/napi/README.md)。

### RESTful API

請參考 [UNM REST API 的 README.md](https://github.com/UnblockNeteaseMusic/server-rust/blob/main/rest-api/README.md)

## 設定

### 支援的所有引擎

N-API 和 RESTful API 支援的引擎（以下簡稱「預設引擎集」）與我們上架到 <https://crates.io> 的引擎略有差異。

| 名稱             | 引擎 ID    | 注意事項                                                        | 預設引擎集 |
| ---------------- | ---------- | --------------------------------------------------------------- | ---------- |
| Bilbili Music    | `bilibili` |                                                                 | ✅         |
| 酷狗音乐         | `kugou`    |                                                                 | ✅         |
| 酷我音乐         | `kuwo`     | 目前僅支援 320kbps MP3                                          | ✅         |
| 咪咕音乐         | `migu`     |                                                                 |            |
| JOOX             | `joox`     | 需要設定 `joox:cookie`，見引擎文件。                            | ✅         |
| YtDl             | `ytdl`     | 預設使用的 `youtube-dl` 後端是 `yt-dlp`，可設定 `ytdl:exe` 調整 | ✅         |
| 第三方網易雲 API | `pyncm`    |                                                                 | ✅         |
| QQ音乐          | `qq`       | 需要設定 `qq:cookie`，見引擎文件。                              | ✅         |

- `migu` 的 API 壞掉了。等到有更好的 API 會再更新。

#### 引擎文件

- JOOX 引擎：<https://docs.rs/unm_engine_joox>
- YtDl 引擎：<https://docs.rs/unm_engine_ytdl>
- QQ 引擎：<https://docs.rs/unm_engine_qq>

### 設定全域通用設定（`Context`）

全域通用設定（`Context`）包含以下這些設定：

- `proxy_uri`：要在引擎使用的 Proxy 伺服器。選填。
- `enable_flac`：是否抓取 FLAC 音訊？預設值是 `false`。
- `search_mode`：搜尋模式
  - 可以設定是以「速度為主」（FastFirst）或者是以「順序為主」（OrderFirst）進行搜尋
  - 範例請見 <https://docs.rs/unm_types/0.2.0-pre.4/unm_types/enum.SearchMode.html>
- `config`：各引擎設定，見下〈設定引擎特定設定（`Config`）〉

假如您使用 Rust 版，您可以使用 [`ContextBuilder`](https://docs.rs/unm_types/latest/unm_types/struct.ContextBuilder.html) 建構 Context：

```rs
use unm_types::{ContextBuilder, SearchMode};

let context = ContextBuilder::default()
  .proxy_uri("https://www.google.com")
  .search_mode(SearchMode::OrderFirst)
  .build();
```

如果是使用 JavaScript 版，您可以根據 [UNM 的類型定義（VS Code 會提供補全建議）](https://github.com/UnblockNeteaseMusic/server-rust/blob/main/napi/index.d.ts) 建構 `Object` 即可：

```js
const UNM = require("@unblockneteasemusic/rust-napi");

// TS 的語法是 `const context: UNM.Context = {}`
/** @type {UNM.Context} */
const context = {
  proxyUri: "https://www.google.com",
  searchMode: UNM.SearchMode.OrderFirst,
};
```

#### 設定引擎特定設定（`Config`）

「引擎特定設定」是每個引擎針對自己的需要，從 `Config` 取得需要的設定。
設定方法請見 [`engines/README.md`](https://github.com/UnblockNeteaseMusic/server-rust/blob/main/engines/README.md)

## 貢獻

### 檢查程式碼的相關命令

```bash
cargo check  # 檢查程式碼是否合法 (valid)
cargo test   # 執行本 codebase 的所有 Tests
cargo clippy # Rust linter
```

UNM (Rust) 的 CI 也會在程式碼 push 後自動執行上述命令，
進行程式碼測試與檢查。

### 貢獻引擎後的建議事項

引擎的 crate 名稱格式是：`unm_engine_[引擎名稱]`，放置在 `/engines/[引擎名稱]` 目錄。

建議仿照其它引擎，在 `engine-demo` 和 `napi` 註冊自己的音源。
註冊音源有 macro 協助，語法目前是這樣的：

```rust
push_engine!([引擎名稱]: [引擎實體]);
```

範例如下：

```rust
push_engine!(bilibili: BilibiliEngine);
```

## 授權條款

This project is licensed under [LGPL-3.0-only](https://spdx.org/licenses/LGPL-3.0-only.html).

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2FUnblockNeteaseMusic%2Fserver-rust.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2FUnblockNeteaseMusic%2Fserver-rust?ref=badge_large)
