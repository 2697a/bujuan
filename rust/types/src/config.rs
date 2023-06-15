use std::borrow::Cow;
use std::collections::HashMap;
use std::ops::Deref;

use serde::{Deserialize, Serialize};
use thiserror::Error;

pub type ConfigKey = Cow<'static, str>;
pub type ConfigValue = String;

/// The config manager for UNM Engines.
///
/// It is a wrapper of [`HashMap`], including some useful methods.
#[derive(Clone, Debug, Default, Serialize, Deserialize)]
pub struct ConfigManager(HashMap<ConfigKey, ConfigValue>);

/// The [`ConfigManager`] builder.
///
/// You can build [`ConfigManager`] easily with this helper.
#[derive(Clone, Default)]
pub struct ConfigManagerBuilder(HashMap<ConfigKey, ConfigValue>);

impl Deref for ConfigManager {
    type Target = HashMap<ConfigKey, ConfigValue>;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl ConfigManager {
    pub fn new(hm: HashMap<ConfigKey, ConfigValue>) -> ConfigManager {
        ConfigManager(hm)
    }

    pub fn get_or_default<'a>(&'a self, k: ConfigKey, default: &'a str) -> &'a str {
        if let Some(value) = self.get(&k) {
            value.as_str()
        } else {
            default
        }
    }

    pub fn get_or_err(
        &self,
        k: ConfigKey,
        purpose: Cow<'static, str>,
    ) -> ConfigManagerResult<&str> {
        if let Some(value) = self.get(&k) {
            Ok(value.as_str())
        } else {
            Err(ConfigManagerError::NoSuchKey { key: k, purpose })
        }
    }

    pub fn get_deref(&self, k: ConfigKey) -> Option<&str> {
        self.get(&k).map(AsRef::as_ref)
    }
}

impl ConfigManagerBuilder {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn set<K: Into<ConfigKey>, V: Into<ConfigValue>>(&mut self, key: K, value: V) -> &mut Self {
        self.0.insert(key.into(), value.into());
        self
    }

    pub fn build(&mut self) -> ConfigManager {
        ConfigManager::new(self.0.clone())
    }
}

#[derive(Debug, Error)]
pub enum ConfigManagerError {
    #[error("{key} should be defined for {purpose}")]
    NoSuchKey {
        key: ConfigKey,
        purpose: Cow<'static, str>,
    },
}

pub type ConfigManagerResult<T> = Result<T, ConfigManagerError>;

#[cfg(test)]
mod tests {
    use std::borrow::Cow;
    use std::collections::HashMap;

    use super::ConfigManagerBuilder;

    #[test]
    fn test_config_manager_build_without_set() {
        let cm = ConfigManagerBuilder::new().build();

        assert_eq!(cm.0, HashMap::new());
    }

    #[test]
    fn test_config_manager_build_with_key_borrowed() {
        let cm = ConfigManagerBuilder::new()
            .set("example", "Cow::Borrowed")
            .build();

        assert_eq!(cm.0, {
            let mut hm = HashMap::new();

            hm.insert(Cow::Borrowed("example"), "Cow::Borrowed".to_string());

            hm
        });
    }

    #[test]
    fn test_config_manager_build_with_key_owned() {
        let cm = ConfigManagerBuilder::new()
            .set("example".to_string(), "Cow::Borrowed")
            .build();

        assert_eq!(cm.0, {
            let mut hm = HashMap::new();

            hm.insert(
                Cow::Owned("example".to_string()),
                "Cow::Borrowed".to_string(),
            );

            hm
        });
    }
}
