# Serialization

Cloudstate functions serve gRPC interfaces, and naturally the input messages and output messages are protobuf messages that get serialized to the protobuf wire format. However, in addition to these messages, there are a number of places where Cloudstate needs to serialize other objects, for persistence and replication.

See @extref:[here](cloudstate:user/lang/java/serialization.html) for more details

