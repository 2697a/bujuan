# UNM Engines

本資料夾放置 UNM 目前官方支援的音源。

## 設定

「設定」請傳入 Context 中 `config` 欄位，以下是 Rust 設定範例：

```rs
use unm_types::{ContextBuilder, config::ConfigManagerBuilder};

let config = ConfigManagerBuilder::new()
    .set("joox:cookie", "wmid=...; session_key=...")
    .build();

let context = ContextBuilder::default()
    .config(config)
    .build();
```

JavaScript 的話只需要建構 object，讓 N-API 處理即可：

```js
/** @type {Record<string, string>} */
const config = {
    "joox:cookie": "wmid=...; session_key=...",
};
```

### 可設定項目

> **設定請以各 engines 的說明文件為主**。本文件是這些說明文件統整出可以設定的項目。

| 設定鍵        | 設定值範例                                          | 說明                           |
| ------------- | --------------------------------------------------- | ------------------------------ |
| `joox:cookie` | `wmid=<your_wmid>; session_key=<your_session_key>;` | 請參見〈JOOX Cookie 設定說明〉 |
| `qq:cookie`   | `uin=<your_uin>; qm_keyst=<your_qm_keyst>;`         | 請參見〈QQ Cookie 設定說明〉   |
| `ytdl:exe`    | `youtube-dl`                                        | 請參見〈`ytdl:exe` 設定說明〉  |

### JOOX Cookie 設定說明

`joox:cookie` 是登入 JOOX 平台後，透過在 F12 → Console 輸入 `document.cookie` 取得的 Cookie。

### QQ Cookie 設定說明

`qq:cookie` 是登入 QQ 音樂後，透過在 F12 → Console 輸入 `document.cookie` 取得的 Cookie。
可能需要啟用「QQ音乐豪华绿钻」方案，才能享受到比較好的使用體驗。

> **註**：如果找不到 `qm_keyst` 這個 cookie，請試試看進入瀏覽器的 **無痕模式**，然後重新登入 QQ 音樂。

### `ytdl:exe` 設定說明

`ytdl:exe` 是要使用的 youtube-dl 執行檔。預設值是 `yt-dlp`

#### 設定 `ytdl:exe` 的通常方式

雖然 UNM 通常會透過您設定的 PATH 路徑，自動取出指定執行檔的路徑。
但假如您的環境缺少 PATH 路徑，或想要指定為其他執行檔，您可以遵循以下步驟：

> 以下皆以 `yt-dlp` 為例。

1. 首先，用 `pip` 或你熟悉的方式安裝 `yt-dlp`
2. 輸入 `yt-dlp --version` 確認有沒有正確安裝
3. 輸入 `which yt-dlp` 抓出 `yt-dlp` 所在的路徑
4. 最後將這個位置貼到 UNM 的 `context.config` 當中即可。
