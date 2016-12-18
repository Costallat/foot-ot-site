package util

import "github.com/BurntSushi/toml"

// CookieConfig struct used for the cookies
// configuration options
type CookieConfig struct {
	Name   string
	MaxAge int
}

// CacheConfig struct used for the cache
// configuration options
type CacheConfig struct {
	Default int
	Purge   int
}

// Configuration struct used for the main Castro
// config file TOML file
type Configuration struct {
	Mode     string
	Port     int
	URL      string
	Datapack string
	Cookies  CookieConfig
	Cache    CacheConfig
	Custom   map[string]interface{}
}

// Config holds the main configuration file
var Config *Configuration

func init() {
	Config = &Configuration{}
}

// LoadConfig loads the configuration file to
// the given interface pointer
func LoadConfig(data string, dest interface{}) error {
	if _, err := toml.Decode(data, dest); err != nil {
		return err
	}
	return nil
}

// IsDev checks if castro is running on
// development mode
func (c Configuration) IsDev() bool {
	return c.Mode == "dev"
}