# API Documentation

## User

### POST /api/v1/user/sign_up

Require fields: __email__, __username__, __first_name__, __last_name__, __password__

Response:
* If successful:
{ "status": "ok" }
* If failure:
{ "error": __some_arbitrary_message__ }

### POST /api/v1/user/sign_in

Require fields: __email__, __password__

Response: one of following
* { "error": "Email not found" }
* { "error": "Incorrect password" }
* { "status": "ok", "token": __your_authentication_token__ }

This authentication token will be used to identify user.
Attach it in the header of request, under the key 'Token'

### PUT /api/v1/user/edit

Require header: __Token__

Optional fields: __first_name__, __last_name__, __username__

Response: one of following
* If successful
Return the information of user as GET /api/v1/user
* If failure
{ "error": __some_arbitrary_mesage__ }

### DELETE /api/v1/user/sign_out

Require header: __Token__

Response:
{ "status": "ok" }

### GET /api/v1/user

Response:
    {
        "email": "useremail@example.com",
        "username": "exampleuser",
        "full_name": "example full name"
    }

### Note on Token

For API calls that requires Token, if the token is not found in header, the following message is returned:
* { "error": "401 Token not found" }

If the token is invalid, following message is returned:
* { "error": "401 Token invalid" }
