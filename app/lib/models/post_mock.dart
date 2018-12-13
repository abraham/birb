// TODO(abraham): Move to test directory

import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

import 'post.dart';

const List<String> imageIds = <String>[
  'AEVAMhago-s',
  'ANOUzKhSVfg',
  '8Vp88__2BhY',
  'YdeNI9QXCoc',
  'DS0ZSq96IeU',
  '3YnT86K0CdE',
  'CS5vT_Kin3E',
  'RLLR0oRz16Y',
  'V-zcDORGb3s',
  'DPXytK8Z59Y',
  'NSSsyfAQW2g',
  'Lej_oqHljbk',
  'RLR9AfOd5hw',
  'mGNvmvPJyXc',
  'KKF-Qq1Foys'
];

Map<String, dynamic> mockPostData({int index = 0}) {
  const Faker faker = Faker();
  final String imageId = faker.randomGenerator.element(imageIds);
  final String createdAt =
      DateTime.now().subtract(Duration(days: index)).toIso8601String();

  return <String, dynamic>{
    'id': Uuid().v4(),
    'imageUrl': 'https://source.unsplash.com/$imageId',
    'createdAt': createdAt,
    'text': faker.conference.name(),
    'username': faker.person.name()
  };
}

Post mockPost({int index = 0}) {
  return Post.fromMap(mockPostData(index: index));
}

Stream<List<Post>> mockPosts({int count}) {
  final List<List<Post>> mockSnapshot = <List<Post>>[
    List<Post>.generate(count, (int index) => mockPost(index: index))
  ];
  return Stream<List<Post>>.fromIterable(mockSnapshot);
}
