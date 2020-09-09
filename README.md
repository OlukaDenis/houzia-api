# Project: Houzia API

Houzia API a RESTful API that allows authenticated user to add and manipulate houses available for rent. This is a final capstone project as part of Microverse's Technical curriculum. The project details can be found [here](https://www.notion.so/Final-Capstone-Project-Find-Your-House-9a424802e7dc48eb8ef40e2ac09397d1).
The goal of the project is to build an API that is consumed by a [React App](http://houzia-frontend.herokuapp.com/).

## Built With

- Ruby v2.7.0
- Ruby on Rails v6.0.3.2

## Technologies
- Ruby
- Ruby On Rails

## Live Demo
[Live link](http://houzia-api.herokuapp.com/)


## Prerequisites

- Ruby: 2.7.0
- Rails: 6.0.2.1

## Setup

Use the [git](https://git-scm.com/downloads) to clone the project to your local machine.
```sh
$ git clone https://github.com/OlukaDenis/houzia-api.git
```

Navigate to the extracted folder
```sh
$ cd houzia-api
```

Install the gems
```sh
$ bundle install
```

Create the database
```sh
$ rails db:create
```

Run the migrations
```sh
$ rails db:migrate
```


### Usage

#### Admin User

Create admin user with:

```sh
$ rails db:seed
```

Start server with:

```sh
$ rails s -p 4000
```

Open `http://localhost:4000/` in your browser.

Login as admin user:

> **email**: admin@gmail.com

> **password**: 15qwerty

Or create a normal user without admin rights using `/signup` endpoint.

### Run tests

```
    $ bundle exec rpsec --format documentation
```

# API Documentation

## Signup User
  Returns an authentication token to authorize the subsequent resquests.

* **URL:**/signup

* **Method:** `POST`

* **URL Params:** None
 
* **Body Params Required:**
   `username=[string]` `email=[string]` `image=[string` `password=[string]` `password_confirmation=[string]`

* **Success Response:**
    * **Code:** 201
    * **Status:** Created
    * **Response body:** 
    ```sh
        { 
            message: "Account created successfully",
            auth_token: "JWT_GENERATED_TOKEN" 
        }
    ```

* **Error Response:**
    * **Code:** 422
    * **Status:** Unprocessable Entity
    * **Response body:** 
    ```sh
        {
            message: "Missing any of the required fields" 
        }
    ```

* **Sample Call:**
  ```javascript
	axios.post(`${BASE_URL}/signup`, {
	    username: 'John Doe',
	    email: 'johndoe@mail.com',
        image: 'https://img.com/image.png',
	    password: '123456',
	    password_confirmation: '123456',
	  })
    .then(response => console.log(response))
    .catch(error => console.log(error))
  ```

## Login User
  Returns an authentication token to authorize an existing user.

* **URL** /auth/login
* **Method:** `POST`

* **URL Params** None
 
* **Body Params Required:** `email=[string]` `password=[string]`

* **Success Response:**
    * **Code:** 200
    * **Status:** OK
    * **Response body:**
    ```sh
        {
            auth_token: "JWT_GENERATED_TOKEN" 
        }
    ```

* **Error Response:**
  * **Code:** 401
  * **Status:** Unauthorized
    **Response body:** 
    ```sh
        { 
            message: "Invalid Credentials" 
        }
    ```

* **Sample Call:**
  ```javascript
	axios.post(`${BASE_URL}/auth/login`,
	  {
	    email: "johndoe@mail.com",
	    password: "123456",
	  }
    )
    .then(response => console.log(response))
    .catch(error => console.log(error))
  ```


## Get all houses
  Returns a list of all available houses.

* **URL:**/houses

* **Method:** `GET`

* **URL Params:** None

* **Authorization:** Bearer Token
 
* **Body Params Required:** None

* **Success Response:**
    * **Code:** 200
    * **Status:** OK
    * **Response body:** 
    ```sh
        [
            {
                id: 1,
                name: "House for rent",
                description: "Description info",
                image: "image.png",
                price: 50000,
                user_id: 1,
                created_at: "2020-09-03T16:30:41.855Z",
                updated_at: "2020-09-03T16:30:41.855Z"
            }
        ]
    ```

* **Error Response:**
    * **Code:** 422
    * **Status:** Unprocessable Entity
    * **Response body:** 
    ```sh
        {
            message: "Missing token" 
        }
    ```

* **Sample Call:**
  ```javascript
	axios.get(`${BASE_URL}/houses`, 
        {
           headers: {
                Authorization: "Bearer Token",
            },
        })
    .then(response => console.log(response))
    .catch(error => console.log(error))
  ```

## Admin Endpoints

### Add new house
Returns a json data of the created house

* **URL:**/houses

* **Method:** `POST`

* **URL Params:** None

* **Authorization:** Bearer Token
 
* **Body Params Required:** `name=[string]` `description=[text]` `image=[string]` `price=[integer]`

* **Success Response:**
    * **Code:** 201
    * **Status:** Created
    * **Response body:** 
    ```sh
        {
            id: 1,
            name: "House for rent",
            description: "Description info",
            image: "image.png",
            price: 50000,
            user_id: 1,
            created_at: "2020-09-03T16:30:41.855Z",
            updated_at: "2020-09-03T16:30:41.855Z"
        }
    ```

* **Error Response:**
    * **Code:** 422
    * **Status:** Unprocessable Entity
    * **Response body:** 
    ```sh
        {
            message: "Missing token" 
        }
    ```

* **Sample Call:**
  ```javascript
    axios.post(`${BASE_URL}/houses`,
        {
            name: "House for rent",
            description: "Description info",
            image: "image.png",
            price: 50000
        },
        {
           headers: {
                Authorization: "Bearer Token",
            },
        })
    .then(response => console.log(response))
    .catch(error => console.log(error))
  ```


## Author

👤 **Denis Oluka**

[Github](https://github.com/OlukaDenis) | [Twitter](https://twitter.com/dennycodev) | [LinkedIn](https://linkedin.com/in/denis-oluka-)


## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is licensed under MIT license - see [LICENSE](/LICENSE) for more details.

