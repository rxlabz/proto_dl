A server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).

This sample code handles HTTP GET requests to `/<path|.*>` and `/event/<eventId>`

# Running the sample

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart
Server listening on port 8080
```
Open your browser : 

- http://localhost:8080

- http://localhost:8080/event/546
- 
- http://localhost:8080/event/546?memberId=321

