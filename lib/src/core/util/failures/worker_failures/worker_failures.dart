abstract class WorkerFailure {}

class WorkerInsufficientPermissions extends WorkerFailure {}

class WorkerGeneralFailure extends WorkerFailure {}

class WorkerCreateInvalidArgument extends WorkerFailure {}
