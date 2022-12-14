# iOSNetworking
Sample app that demonstrates API connectivity using URLSession and protocol oriented programming.

The sample app connects to https://learnrest.dev.

The user interface is not intended to be perfect. For example, a user cannot zoom in on a selected image in the My Images tab. The purpose of the app is to demonstrate how to connect to a third-party API in iOS using URLSession.

The API uses a bearer token and this token is embedded in the project. Once (hardcoded) in StatusCodesViewModel and another in APIConstants.

The token used within this project will have already expired.

## Demo

https://user-images.githubusercontent.com/1415689/184044740-970564bb-f250-4dba-8960-1a3f7d5493f3.mov


## Status Codes Tab
User the segmented control and the picker to fetch a status code and see if it has an associated message.
- Demonstrates how to use URLSession.dataTask{ ... }.resume()
- Demonstrates the entry point to make calls to API endpoints, but it isn't best practice.
- Demonstrates pagination through infinite scrolling.

## UserProfile Toolbar Item on all TabViews
Displays basic user information.
- Demonstrates async/await version of URLSesstion.data( ... ) in an isolated context.
- Not yet modularised.

## Car Brands Tab
Search the API for a list of car brands using a search field. Displays the result in a list.
- Modularises API requests using Requestable and APIViewModel.
- Encapsulates the request into a base class called APIViewModel.
- Abstracts the request to conform to a Requestable protocol.
- Prepares a base request with hidden boiler plate code.
- Includes query parameters as part of the request.

## MyBooks Tab
Enter a book to add to a personal library. The list of saved books is displayed in a list.
- Demonstrates the full CRUD cycle of book objects.
- Demonstrates a POST and PUT call.
- Groups all the requests into BookRequests.
- Includes the ability to delete a book.

## MyImages Tab
Allows the user to upload a photo from their photo library. (Photos must be less than 150kb)
- Demonstrates how to upload a photo using multipart/formdata.
- Encapsulates the formatting of the form data using MultipartFormdata struct with FieldType enum.
