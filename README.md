# LoginRadius Elixir SDK


![Home Image](http://docs.lrcontent.com/resources/github/banner-1544x500.png)

## Introduction ##

LoginRadius Customer Registration wrapper provides access to LoginRadius Identity Management Platform API.

LoginRadius is an Identity Management Platform that simplifies user registration while securing data. LoginRadius Platform simplifies and secures your user registration process, increases conversion with Social Login that combines 30 major social platforms, and offers a full solution with Traditional Customer Registration. You can gather a wealth of user profile data from Social Login or Traditional Customer Registration. 

LoginRadius centralizes it all in one place, making it easy to manage and access. Easily integrate LoginRadius with all of your third-party applications, like MailChimp, Google Analytics, Livefyre and many more, making it easy to utilize the data you are capturing.

LoginRadius helps businesses boost user engagement on their web/mobile platform, manage online identities, utilize social media for marketing, capture accurate consumer data, and get unique social insight into their customer base.

Please visit [here](http://www.loginradius.com/) for more information.


## Contents ##

* [Demo](https://github.com/LoginRadius/elixir-sdk) - A simple demo application demonstrating the usage of this SDK.


## Documentation

* [Configuration](https://docs.loginradius.com/api/v2/deployment/sdk-libraries/elixir-library) - Everything you need to begin using the LoginRadius SDK.



# LoginRadius

Elixir wrapper for the LoginRadius API.

## Installation
Install the SDK by adding LoginRadius to your `mix.exs` dependencies:

```
def deps do
  [{:loginradius, "~> 1.0"}]
end
```

Then, run `$ mix deps.get`. A copy of the SDK can also be found on our [Github](https://github.com/LoginRadius/elixir-sdk).


## Usage

Before you can use any of the functions available in the library, some settings need to be configured first. To do this, add the following to your list of configurations in your `config.exs` file:

```
config :loginradius,
  appname: "<Your LoginRadius AppName>",
  apikey: "<Your ApiKey>",
  apisecret: "<Your ApiSecret>"
```

The API key and secret can be obtained from the LoginRadius dashboard. Details on retrieving your key and secret can be found [here](https://docs.loginradius.com/api/v2/dashboard/get-api-key-and-secret#retrieve-your-api-key-and-secret).

All API wrappers contained in the SDK will return either an ok or error tuple in the following format:

```
{<:ok | :error>, {<Status Code>, <Response Body>, <HTTPoison Response>}
(4XX-5XX responses will return :error)
```

