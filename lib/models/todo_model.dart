import 'package:equatable/equatable.dart';
class Todo extends Equatable{
  final String id;
  final String task;
  final String description;
  bool? isCompleted;
  bool? isCancelled;

  Todo({required this.id,required this.description,this.isCancelled,this.isCompleted,required this.task}){
    isCancelled = isCancelled ?? false;
    isCompleted = isCompleted ?? false;
  }

  Todo copyWith({
     String? id,
     String? task,
     String? description,
    bool? isCompleted,
    bool? isCancelled,
}){
    return Todo(id: id ?? this.id,
        description: description ?? this.description,
        task: task ?? this.task,
        isCancelled: isCancelled ?? this.isCancelled,
        isCompleted: isCompleted ?? this.isCompleted
    );
  }

  @override
  List<Object?> get props => [
    id,
    task,
    description,
    isCompleted,
    isCancelled
  ];

  static List<Todo> todos = [
    Todo(id: '1', description: 'This is a test todo', task: 'Sample todo 1'),
    Todo(id: '2', description: 'This is a test todo', task: 'Sample todo 2'),
  ];
}