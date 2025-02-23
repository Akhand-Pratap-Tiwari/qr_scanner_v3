# QR Scanner V3

### BackStory: 
So, there was an emergency request from a club to make a qr scanner app that can scan qr and then do R/W operations on the DB. And not on Firebase but on MongoDB as well. Deadline was in 3 hrs. This is the v3 of the same app with much more polished UI and code organization. Although the organization is not standarad as it has been conformed to the request of the user. 

Operations:
- Scan QR code and extract id from it.
- On the basis of id check whether the person is registered on DB or not.
- If registered and scanned then generate duplicate alert.
- If registered but not scanned then show the registration number fetched from the DB.
- If not registered then show not registered warning.

It can be used by multiple persons in parallel for scanning distinct tickets.

### [Demo Video Here](https://drive.google.com/file/d/1gnie6OlPAmqUTedwsQ36_4Wtypj09GQ8/view?usp=drive_link).

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
