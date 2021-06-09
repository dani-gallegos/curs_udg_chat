# chat_client

flutter create -t app chat_client

## Afegir dependències

  protobuf: ^2.0.0
  grpc: ^3.0.0
  bubble: ^1.2.1

## Compilar els protos GRPC per al client:

Cal crear el directori: lib/generated/grpc/ i des d'aquest...

`protoc --dart_out=grpc:lib/generated/grpc --proto_path ../Chat.GRPC/Protos/  ../Chat.GRPC/Protos/*.proto`

També cal compilar les dependències proto: 

`protoc --dart_out=grpc:lib/generated/grpc/google/protobuf --proto_path ~/Dev/protoc/include/google/protobuf/ ~/Dev/protoc/include/google/protobuf/timestamp.proto`
