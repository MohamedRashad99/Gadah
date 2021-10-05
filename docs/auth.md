# Auth

- this app support two type of roles for user authentication
  - Driver
  - User
- user account have three status
  - active
  - awaiting
  - refused
  - banned

# Modules

## AuthCubit

checks for current user and emits the state where is a listener in the `main.dart` which will navigates to the right page based on the auth state

## Sign In

takes the user phone no and calls the api to send SMS to the user phone number

## Confirm Code

- takes the user Phone no from authCubit
- the user enter te sent OTP message
- tries to SignIn with phone no and cubit
- in case of failure it shows the error message
- in case of success it send an event to AuthCubit to check The auth Status

## SignUp As Client

- tries to signUp as Client
- in case of failure it shows the error message
- in case of success it send an event to AuthCubit to check The auth Status

## SignUp As Driver

- tries to signUp as Client
- in case of failure it shows the error message
- in case of success it send an event to AuthCubit to check The auth Status

For More info on the authentication features get back to the API docs
