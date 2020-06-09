import 'dart:mirrors';
import 'package:cloudstate/src/generated/protocol/cloudstate/function.pb.dart';
import 'package:cloudstate/src/services.dart';
import 'package:protobuf/protobuf.dart';

import '../cloudstate.dart';

class StatelessEntityService implements CloudstateService {
  static const String entity_type =
      'cloudstate.function.StatelessFunction';

  String service;
  Type userEntity;
  DeclarationMirror _mirror;

  StatelessEntityService(String service, Type userEntity){
    this.service = service;
    this.userEntity = userEntity;
    _mirror = reflectClass(userEntity);

    var statelessEntityAnnotationMirror = reflectClass(StatelessEntity);
    final statelessEntityAnnotationInstanceMirror = _mirror.metadata.firstWhere(
            (d) => d.type == statelessEntityAnnotationMirror,
        orElse: () => null);

    if (statelessEntityAnnotationInstanceMirror == null) {
      throw Exception('Entity ${_mirror.simpleName} does not contain the annotation StatelessEntity');
    }
  }

  @override
  Type entity() {
    return userEntity;
  }

  @override
  String entityType() {
    return entity_type;
  }

  @override
  String persistenceId() {
    return null;
  }

  @override
  String serviceName() {
    return service;
  }
}

class StatelessEntityHandlerFactory {
  static final _logger = Logger(
    filter: CloudstateLogFilter(),
    printer: LogfmtPrinter(),
    output: SimpleConsoleOutput(),
  );

  static final Map<String, StatelessEntityHandlerImpl> _services = {};

  static StatelessEntityHandler getOrCreate(String serviceName, StatelessEntityService service) {
    if (_services.containsKey(serviceName)) {
      _logger.d('StatelessEntityHandler for service[$serviceName] is cached');
      return _services[serviceName];
    }
    _logger.d('Creating new StatelessEntityHandler for service: $serviceName');
    var handler = StatelessEntityHandlerImpl(serviceName, service);
    _services[serviceName] = handler;
    return handler;
  }
}

class StatelessEntityHandler {
  Future<FunctionReply> runUnary(FunctionCommand request) {}
  FunctionReply runStreamed(FunctionCommand stream) {}
  FunctionReply  runStreamedIn(Stream<Object> events) {}

}

class StatelessEntityHandlerImpl implements StatelessEntityHandler {
  final String serviceName;
  final StatelessEntityService service;

  StatelessEntityHandlerImpl(this.serviceName, this.service);

  @override
  Future<FunctionReply> runUnary(FunctionCommand request) {
    // TODO: implement runUnary
    throw UnimplementedError();
  }

  @override
  FunctionReply runStreamed(FunctionCommand stream) {
    // TODO: implement runStreamed
    return FunctionReply.getDefault();
  }

  @override
  FunctionReply runStreamedIn(Stream<Object> events) {
    // TODO: implement runStreamedIn
    throw UnimplementedError();
  }

}

class StatelessEntity {}

class UnaryCommandHandler {
  final String name;
  const UnaryCommandHandler(
      [
        this.name = ''
      ]);
}

class StreamInCommandHandler {
  final String name;
  const StreamInCommandHandler(
      [
        this.name = ''
      ]);
}

class StreamOutCommandHandler {
  final String name;
  const StreamOutCommandHandler(
      [
        this.name = ''
      ]);
}

class StreamedCommandHandler {
  final String name;
  const StreamedCommandHandler(
      [
        this.name = ''
      ]);
}
