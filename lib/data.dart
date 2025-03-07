import 'package:fundora/models/message_model.dart';

final investors = [
  {
    "name": "David Chapelle",
    "location": "London",
    "imageUrl":
        "https://unchainedcrypto.com/wp-content/uploads/2023/07/pfp-nft.png",
  },
  {
    "name": "Sophia Martinez",
    "location": "New York",
    "imageUrl":
        "https://nftevening.com/wp-content/uploads/2022/04/BAYC-PFP-NFT.png",
  },
  {
    'name': 'Jane Doe',
    'location': 'New York',
    'imageUrl': 'https://cdn.wallpapersafari.com/81/41/mDOY7h.jpg',
  },
  {
    "name": "John Smith",
    "location": "San Francisco",
    "imageUrl": "https://i.redd.it/bcyq3rjk2w071.png",
  },
    {
    "name": "David Chapelle",
    "location": "London",
    "imageUrl":
        "https://unchainedcrypto.com/wp-content/uploads/2023/07/pfp-nft.png",
  },
  {
    "name": "Sophia Martinez",
    "location": "New York",
    "imageUrl":
        "https://nftevening.com/wp-content/uploads/2022/04/BAYC-PFP-NFT.png",
  },
  {
    'name': 'Jane Doe',
    'location': 'New York',
    'imageUrl': 'https://cdn.wallpapersafari.com/81/41/mDOY7h.jpg',
  },
  {
    "name": "John Smith",
    "location": "San Francisco",
    "imageUrl": "https://i.redd.it/bcyq3rjk2w071.png",
  },
];

/// Mock data for messages with whom messages have been exchanged
final List<Message> messages = [
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.I’ll send you the details.I’ll send you the details.I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  ),
  Message(
    name: 'John Doe',
    imageUrl:
        'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
    message: 'Hey, how are you?',
    userID: "1",
  ),
  Message(
      name: 'Jane Smith',
      imageUrl:
          'https://i.seadn.io/gae/jCQAQBNKmnS_AZ_2jTqBgBLIVYaRFxLX6COWo-HCHrYJ1cg04oBgDfHvOmpqsWbmUaSfBDHIdrwKtGnte3Ph_VwQPJYJ6VFtAf5B?auto=format&dpr=1&w=1000',
      message: 'Let’s catch up soon!',
      userID: '2'),
  Message(
    name: 'Alice Johnson',
    imageUrl: '',
    message: 'I’ll send you the details.',
    userID: '1',
  )
];
