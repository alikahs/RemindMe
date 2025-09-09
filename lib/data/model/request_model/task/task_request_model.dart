import 'dart:convert';

class TaskModel {
  String idTask;
  String? judulTask;
  DateTime? startedAt;
  DateTime? endedAt;
  String? deskripsiTask;
  List<SubTask>? subTask;
  String? idUser;
  List<Member>? member;

  TaskModel({
    required this.idTask,
    this.judulTask,
    this.startedAt,
    this.endedAt,
    this.deskripsiTask,
    this.subTask,
    this.idUser,
    this.member,
  });

  factory TaskModel.fromJson(String str) => TaskModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
    idTask: json["id_task"], // ⬅️ ambil dari key id_task
    judulTask: json["judul_task"],
    startedAt: json["started_at"] == null
        ? null
        : DateTime.parse(json["started_at"]),
    endedAt: json["ended_at"] == null ? null : DateTime.parse(json["ended_at"]),
    deskripsiTask: json["deskripsi_task"],
    subTask: json["sub_task"] == null
        ? []
        : List<SubTask>.from(json["sub_task"].map((x) => SubTask.fromMap(x))),
    idUser: json["id_user"],
    member: json["member"] == null
        ? []
        : List<Member>.from(json["member"].map((x) => Member.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id_task": idTask,
    "judul_task": judulTask,
    "started_at": startedAt?.toIso8601String(),
    "ended_at": endedAt?.toIso8601String(),
    "deskripsi_task": deskripsiTask,
    "sub_task": subTask == null
        ? []
        : List<dynamic>.from(subTask!.map((x) => x.toMap())),
    "id_user": idUser,
    "member": member == null
        ? []
        : List<dynamic>.from(member!.map((x) => x.toMap())),
  };

  // optional: copyWith biar enak edit
  TaskModel copyWith({
    String? idTask,
    String? judulTask,
    DateTime? startedAt,
    DateTime? endedAt,
    String? deskripsiTask,
    List<SubTask>? subTask,
    String? idUser,
    List<Member>? member,
  }) {
    return TaskModel(
      idTask: idTask ?? this.idTask,
      judulTask: judulTask ?? this.judulTask,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      deskripsiTask: deskripsiTask ?? this.deskripsiTask,
      subTask: subTask ?? this.subTask,
      idUser: idUser ?? this.idUser,
      member: member ?? this.member,
    );
  }
}

class Member {
  String? idMember;
  String? emailMember;

  Member({this.idMember, this.emailMember});

  factory Member.fromJson(String str) => Member.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Member.fromMap(Map<String, dynamic> json) =>
      Member(idMember: json["id_member"], emailMember: json["email_member"]);

  Map<String, dynamic> toMap() => {
    "id_member": idMember,
    "email_member": emailMember,
  };
}

class SubTask {
  String? isiSubTask;
  bool? isCompleted;
  DateTime? startedAt;
  DateTime? endedAt;

  SubTask({this.isiSubTask, this.isCompleted, this.startedAt, this.endedAt});

  factory SubTask.fromJson(String str) => SubTask.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubTask.fromMap(Map<String, dynamic> json) => SubTask(
    isiSubTask: json["isi_sub_task"],
    isCompleted: json["is_completed"],
    startedAt: json["started_at"] == null
        ? null
        : DateTime.parse(json["started_at"]),
    endedAt: json["ended_at"] == null ? null : DateTime.parse(json["ended_at"]),
  );

  Map<String, dynamic> toMap() => {
    "isi_sub_task": isiSubTask,
    "is_completed": isCompleted,
    "started_at": startedAt?.toIso8601String(),
    "ended_at": endedAt?.toIso8601String(),
  };

  SubTask copyWith({
    String? isiSubTask,
    bool? isCompleted,
    DateTime? startedAt,
    DateTime? endedAt,
  }) {
    return SubTask(
      isiSubTask: isiSubTask ?? this.isiSubTask,
      isCompleted: isCompleted ?? this.isCompleted,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }
}
