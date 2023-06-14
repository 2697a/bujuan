//! UnblockNeteaseMusic (Rust)'s API Utilities.
//!
//! The API here can help you build APIs around UNM easily.
//! For example, you can build executors with all supported engines
//! quickly with the utilities here.
//!
//! # Example
//!
//! ```
//! use unm_api_utils::executor::build_full_executor;
//!
//! let executor = build_full_executor();
//! println!("{:?}", executor.list());
//! ```

pub mod executor;
