// Copyright (c) 2021, the gRPC project authors. Please see the AUTHORS file
// for details. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
@TestOn('!browser')

import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:test/test.dart';

const host = 'example.com';
const grpcPort = 9090;
const grpcWebPort = 8080;

void main() {
  test('Channel on non-web uses gRPC ClientChannel with correct params', () {
    final channel = GrpcOrGrpcWebClientChannel(
      host: host,
      grpcPort: grpcPort,
      grpcWebPort: grpcWebPort,
      secure: false,
    );
    expect(channel is ClientChannel, isTrue);
    expect(channel.host, equals(host));
    expect(channel.port, equals(grpcPort));
    expect(channel.options.credentials.isSecure, isFalse);
  });

  test('Constructor grpc on non-web passes params correctly', () {
    final options = ChannelOptions(credentials: ChannelCredentials.insecure());
    final channel = GrpcOrGrpcWebClientChannel.grpc(
      host,
      port: grpcPort,
      options: options,
    );
    expect(channel.host, equals(host));
    expect(channel.port, equals(grpcPort));
    expect(channel.options, same(options));
  });
}
