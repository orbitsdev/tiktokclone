class Video {



String username;
String uid;
String id;
List likes; 
int commentCount;
int shareCount;
String songname;
String caption;
String videoUrl;
String thumbnail;
String profilePhoto;

  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songname,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePhoto,
  });


  Map<String, dynamic> toJson()=> {
    'username':username,
    'uid':    uid,
    'id':    id,
    'likes':    likes,
    'commentCount':    commentCount,
    'shareCount':    shareCount,
    'songname':    songname,
    'caption':    caption,
    'videoUrl':    videoUrl,
    'thumbnail':    thumbnail,
    'profilePhoto':    profilePhoto,
  };


  factory Video.fromJson(Map<String, dynamic> json) => Video(
    username: json['username'],
    uid: json['uid'],
    id: json['id'], 
    likes: json['likes'], 
    commentCount: json['commentCount'],
    shareCount: json['shareCount'],
    songname: json['songname'],
    caption: json['caption'],
    videoUrl: json['videoUrl'], 
    thumbnail: json['thumbnail'],
    profilePhoto: json['profilePhoto'],
    );
}
